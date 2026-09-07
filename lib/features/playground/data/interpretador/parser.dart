import 'ast.dart';
import 'erro_dart.dart';
import 'lexer.dart';
import 'mensagens.dart';
import 'token.dart';

class Parser {
  Parser(this.tokens, {required this.msg});

  final List<Token> tokens;

  final MensagensDart msg;
  int _pos = 0;

  Token get _atual => tokens[_pos];
  Token get _anterior => tokens[_pos - 1];
  bool get _acabou => _atual.tipo == TipoToken.fim;

  Token _avancar() => tokens[_pos++];

  bool _conferir(String lexema) =>
      !_acabou && (_atual.ehSimbolo(lexema) || _atual.ehPalavra(lexema));

  bool _casar(String lexema) {
    if (_conferir(lexema)) {
      _avancar();
      return true;
    }
    return false;
  }

  Token _exigir(String lexema, {String? dica}) {
    if (_conferir(lexema)) return _avancar();
    _erro(msg.esperava(lexema, _descrever(_atual)), dica: dica);
  }

  String _descrever(Token t) => switch (t.tipo) {
    TipoToken.fim => msg.fimDoArquivo,
    TipoToken.texto => msg.umTexto,
    _ => '"${t.lexema}"',
  };

  Never _erro(String mensagem, {String? dica, Token? onde}) {
    final t = onde ?? _atual;
    throw ErroDart(
      mensagem,
      linha: t.linha,
      coluna: t.coluna,
      dica: dica,
      arquivo: t.arquivo,
      fase: FaseErro.sintatica,
    );
  }

  List<Comando> analisar() {
    final comandos = <Comando>[];
    while (!_acabou) {
      comandos.add(_declaracaoDeTopo());
    }
    return comandos;
  }

  Comando _declaracaoDeTopo() {
    if (_conferir('import') || _conferir('export') || _conferir('part')) {
      return _importar();
    }
    if (_conferir('class') ||
        _conferir('abstract') ||
        _conferir('final') && tokens[_pos + 1].ehPalavra('class') ||
        _conferir('sealed') ||
        _conferir('interface')) {
      return _classe();
    }
    return _comando();
  }

  Comando _importar() {
    final inicio = _avancar();
    if (_atual.tipo != TipoToken.texto) {
      _erro(msg.importPrecisaCaminho);
    }
    final t = _avancar();
    final partes = t.valor! as List<ParteTexto>;
    final caminho = partes.map((p) => p.conteudo).join();
    while (!_acabou && !_conferir(';')) {
      _avancar();
    }
    _exigir(';');
    return ImportComando(inicio, caminho);
  }

  Comando _classe() {
    while (_casar('abstract') ||
        _casar('final') ||
        _casar('sealed') ||
        _casar('interface') ||
        _casar('base')) {}

    final inicio = _exigir('class');
    if (_atual.tipo != TipoToken.identificador) {
      _erro(msg.esperavaNomeClasse);
    }
    final nome = _avancar().lexema;

    if (_conferir('extends') || _conferir('implements') || _conferir('with')) {
      _erro(msg.herancaNaoSuportada, dica: msg.herancaNaoSuportadaDica);
    }

    _exigir('{', dica: 'O corpo da classe começa com {');

    final campos = <CampoClasse>[];
    final metodos = <FuncaoComando>[];
    final getters = <FuncaoComando>[];
    ConstrutorClasse? construtor;

    while (!_conferir('}') && !_acabou) {
      _casar('static');
      _casar('const');
      _casar('factory');

      if (_atual.tipo == TipoToken.identificador &&
          _atual.lexema == nome &&
          tokens[_pos + 1].ehSimbolo('(')) {
        _avancar();
        final params = _parametros(permitirThis: true);
        List<Comando> corpo = const [];
        if (_conferir('{')) {
          corpo = _bloco().comandos;
        } else {
          _exigir(';', dica: 'Construtor sem corpo termina com ;');
        }
        construtor = ConstrutorClasse(params, corpo);
        continue;
      }

      _casar('late');
      _casar('final');
      _casar('var');
      _tentarTipo();

      if (_casar('get')) {
        final nomeGetter = _avancar().lexema;
        final corpo = _corpoDeFuncao();
        getters.add(FuncaoComando(_anterior, nomeGetter, const [], corpo));
        continue;
      }

      if (_atual.tipo != TipoToken.identificador) {
        _erro(msg.esperavaMembroClasse);
      }
      final nomeMembro = _avancar().lexema;

      if (_conferir('(')) {
        final params = _parametros();
        final corpo = _corpoDeFuncao();
        metodos.add(FuncaoComando(_anterior, nomeMembro, params, corpo));
      } else {
        Expressao? inicial;
        if (_casar('=')) inicial = _expressao();
        _exigir(';', dica: 'Toda declaração de campo termina com ;');
        campos.add(CampoClasse(nomeMembro, inicial));
      }
    }

    _exigir('}');
    return ClasseComando(
      inicio,
      nome,
      campos: campos,
      metodos: metodos,
      getters: getters,
      construtor: construtor,
    );
  }

  Comando _comando() {
    if (_conferir('async') || _conferir('await')) {
      _erro(msg.asyncNaoSuportado, dica: msg.asyncNaoSuportadoDica);
    }

    if (_conferir('{')) return _bloco();
    if (_conferir('if')) return _se();
    if (_conferir('while')) return _enquanto();
    if (_conferir('do')) return _facaEnquanto();
    if (_conferir('for')) return _para();
    if (_conferir('switch')) return _escolha();
    if (_conferir('try')) return _tente();
    if (_conferir('return')) return _retorno();
    if (_conferir('throw')) return _lanca();

    if (_conferir('break')) {
      final t = _avancar();
      _exigir(';');
      return QuebraComando(t);
    }
    if (_conferir('continue')) {
      final t = _avancar();
      _exigir(';');
      return ContinuaComando(t);
    }

    final declaracao = _tentarDeclaracao();
    if (declaracao != null) return declaracao;

    final expr = _expressao();
    _exigir(';', dica: 'Em Dart, todo comando termina com ponto e vírgula.');
    return ExpressaoComando(expr.token, expr);
  }

  Comando? _tentarDeclaracao() {
    final marca = _pos;

    final ehVar = _conferir('var') || _conferir('final') || _conferir('const');
    var ehFinal = false;
    String? tipo;

    if (ehVar) {
      final palavra = _avancar().lexema;
      ehFinal = palavra != 'var';
      _casar('late');
      tipo = _tentarTipo();
    } else {
      _casar('late');
      tipo = _tentarTipo();
      if (tipo == null) {
        _pos = marca;
        return null;
      }
    }

    if (_atual.tipo != TipoToken.identificador) {
      _pos = marca;
      return null;
    }

    final nomeToken = _avancar();
    final nome = nomeToken.lexema;

    if (_conferir('(')) {
      if (ehVar) {
        _pos = marca;
        return null;
      }
      final params = _parametros();
      final corpo = _corpoDeFuncao();
      return FuncaoComando(nomeToken, nome, params, corpo);
    }

    if (_conferir('=') || _conferir(';')) {
      Expressao? inicial;
      if (_casar('=')) inicial = _expressao();
      _exigir(
        ';',
        dica: 'Em Dart, toda declaração termina com ponto e vírgula.',
      );
      return DeclaracaoVariavelComando(
        nomeToken,
        nome,
        inicial,
        ehFinal: ehFinal,
        tipoAnotado: tipo,
      );
    }

    _pos = marca;
    return null;
  }

  String? _tentarTipo() {
    final marca = _pos;

    if (_conferir('void') || _conferir('dynamic')) {
      return _avancar().lexema;
    }
    if (_atual.tipo != TipoToken.identificador) return null;

    final buffer = StringBuffer(_avancar().lexema);

    if (_conferir('<')) {
      var profundidade = 0;
      final inicio = _pos;
      while (!_acabou) {
        if (_conferir('<')) profundidade++;
        if (_conferir('>')) {
          profundidade--;
          if (profundidade == 0) {
            _avancar();
            break;
          }
        }
        _avancar();
        if (_pos - inicio > 40) {
          _pos = marca;
          return null;
        }
      }
      if (profundidade > 0) {
        _pos = marca;
        return null;
      }
      buffer.write('<...>');
    }

    if (_casar('?')) buffer.write('?');

    if (_atual.tipo == TipoToken.identificador || _conferir('get')) {
      return buffer.toString();
    }

    _pos = marca;
    return null;
  }

  BlocoComando _bloco() {
    final inicio = _exigir('{');
    final comandos = <Comando>[];
    while (!_conferir('}') && !_acabou) {
      comandos.add(_comando());
    }
    _exigir('}', dica: 'Faltou fechar uma chave { em algum lugar.');
    return BlocoComando(inicio, comandos);
  }

  List<Comando> _corpoDeFuncao({bool comPontoEVirgula = true}) {
    if (_casar('=>')) {
      final expr = _expressao();
      if (comPontoEVirgula) _exigir(';');
      return [RetornoComando(expr.token, expr)];
    }
    if (_conferir('{')) return _bloco().comandos;
    _erro(msg.esperavaCorpoFuncao, dica: msg.esperavaCorpoFuncaoDica);
  }

  Comando _se() {
    final inicio = _exigir('if');
    _exigir('(');
    final condicao = _expressao();
    _exigir(')');
    final entao = _comando();
    Comando? senao;
    if (_casar('else')) senao = _comando();
    return SeComando(inicio, condicao, entao, senao);
  }

  Comando _enquanto() {
    final inicio = _exigir('while');
    _exigir('(');
    final condicao = _expressao();
    _exigir(')');
    return EnquantoComando(inicio, condicao, _comando());
  }

  Comando _facaEnquanto() {
    final inicio = _exigir('do');
    final corpo = _comando();
    _exigir('while');
    _exigir('(');
    final condicao = _expressao();
    _exigir(')');
    _exigir(';');
    return FacaEnquantoComando(inicio, corpo, condicao);
  }

  Comando _para() {
    final inicio = _exigir('for');
    _exigir('(');

    final marca = _pos;
    _casar('var');
    _casar('final');
    _tentarTipo();
    if (_atual.tipo == TipoToken.identificador &&
        tokens[_pos + 1].ehPalavra('in')) {
      final variavel = _avancar().lexema;
      _exigir('in');
      final iteravel = _expressao();
      _exigir(')');
      return ParaEmComando(inicio, variavel, iteravel, _comando());
    }
    _pos = marca;

    Comando? inicializador;
    if (!_conferir(';')) {
      inicializador = _tentarDeclaracao();
      if (inicializador == null) {
        final e = _expressao();
        _exigir(';');
        inicializador = ExpressaoComando(e.token, e);
      }
    } else {
      _exigir(';');
    }

    Expressao? condicao;
    if (!_conferir(';')) condicao = _expressao();
    _exigir(';');

    final incrementos = <Expressao>[];
    if (!_conferir(')')) {
      do {
        incrementos.add(_expressao());
      } while (_casar(','));
    }
    _exigir(')');

    return ParaComando(
      inicio,
      inicializador,
      condicao,
      incrementos,
      _comando(),
    );
  }

  Comando _escolha() {
    final inicio = _exigir('switch');
    _exigir('(');
    final valor = _expressao();
    _exigir(')');
    _exigir('{');

    final casos = <CasoEscolha>[];
    List<Comando>? padrao;

    while (!_conferir('}') && !_acabou) {
      if (_casar('case')) {
        final valores = <Expressao>[_expressao()];
        _exigir(':');
        while (_conferir('case')) {
          _avancar();
          valores.add(_expressao());
          _exigir(':');
        }
        final corpo = <Comando>[];
        while (!_conferir('case') &&
            !_conferir('default') &&
            !_conferir('}') &&
            !_acabou) {
          corpo.add(_comando());
        }
        casos.add(CasoEscolha(valores, corpo));
      } else if (_casar('default')) {
        _exigir(':');
        final corpo = <Comando>[];
        while (!_conferir('case') && !_conferir('}') && !_acabou) {
          corpo.add(_comando());
        }
        padrao = corpo;
      } else {
        _erro(msg.switchSoCaseDefault);
      }
    }

    _exigir('}');
    return EscolhaComando(inicio, valor, casos, padrao);
  }

  Comando _tente() {
    final inicio = _exigir('try');
    final corpo = _bloco().comandos;

    String? nomeErro;
    List<Comando>? captura;
    List<Comando>? finalmente;

    if (_conferir('on')) {
      _avancar();
      _tentarTipo() ?? _avancar().lexema;
    }
    if (_casar('catch')) {
      _exigir('(');
      nomeErro = _avancar().lexema;
      if (_casar(',')) _avancar();
      _exigir(')');
      captura = _bloco().comandos;
    }
    if (_casar('finally')) {
      finalmente = _bloco().comandos;
    }

    if (captura == null && finalmente == null) {
      _erro(msg.tryPrecisaCatchFinally);
    }
    return TenteComando(inicio, corpo, nomeErro, captura, finalmente);
  }

  Comando _retorno() {
    final inicio = _exigir('return');
    Expressao? valor;
    if (!_conferir(';')) valor = _expressao();
    _exigir(';');
    return RetornoComando(inicio, valor);
  }

  Comando _lanca() {
    final inicio = _exigir('throw');
    final valor = _expressao();
    _exigir(';');
    return LancaComando(inicio, valor);
  }

  List<Parametro> _parametros({bool permitirThis = false}) {
    _exigir('(');
    final lista = <Parametro>[];

    while (!_conferir(')') && !_acabou) {
      if (_casar('[')) {
        while (!_conferir(']') && !_acabou) {
          lista.add(
            _umParametro(
              nomeado: false,
              obrigatorio: false,
              permitirThis: permitirThis,
            ),
          );
          if (!_casar(',')) break;
        }
        _exigir(']');
      } else if (_casar('{')) {
        while (!_conferir('}') && !_acabou) {
          final req = _casar('required');
          lista.add(
            _umParametro(
              nomeado: true,
              obrigatorio: req,
              permitirThis: permitirThis,
            ),
          );
          if (!_casar(',')) break;
        }
        _exigir('}');
      } else {
        lista.add(
          _umParametro(
            nomeado: false,
            obrigatorio: true,
            permitirThis: permitirThis,
          ),
        );
        if (!_casar(',')) break;
      }
    }

    _exigir(')');
    return lista;
  }

  Parametro _umParametro({
    required bool nomeado,
    required bool obrigatorio,
    required bool permitirThis,
  }) {
    _casar('final');
    _casar('const');

    var ehThis = false;
    if (_conferir('this')) {
      if (!permitirThis) {
        _erro(msg.thisSoEmConstrutor);
      }
      _avancar();
      _exigir('.');
      ehThis = true;
    } else {
      _tentarTipo();
    }

    if (_atual.tipo != TipoToken.identificador) {
      _erro(msg.esperavaNomeParametro);
    }
    final nome = _avancar().lexema;

    Expressao? padrao;
    if (_casar('=')) padrao = _expressao();

    return Parametro(
      nome,
      padrao: padrao,
      ehNomeado: nomeado,
      obrigatorio: obrigatorio && padrao == null,
      ehCampoThis: ehThis,
    );
  }

  Expressao _expressao() => _atribuicao();

  Expressao _atribuicao() {
    final esquerda = _ternario();

    for (final op in const ['=', '+=', '-=', '*=', '/=', '%=', '??=']) {
      if (_conferir(op)) {
        final t = _avancar();
        final valor = _atribuicao();
        if (esquerda is VariavelExpr ||
            esquerda is MembroExpr ||
            esquerda is IndiceExpr) {
          return AtribuicaoExpr(t, esquerda, op, valor);
        }
        _erro(msg.naoDaParaAtribuir, onde: t);
      }
    }
    return esquerda;
  }

  Expressao _ternario() {
    final condicao = _seNulo();
    if (_conferir('?')) {
      final t = _avancar();
      final entao = _expressao();
      _exigir(':', dica: 'O ternário tem a forma: condicao ? valorA : valorB');
      final senao = _expressao();
      return TernarioExpr(t, condicao, entao, senao);
    }
    return condicao;
  }

  Expressao _seNulo() {
    var esquerda = _ou();
    while (_conferir('??')) {
      final t = _avancar();
      esquerda = LogicaExpr(t, esquerda, '??', _ou());
    }
    return esquerda;
  }

  Expressao _ou() {
    var esquerda = _e();
    while (_conferir('||')) {
      final t = _avancar();
      esquerda = LogicaExpr(t, esquerda, '||', _e());
    }
    return esquerda;
  }

  Expressao _e() {
    var esquerda = _igualdade();
    while (_conferir('&&')) {
      final t = _avancar();
      esquerda = LogicaExpr(t, esquerda, '&&', _igualdade());
    }
    return esquerda;
  }

  Expressao _igualdade() {
    var esquerda = _comparacao();
    while (_conferir('==') || _conferir('!=')) {
      final t = _avancar();
      esquerda = BinariaExpr(t, esquerda, t.lexema, _comparacao());
    }
    return esquerda;
  }

  Expressao _comparacao() {
    var esquerda = _adicao();
    while (true) {
      if (_conferir('is')) {
        final t = _avancar();
        final negado = _casar('!');
        final tipo = _tentarTipoSimples();
        esquerda = TesteTipoExpr(t, esquerda, tipo, negado: negado);
        continue;
      }
      if (_conferir('as')) {
        _avancar();
        _tentarTipoSimples();
        continue;
      }
      if (_conferir('<') ||
          _conferir('>') ||
          _conferir('<=') ||
          _conferir('>=')) {
        final t = _avancar();
        esquerda = BinariaExpr(t, esquerda, t.lexema, _adicao());
        continue;
      }
      return esquerda;
    }
  }

  String _tentarTipoSimples() {
    if (_atual.tipo == TipoToken.identificador ||
        _conferir('void') ||
        _conferir('dynamic')) {
      final nome = _avancar().lexema;
      if (_casar('<')) {
        var p = 1;
        while (!_acabou && p > 0) {
          if (_conferir('<')) p++;
          if (_conferir('>')) p--;
          _avancar();
        }
      }
      _casar('?');
      return nome;
    }
    _erro(msg.esperavaTipoAposIs);
  }

  Expressao _adicao() {
    var esquerda = _multiplicacao();
    while (_conferir('+') || _conferir('-')) {
      final t = _avancar();
      esquerda = BinariaExpr(t, esquerda, t.lexema, _multiplicacao());
    }
    return esquerda;
  }

  Expressao _multiplicacao() {
    var esquerda = _unaria();
    while (_conferir('*') ||
        _conferir('/') ||
        _conferir('%') ||
        _conferir('~/')) {
      final t = _avancar();
      esquerda = BinariaExpr(t, esquerda, t.lexema, _unaria());
    }
    return esquerda;
  }

  Expressao _unaria() {
    if (_conferir('!') || _conferir('-')) {
      final t = _avancar();
      return UnariaExpr(t, t.lexema, _unaria());
    }
    if (_conferir('++') || _conferir('--')) {
      final t = _avancar();
      final alvo = _unaria();
      return IncrementoExpr(t, alvo, t.lexema, prefixado: true);
    }
    return _posfixo();
  }

  Expressao _posfixo() {
    var expr = _primaria();

    while (true) {
      if (_conferir('(')) {
        expr = _finalizarChamada(expr);
      } else if (_conferir('.') || _conferir('?.')) {
        final t = _avancar();
        if (_atual.tipo != TipoToken.identificador && !_conferir('get')) {
          _erro(msg.esperavaMembroAposPonto);
        }
        final nome = _avancar().lexema;
        expr = MembroExpr(t, expr, nome, anulavel: t.lexema == '?.');
      } else if (_conferir('[')) {
        final t = _avancar();
        final indice = _expressao();
        _exigir(']');
        expr = IndiceExpr(t, expr, indice);
      } else if (_conferir('!')) {
        final t = _avancar();
        expr = BangExpr(t, expr);
      } else if (_conferir('++') || _conferir('--')) {
        final t = _avancar();
        expr = IncrementoExpr(t, expr, t.lexema, prefixado: false);
      } else {
        return expr;
      }
    }
  }

  Expressao _finalizarChamada(Expressao alvo) {
    final t = _exigir('(');
    final posicionais = <Expressao>[];
    final nomeados = <String, Expressao>{};

    while (!_conferir(')') && !_acabou) {
      if (_atual.tipo == TipoToken.identificador &&
          tokens[_pos + 1].ehSimbolo(':')) {
        final nome = _avancar().lexema;
        _avancar();
        nomeados[nome] = _expressao();
      } else {
        posicionais.add(_expressao());
      }
      if (!_casar(',')) break;
    }

    _exigir(')', dica: 'Faltou fechar o parêntese da chamada.');
    return ChamadaExpr(t, alvo, posicionais, nomeados);
  }

  Expressao _primaria() {
    final t = _atual;

    if (_casar('true')) return LiteralExpr(t, true);
    if (_casar('false')) return LiteralExpr(t, false);
    if (_casar('null')) return LiteralExpr(t, null);
    if (_casar('this')) return EsteExpr(t);
    if (_casar('new')) return _primaria();
    if (_casar('const')) return _primaria();

    if (t.tipo == TipoToken.numero) {
      _avancar();
      return LiteralExpr(t, t.valor);
    }

    if (t.tipo == TipoToken.texto) {
      _avancar();
      return _montarTexto(t);
    }

    if (t.tipo == TipoToken.identificador) {
      _avancar();
      return VariavelExpr(t, t.lexema);
    }

    if (_conferir('[')) return _lista();
    if (_conferir('{')) return _mapa();

    if (_conferir('(')) {
      final anonima = _tentarFuncaoAnonima();
      if (anonima != null) return anonima;

      _avancar();
      final dentro = _expressao();
      _exigir(')');
      return dentro;
    }

    _erro(msg.naoEntendi(_descrever(t)), dica: msg.naoEntendiDica);
  }

  FuncaoAnonimaExpr? _tentarFuncaoAnonima() {
    final marca = _pos;
    try {
      final params = _parametros();
      if (_conferir('=>') || _conferir('{')) {
        final corpo = _corpoDeFuncao(comPontoEVirgula: false);
        return FuncaoAnonimaExpr(tokens[marca], params, corpo);
      }
    } on ErroDart catch (_) {}
    _pos = marca;
    return null;
  }

  Expressao _montarTexto(Token t) {
    final partes = t.valor! as List<ParteTexto>;

    if (partes.every((p) => !p.ehExpressao)) {
      return LiteralExpr(t, partes.map((p) => p.conteudo).join());
    }

    final montadas = <Object>[];
    for (final parte in partes) {
      if (!parte.ehExpressao) {
        montadas.add(parte.conteudo);
        continue;
      }
      final subTokens = Lexer(
        parte.conteudo,
        msg: msg,
        arquivo: t.arquivo,
      ).tokenizar();
      montadas.add(Parser(subTokens, msg: msg)._expressao());
    }
    return TextoExpr(t, montadas);
  }

  Expressao _lista() {
    final inicio = _exigir('[');
    final elementos = <ElementoColecao>[];
    while (!_conferir(']') && !_acabou) {
      elementos.add(_elementoColecao());
      if (!_casar(',')) break;
    }
    _exigir(']', dica: 'Faltou fechar o colchete da lista.');
    return ListaExpr(inicio, elementos);
  }

  ElementoColecao _elementoColecao() {
    if (_conferir('...')) {
      _avancar();
      final anulavel = _casar('?');
      return ElementoEspalhar(_expressao(), anulavel: anulavel);
    }
    if (_conferir('if')) {
      _avancar();
      _exigir('(');
      final condicao = _expressao();
      _exigir(')');
      final entao = _elementoColecao();
      ElementoColecao? senao;
      if (_casar('else')) senao = _elementoColecao();
      return ElementoSe(condicao, entao, senao);
    }
    if (_conferir('for')) {
      _avancar();
      _exigir('(');
      _casar('var');
      _casar('final');
      _tentarTipo();
      final variavel = _avancar().lexema;
      _exigir('in');
      final iteravel = _expressao();
      _exigir(')');
      return ElementoPara(variavel, iteravel, _elementoColecao());
    }
    return ElementoValor(_expressao());
  }

  Expressao _mapa() {
    final inicio = _exigir('{');
    final entradas = <EntradaMapa>[];
    while (!_conferir('}') && !_acabou) {
      final chave = _expressao();
      _exigir(':', dica: 'Um mapa tem a forma {chave: valor}.');
      entradas.add(EntradaMapa(chave, _expressao()));
      if (!_casar(',')) break;
    }
    _exigir('}', dica: 'Faltou fechar a chave do mapa.');
    return MapaExpr(inicio, entradas);
  }
}
