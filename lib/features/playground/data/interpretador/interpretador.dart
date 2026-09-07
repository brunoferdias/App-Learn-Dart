import 'ast.dart';
import 'biblioteca.dart';
import 'erro_dart.dart';
import 'mensagens.dart';
import 'token.dart';
import 'valores.dart';

class FuncaoNativa {
  const FuncaoNativa(this.nome, this.executar);
  final String nome;
  final Object? Function(List<Object?> argumentos, Token token) executar;

  @override
  String toString() => 'Closure: $nome';
}

class Interpretador {
  Interpretador({
    required this.msg,
    this.maxPassos = 2000000,
    this.maxLinhas = 500,
  });

  final MensagensDart msg;

  final int maxPassos;
  final int maxLinhas;

  final List<String> saida = [];
  late final Ambiente _globais = Ambiente();
  late final Biblioteca _lib = Biblioteca(
    invocar: (funcao, args) => _invocarValor(funcao, args, _tokenAtual),
    formatar: formatar,
    msg: msg,
  );

  int _passos = 0;
  Token _tokenAtual = const Token(
    tipo: TipoToken.fim,
    lexema: '',
    linha: 1,
    coluna: 1,
  );

  List<String> executar(List<Comando> programa) {
    _prepararGlobais();

    for (final comando in programa) {
      switch (comando) {
        case FuncaoComando(:final nome, :final parametros, :final corpo):
          _globais.declarar(
            nome,
            FuncaoDart(
              nome: nome,
              parametros: parametros,
              corpo: corpo,
              fechamento: _globais,
            ),
          );
        case ClasseComando():
          _globais.declarar(comando.nome, _montarClasse(comando));
        case ImportComando():
          break;
        default:
          break;
      }
    }

    for (final comando in programa) {
      if (comando is DeclaracaoVariavelComando) {
        _executar(comando, _globais);
      }
    }

    final main = _globais.ler('main');
    if (main is! FuncaoDart) {
      throw ErroDart(msg.semMain, linha: 1, coluna: 1, dica: msg.semMainDica);
    }
    _invocarFuncao(main, const [], const {}, _tokenAtual);
    return saida;
  }

  void _prepararGlobais() {
    for (final tipo in const [
      'int',
      'double',
      'num',
      'String',
      'List',
      'Map',
      'Set',
      'bool',
      'Object',
    ]) {
      _globais.declarar(tipo, EstaticoDart(tipo));
    }

    _globais.declarar(
      'print',
      FuncaoNativa('print', (args, token) {
        if (saida.length >= maxLinhas) {
          throw ErroDart(
            msg.muitasLinhas(maxLinhas),
            linha: token.linha,
            coluna: token.coluna,
            arquivo: token.arquivo,
            dica: msg.muitasLinhasDica,
          );
        }
        saida.add(args.isEmpty ? '' : formatar(args.first));
        return null;
      }),
    );

    for (final tipo in tiposDeExcecao) {
      _globais.declarar(
        tipo,
        FuncaoNativa(
          tipo,
          (args, _) => ExcecaoDart(tipo, args.isEmpty ? null : args.first),
        ),
      );
    }
  }

  String formatar(Object? valor) {
    switch (valor) {
      case null:
        return 'null';
      case String s:
        return s;
      case bool b:
        return b ? 'true' : 'false';
      case int n:
        return n.toString();
      case double d:
        return d.toString();
      case List<Object?> l:
        return '[${l.map(formatar).join(', ')}]';
      case Set<Object?> s:
        return '{${s.map(formatar).join(', ')}}';
      case Map<Object?, Object?> m:
        final itens = m.entries.map(
          (e) => '${formatar(e.key)}: ${formatar(e.value)}',
        );
        return '{${itens.join(', ')}}';
      case ParChaveValor p:
        return 'MapEntry(${formatar(p.chave)}: ${formatar(p.valor)})';
      case InstanciaDart i:
        final metodo = i.classe.metodos['toString'];
        if (metodo != null) {
          final f = FuncaoDart(
            nome: 'toString',
            parametros: metodo.parametros,
            corpo: metodo.corpo,
            fechamento: i.classe.fechamento,
            esteObjeto: i,
          );
          return formatar(_invocarFuncao(f, const [], const {}, _tokenAtual));
        }
        return "Instance of '${i.classe.nome}'";
      default:
        return valor.toString();
    }
  }

  Never _erro(String mensagem, Token t, {String? dica}) {
    throw ErroDart(
      mensagem,
      linha: t.linha,
      coluna: t.coluna,
      dica: dica,
      arquivo: t.arquivo,
    );
  }

  void _contar(Token t) {
    _tokenAtual = t;
    if (++_passos > maxPassos) {
      throw ErroDart(
        msg.rodandoDemais,
        linha: t.linha,
        coluna: t.coluna,
        arquivo: t.arquivo,
        dica: msg.rodandoDemaisDica,
      );
    }
  }

  void _executarBloco(List<Comando> comandos, Ambiente ambiente) {
    for (final c in comandos) {
      _executar(c, ambiente);
    }
  }

  void _executar(Comando comando, Ambiente ambiente) {
    _contar(comando.token);

    switch (comando) {
      case ExpressaoComando(:final expressao):
        _avaliar(expressao, ambiente);

      case DeclaracaoVariavelComando(
        :final nome,
        :final inicial,
        :final ehFinal,
        :final tipoAnotado,
      ):
        final valor = inicial == null ? null : _avaliar(inicial, ambiente);
        if (tipoAnotado != null && inicial != null) {
          _verificarTipo(tipoAnotado, valor, comando.token, nome);
        }
        ambiente.declarar(
          nome,
          _ajustarParaTipo(tipoAnotado, valor),
          ehFinal: ehFinal,
        );

      case BlocoComando(:final comandos):
        _executarBloco(comandos, Ambiente(ambiente));

      case SeComando(:final condicao, :final entao, :final senao):
        if (_condicao(condicao, ambiente)) {
          _executar(entao, ambiente);
        } else if (senao != null) {
          _executar(senao, ambiente);
        }

      case EnquantoComando(:final condicao, :final corpo):
        while (_condicao(condicao, ambiente)) {
          _contar(comando.token);
          try {
            _executar(corpo, Ambiente(ambiente));
          } on SinalQuebra {
            break;
          } on SinalContinua {
            continue;
          }
        }

      case FacaEnquantoComando(:final corpo, :final condicao):
        do {
          _contar(comando.token);
          try {
            _executar(corpo, Ambiente(ambiente));
          } on SinalQuebra {
            break;
          } on SinalContinua {
            continue;
          }
        } while (_condicao(condicao, ambiente));

      case ParaComando(
        :final inicializador,
        :final condicao,
        :final incrementos,
        :final corpo,
      ):
        final escopo = Ambiente(ambiente);
        if (inicializador != null) _executar(inicializador, escopo);
        while (condicao == null || _condicao(condicao, escopo)) {
          _contar(comando.token);
          try {
            _executar(corpo, Ambiente(escopo));
          } on SinalQuebra {
            break;
          } on SinalContinua catch (_) {}
          for (final inc in incrementos) {
            _avaliar(inc, escopo);
          }
        }

      case ParaEmComando(:final variavel, :final iteravel, :final corpo):
        final colecao = _avaliar(iteravel, ambiente);
        final itens = switch (colecao) {
          List<Object?> l => l,
          Set<Object?> s => s.toList(),
          Map<Object?, Object?> m => m.keys.toList(),
          String s => s.split(''),
          null => _erro(msg.forInNull, comando.token, dica: msg.forInNullDica),
          _ => _erro(msg.forInSoColecoes, comando.token),
        };
        for (final item in itens) {
          _contar(comando.token);
          final escopo = Ambiente(ambiente);
          escopo.declarar(variavel, item, ehFinal: true);
          try {
            _executar(corpo, escopo);
          } on SinalQuebra {
            break;
          } on SinalContinua {
            continue;
          }
        }

      case RetornoComando(:final valor):
        throw SinalRetorno(valor == null ? null : _avaliar(valor, ambiente));

      case QuebraComando():
        throw const SinalQuebra();

      case ContinuaComando():
        throw const SinalContinua();

      case LancaComando(:final valor):
        throw LancamentoDoUsuario(_avaliar(valor, ambiente));

      case EscolhaComando(:final valor, :final casos, :final padrao):
        final alvo = _avaliar(valor, ambiente);
        var executou = false;
        try {
          for (final caso in casos) {
            for (final opcao in caso.valores) {
              if (_saoIguais(alvo, _avaliar(opcao, ambiente))) {
                _executarBloco(caso.comandos, Ambiente(ambiente));
                executou = true;
                break;
              }
            }
            if (executou) break;
          }
          if (!executou && padrao != null) {
            _executarBloco(padrao, Ambiente(ambiente));
          }
        } on SinalQuebra catch (_) {}

      case TenteComando(
        :final corpo,
        :final nomeErro,
        :final captura,
        :final finalmente,
      ):
        try {
          _executarBloco(corpo, Ambiente(ambiente));
        } on LancamentoDoUsuario catch (e) {
          if (captura == null) rethrow;
          final escopo = Ambiente(ambiente);
          if (nomeErro != null) escopo.declarar(nomeErro, e.valor);
          _executarBloco(captura, escopo);
        } on ErroDart catch (e) {
          if (captura == null) rethrow;
          final escopo = Ambiente(ambiente);
          if (nomeErro != null) {
            escopo.declarar(nomeErro, ExcecaoDart('Erro', e.mensagem));
          }
          _executarBloco(captura, escopo);
        } finally {
          if (finalmente != null) {
            _executarBloco(finalmente, Ambiente(ambiente));
          }
        }

      case FuncaoComando(:final nome, :final parametros, :final corpo):
        ambiente.declarar(
          nome,
          FuncaoDart(
            nome: nome,
            parametros: parametros,
            corpo: corpo,
            fechamento: ambiente,
          ),
        );

      case ClasseComando():
        ambiente.declarar(comando.nome, _montarClasse(comando));

      case ImportComando():
        break;
    }
  }

  bool _instanciaTem(InstanciaDart i, String nome) =>
      i.campos.containsKey(nome) ||
      i.classe.getters.containsKey(nome) ||
      i.classe.metodos.containsKey(nome);

  ClasseDart _montarClasse(ClasseComando c) => ClasseDart(
    nome: c.nome,
    campos: c.campos,
    metodos: {for (final m in c.metodos) m.nome: m},
    getters: {for (final g in c.getters) g.nome: g},
    construtor: c.construtor,
    fechamento: _globais,
  );

  bool _condicao(Expressao expr, Ambiente ambiente) {
    final valor = _avaliar(expr, ambiente);
    if (valor is bool) return valor;
    _erro(
      msg.condicaoPrecisaBool(formatar(valor)),
      expr.token,
      dica: msg.condicaoPrecisaBoolDica,
    );
  }

  void _verificarTipo(String tipo, Object? valor, Token t, String nome) {
    final anulavel = tipo.endsWith('?');
    final base = (anulavel ? tipo.substring(0, tipo.length - 1) : tipo)
        .split('<')
        .first;

    if (base == 'dynamic' || base == 'Object' || base == 'var') return;

    if (valor == null) {
      if (anulavel) return;
      _erro(
        msg.naoAceitaNull(nome, base),
        t,
        dica: msg.naoAceitaNullDica(base),
      );
    }

    final combina = switch (base) {
      'int' => valor is int,
      'double' => valor is double || valor is int,
      'num' => valor is num,
      'String' => valor is String,
      'bool' => valor is bool,
      'List' => valor is List,
      'Map' => valor is Map,
      'Set' => valor is Set,
      'Function' => valor is FuncaoDart || valor is FuncaoNativa,
      _ => true,
    };

    if (!combina) {
      _erro(
        msg.tipoIncompativel(nome, base, _nomeDoTipo(valor)),
        t,
        dica: msg.tipoIncompativelDica,
      );
    }
  }

  Object? _ajustarParaTipo(String? tipo, Object? valor) {
    if (tipo == null) return valor;
    final base = tipo.replaceAll('?', '').split('<').first;
    if (base == 'double' && valor is int) return valor.toDouble();
    return valor;
  }

  String _nomeDoTipo(Object? v) => switch (v) {
    null => 'null',
    int() => 'int',
    double() => 'double',
    String() => 'String',
    bool() => 'bool',
    List() => 'List',
    Set() => 'Set',
    Map() => 'Map',
    FuncaoDart() || FuncaoNativa() => 'Function',
    InstanciaDart(:final classe) => classe.nome,
    _ => 'valor',
  };

  Object? _avaliar(Expressao expr, Ambiente ambiente) {
    _contar(expr.token);

    switch (expr) {
      case LiteralExpr(:final valor):
        return valor;

      case TextoExpr(:final partes):
        final buffer = StringBuffer();
        for (final parte in partes) {
          if (parte is String) {
            buffer.write(parte);
          } else {
            buffer.write(formatar(_avaliar(parte as Expressao, ambiente)));
          }
        }
        return buffer.toString();

      case ListaExpr(:final elementos):
        final lista = <Object?>[];
        for (final e in elementos) {
          _acumularElemento(e, lista, ambiente);
        }
        return lista;

      case MapaExpr(:final entradas):
        final mapa = <Object?, Object?>{};
        for (final e in entradas) {
          mapa[_avaliar(e.chave, ambiente)] = _avaliar(e.valor, ambiente);
        }
        return mapa;

      case VariavelExpr(:final nome):
        if (!ambiente.existe(nome)) {
          final esteObj = ambiente.ler('this');
          if (esteObj is InstanciaDart && _instanciaTem(esteObj, nome)) {
            return _lerMembro(esteObj, nome, expr.token);
          }
          _erro(
            msg.variavelNaoDefinida(nome),
            expr.token,
            dica: msg.variavelNaoDefinidaDica(nome),
          );
        }
        return ambiente.ler(nome);

      case EsteExpr():
        final esteObj = ambiente.ler('this');
        if (esteObj == null) {
          _erro(msg.thisForaDeClasse, expr.token);
        }
        return esteObj;

      case AtribuicaoExpr():
        return _atribuir(expr, ambiente);

      case UnariaExpr(:final operador, :final operando):
        final v = _avaliar(operando, ambiente);
        if (operador == '-') {
          if (v is num) return -v;
          _erro(msg.menosSoNumeros, expr.token);
        }
        if (v is bool) return !v;
        _erro(msg.naoSoBool, expr.token);

      case BangExpr(:final operando):
        final v = _avaliar(operando, ambiente);
        if (v == null) {
          _erro(msg.bangEmNull, expr.token, dica: msg.bangEmNullDica);
        }
        return v;

      case IncrementoExpr(:final alvo, :final operador, :final prefixado):
        final antes = _avaliar(alvo, ambiente);
        if (antes is! num) {
          _erro(msg.operadorSoNumeros(operador), expr.token);
        }
        final depois = operador == '++' ? antes + 1 : antes - 1;
        _gravarEm(alvo, depois, ambiente, expr.token);
        return prefixado ? depois : antes;

      case LogicaExpr(:final esquerda, :final operador, :final direita):
        final e = _avaliar(esquerda, ambiente);
        switch (operador) {
          case '??':
            return e ?? _avaliar(direita, ambiente);
          case '&&':
            if (e != true) return false;
            return _avaliar(direita, ambiente) == true;
          default:
            if (e == true) return true;
            return _avaliar(direita, ambiente) == true;
        }

      case BinariaExpr(:final esquerda, :final operador, :final direita):
        return _binaria(
          operador,
          _avaliar(esquerda, ambiente),
          _avaliar(direita, ambiente),
          expr.token,
        );

      case TernarioExpr(:final condicao, :final entao, :final senao):
        return _condicao(condicao, ambiente)
            ? _avaliar(entao, ambiente)
            : _avaliar(senao, ambiente);

      case TesteTipoExpr(:final objeto, :final tipo, :final negado):
        final v = _avaliar(objeto, ambiente);
        final resultado = switch (tipo) {
          'int' => v is int,
          'double' => v is double,
          'num' => v is num,
          'String' => v is String,
          'bool' => v is bool,
          'List' => v is List,
          'Map' => v is Map,
          'Set' => v is Set,
          'Null' => v == null,
          'Object' => v != null,
          _ => v is InstanciaDart && v.classe.nome == tipo,
        };
        return negado ? !resultado : resultado;

      case FuncaoAnonimaExpr(:final parametros, :final corpo):
        return FuncaoDart(
          nome: '<anônima>',
          parametros: parametros,
          corpo: corpo,
          fechamento: ambiente,
        );

      case IndiceExpr(:final objeto, :final indice):
        final alvo = _avaliar(objeto, ambiente);
        final i = _avaliar(indice, ambiente);
        return _lerIndice(alvo, i, expr.token);

      case MembroExpr(:final objeto, :final nome, :final anulavel):
        final alvo = _avaliar(objeto, ambiente);
        if (alvo == null && anulavel) return null;
        return _lerMembro(alvo, nome, expr.token);

      case ChamadaExpr():
        return _chamada(expr, ambiente);
    }
  }

  void _acumularElemento(
    ElementoColecao elemento,
    List<Object?> destino,
    Ambiente ambiente,
  ) {
    switch (elemento) {
      case ElementoValor(:final valor):
        destino.add(_avaliar(valor, ambiente));

      case ElementoEspalhar(:final valor, :final anulavel):
        final v = _avaliar(valor, ambiente);
        if (v == null) {
          if (anulavel) return;
          _erro(msg.espalharNull, valor.token, dica: msg.espalharNullDica);
        }
        if (v is Iterable<Object?>) {
          destino.addAll(v);
        } else {
          _erro(msg.espalharSoListas, valor.token);
        }

      case ElementoSe(:final condicao, :final entao, :final senao):
        if (_condicao(condicao, ambiente)) {
          _acumularElemento(entao, destino, ambiente);
        } else if (senao != null) {
          _acumularElemento(senao, destino, ambiente);
        }

      case ElementoPara(:final variavel, :final iteravel, :final corpo):
        final colecao = _avaliar(iteravel, ambiente);
        if (colecao is! Iterable<Object?>) {
          _erro(msg.forNaListaPrecisaLista, iteravel.token);
        }
        for (final item in colecao) {
          final escopo = Ambiente(ambiente);
          escopo.declarar(variavel, item, ehFinal: true);
          _acumularElemento(corpo, destino, escopo);
        }
    }
  }

  Object? _binaria(String op, Object? e, Object? d, Token t) {
    if (op == '==') return _saoIguais(e, d);
    if (op == '!=') return !_saoIguais(e, d);

    if (op == '+') {
      if (e is String && d is String) return e + d;
      if (e is String || d is String) {
        _erro(
          msg.somarTextoCom(_nomeDoTipo(e is String ? d : e)),
          t,
          dica: msg.somarTextoComDica,
        );
      }
      if (e is List<Object?> && d is List<Object?>) return [...e, ...d];
    }

    if (e == null || d == null) {
      _erro(msg.operadorComNull(op), t, dica: msg.operadorComNullDica);
    }

    if (e is! num || d is! num) {
      _erro(msg.operadorSoEntreNumeros(op, _nomeDoTipo(e), _nomeDoTipo(d)), t);
    }

    switch (op) {
      case '+':
        return e + d;
      case '-':
        return e - d;
      case '*':
        return e * d;
      case '/':
        if (d == 0) {
          _erro(msg.divisaoPorZero, t, dica: msg.divisaoPorZeroDica);
        }
        return e / d;
      case '~/':
        if (d == 0) _erro(msg.divisaoInteiraPorZero, t);
        return e ~/ d;
      case '%':
        if (d == 0) _erro(msg.restoPorZero, t);
        return e % d;
      case '<':
        return e < d;
      case '>':
        return e > d;
      case '<=':
        return e <= d;
      case '>=':
        return e >= d;
    }
    _erro(msg.operadorDesconhecido(op), t);
  }

  bool _saoIguais(Object? a, Object? b) {
    if (a == null || b == null) return a == null && b == null;
    if (a is num && b is num) return a == b;
    return identical(a, b) || a == b;
  }

  Object? _lerIndice(Object? alvo, Object? indice, Token t) {
    switch (alvo) {
      case null:
        _erro(msg.colchetesEmNull, t, dica: msg.colchetesEmNullDica);
      case List<Object?> l:
        if (indice is! int) {
          _erro(msg.indiceListaPrecisaInt, t);
        }
        if (indice < 0 || indice >= l.length) {
          _erro(
            msg.rangeErrorLista(indice, l.length),
            t,
            dica: l.isEmpty
                ? msg.listaVaziaDica
                : msg.indicesValidos(l.length - 1),
          );
        }
        return l[indice];
      case Map<Object?, Object?> m:
        return m[indice];
      case String s:
        if (indice is! int) _erro(msg.indiceTextoPrecisaInt, t);
        if (indice < 0 || indice >= s.length) {
          _erro(msg.rangeErrorTexto(s.length), t);
        }
        return s[indice];
    }
    _erro(msg.naoAceitaColchetes, t);
  }

  Object? _lerMembro(Object? alvo, String nome, Token t) {
    if (alvo == null) {
      _erro(msg.acessoEmNull(nome), t, dica: msg.acessoEmNullDica);
    }

    if (alvo is InstanciaDart) {
      if (alvo.campos.containsKey(nome)) return alvo.campos[nome];

      final getter = alvo.classe.getters[nome];
      if (getter != null) {
        final f = FuncaoDart(
          nome: nome,
          parametros: const [],
          corpo: getter.corpo,
          fechamento: alvo.classe.fechamento,
          esteObjeto: alvo,
        );
        return _invocarFuncao(f, const [], const {}, t);
      }

      final metodo = alvo.classe.metodos[nome];
      if (metodo != null) {
        return FuncaoDart(
          nome: nome,
          parametros: metodo.parametros,
          corpo: metodo.corpo,
          fechamento: alvo.classe.fechamento,
          esteObjeto: alvo,
        );
      }

      _erro(
        msg.classeNaoTem(alvo.classe.nome, nome),
        t,
        dica: msg.classeNaoTemDica,
      );
    }

    if (alvo is EstaticoDart) {
      return _MembroEstatico(alvo, nome);
    }

    final valor = _lib.propriedade(alvo, nome, t);
    if (!identical(valor, Biblioteca.naoEncontrado)) return valor;

    return _MetodoLigado(alvo, nome);
  }

  Object? _chamada(ChamadaExpr expr, Ambiente ambiente) {
    final alvo = expr.alvo;

    final argumentos = [for (final a in expr.argumentos) _avaliar(a, ambiente)];
    final nomeados = {
      for (final e in expr.argumentosNomeados.entries)
        e.key: _avaliar(e.value, ambiente),
    };

    if (alvo is MembroExpr) {
      final receptor = _avaliar(alvo.objeto, ambiente);
      if (receptor == null && alvo.anulavel) return null;

      if (receptor == null) {
        _erro(
          msg.chamadaEmNull(alvo.nome),
          expr.token,
          dica: msg.chamadaEmNullDica,
        );
      }

      if (receptor is InstanciaDart) {
        final metodo = receptor.classe.metodos[alvo.nome];
        if (metodo != null) {
          final f = FuncaoDart(
            nome: alvo.nome,
            parametros: metodo.parametros,
            corpo: metodo.corpo,
            fechamento: receptor.classe.fechamento,
            esteObjeto: receptor,
          );
          return _invocarFuncao(f, argumentos, nomeados, expr.token);
        }
        final campo = receptor.campos[alvo.nome];
        if (campo != null) {
          return _invocarValor(campo, argumentos, expr.token);
        }
        _erro(
          msg.classeNaoTemMetodo(receptor.classe.nome, alvo.nome),
          expr.token,
        );
      }

      if (receptor is EstaticoDart) {
        return _lib.metodo(
          receptor,
          alvo.nome,
          argumentos,
          nomeados,
          expr.token,
        );
      }

      return _lib.metodo(receptor, alvo.nome, argumentos, nomeados, expr.token);
    }

    if (alvo is VariavelExpr && !ambiente.existe(alvo.nome)) {
      final esteObj = ambiente.ler('this');
      if (esteObj is InstanciaDart && _instanciaTem(esteObj, alvo.nome)) {
        final metodo = _lerMembro(esteObj, alvo.nome, expr.token);
        return _invocarComNomeados(metodo, argumentos, nomeados, expr.token);
      }
    }

    final funcao = _avaliar(alvo, ambiente);
    return _invocarComNomeados(funcao, argumentos, nomeados, expr.token);
  }

  Object? _invocarComNomeados(
    Object? funcao,
    List<Object?> argumentos,
    Map<String, Object?> nomeados,
    Token t,
  ) {
    switch (funcao) {
      case FuncaoDart f:
        return _invocarFuncao(f, argumentos, nomeados, t);
      case FuncaoNativa n:
        return n.executar(argumentos, t);
      case ClasseDart c:
        return _instanciar(c, argumentos, nomeados, t);
      case _MembroEstatico m:
        return _lib.metodo(m.tipo, m.nome, argumentos, nomeados, t);
      case _MetodoLigado m:
        return _lib.metodo(m.alvo, m.nome, argumentos, nomeados, t);
      case null:
        _erro(msg.chamouAlgoNulo, t, dica: msg.chamouAlgoNuloDica);
      default:
        _erro(msg.naoEhFuncao, t);
    }
  }

  Object? _invocarValor(Object? funcao, List<Object?> argumentos, Token t) =>
      _invocarComNomeados(funcao, argumentos, const {}, t);

  Object? _invocarFuncao(
    FuncaoDart funcao,
    List<Object?> posicionais,
    Map<String, Object?> nomeados,
    Token t,
  ) {
    final ambiente = Ambiente(funcao.fechamento);
    final esteObj = funcao.esteObjeto;
    if (esteObj != null) ambiente.declarar('this', esteObj);

    _ligarParametros(
      funcao.parametros,
      posicionais,
      nomeados,
      ambiente,
      t,
      contexto: funcao.nome,
    );

    try {
      _executarBloco(funcao.corpo, ambiente);
    } on SinalRetorno catch (r) {
      return r.valor;
    }
    return null;
  }

  void _ligarParametros(
    List<Parametro> parametros,
    List<Object?> posicionais,
    Map<String, Object?> nomeados,
    Ambiente ambiente,
    Token t, {
    required String contexto,
    InstanciaDart? instancia,
  }) {
    final soPosicionais = parametros.where((p) => !p.ehNomeado).toList();
    final obrigatorios = soPosicionais.where((p) => p.obrigatorio).length;

    if (posicionais.length < obrigatorios) {
      _erro(
        msg.poucosArgumentos(contexto, obrigatorios, posicionais.length),
        t,
        dica: msg.poucosArgumentosDica,
      );
    }
    if (posicionais.length > soPosicionais.length) {
      _erro(
        msg.muitosArgumentos(
          contexto,
          posicionais.length,
          soPosicionais.length,
        ),
        t,
      );
    }

    for (var i = 0; i < soPosicionais.length; i++) {
      final p = soPosicionais[i];
      final valor = i < posicionais.length
          ? posicionais[i]
          : (p.padrao == null ? null : _avaliar(p.padrao!, ambiente));
      _definirParametro(p, valor, ambiente, instancia);
    }

    for (final p in parametros.where((p) => p.ehNomeado)) {
      if (nomeados.containsKey(p.nome)) {
        _definirParametro(p, nomeados[p.nome], ambiente, instancia);
      } else if (p.padrao != null) {
        _definirParametro(
          p,
          _avaliar(p.padrao!, ambiente),
          ambiente,
          instancia,
        );
      } else if (p.obrigatorio) {
        _erro(
          msg.faltouArgumentoNomeado(p.nome, contexto),
          t,
          dica: msg.faltouArgumentoNomeadoDica(contexto, p.nome),
        );
      } else {
        _definirParametro(p, null, ambiente, instancia);
      }
    }

    for (final nome in nomeados.keys) {
      if (!parametros.any((p) => p.ehNomeado && p.nome == nome)) {
        _erro(msg.semParametroChamado(contexto, nome), t);
      }
    }
  }

  void _definirParametro(
    Parametro p,
    Object? valor,
    Ambiente ambiente,
    InstanciaDart? instancia,
  ) {
    ambiente.declarar(p.nome, valor);
    if (p.ehCampoThis && instancia != null) {
      instancia.campos[p.nome] = valor;
    }
  }

  InstanciaDart _instanciar(
    ClasseDart classe,
    List<Object?> posicionais,
    Map<String, Object?> nomeados,
    Token t,
  ) {
    final instancia = InstanciaDart(classe);

    for (final campo in classe.campos) {
      instancia.campos[campo.nome] = campo.inicial == null
          ? null
          : _avaliar(campo.inicial!, classe.fechamento);
    }

    final construtor = classe.construtor;
    if (construtor == null) {
      if (posicionais.isNotEmpty || nomeados.isNotEmpty) {
        _erro(msg.construtorSemArgumentos(classe.nome), t);
      }
      return instancia;
    }

    final ambiente = Ambiente(classe.fechamento);
    ambiente.declarar('this', instancia);
    _ligarParametros(
      construtor.parametros,
      posicionais,
      nomeados,
      ambiente,
      t,
      contexto: classe.nome,
      instancia: instancia,
    );

    try {
      _executarBloco(construtor.corpo, ambiente);
    } on SinalRetorno catch (_) {}
    return instancia;
  }

  Object? _atribuir(AtribuicaoExpr expr, Ambiente ambiente) {
    final alvo = expr.alvo;

    if (expr.operador == '??=') {
      final atual = _avaliarSeguro(alvo, ambiente);
      if (atual != null) return atual;
      final novo = _avaliar(expr.valor, ambiente);
      _gravarEm(alvo, novo, ambiente, expr.token);
      return novo;
    }

    var novo = _avaliar(expr.valor, ambiente);

    if (expr.operador != '=') {
      final atual = _avaliar(alvo, ambiente);
      final op = expr.operador.substring(0, expr.operador.length - 1);
      novo = _binaria(op, atual, novo, expr.token);
    }

    _gravarEm(alvo, novo, ambiente, expr.token);
    return novo;
  }

  Object? _avaliarSeguro(Expressao alvo, Ambiente ambiente) {
    if (alvo is VariavelExpr && !ambiente.existe(alvo.nome)) return null;
    return _avaliar(alvo, ambiente);
  }

  void _gravarEm(Expressao alvo, Object? valor, Ambiente ambiente, Token t) {
    switch (alvo) {
      case VariavelExpr(:final nome):
        if (!ambiente.existe(nome)) {
          final esteObj = ambiente.ler('this');
          if (esteObj is InstanciaDart && esteObj.campos.containsKey(nome)) {
            esteObj.campos[nome] = valor;
            return;
          }
          _erro(
            msg.variavelNaoDeclarada(nome),
            t,
            dica: msg.variavelNaoDeclaradaDica(nome),
          );
        }
        if (ambiente.ehFinal(nome)) {
          _erro(
            msg.variavelFinalJaTemValor(nome),
            t,
            dica: msg.variavelFinalDica,
          );
        }
        ambiente.atribuir(nome, valor);

      case MembroExpr(:final objeto, :final nome):
        final receptor = _avaliar(objeto, ambiente);
        if (receptor is InstanciaDart) {
          receptor.campos[nome] = valor;
          return;
        }
        _erro(msg.naoDaParaAlterar(nome), t);

      case IndiceExpr(:final objeto, :final indice):
        final receptor = _avaliar(objeto, ambiente);
        final i = _avaliar(indice, ambiente);
        switch (receptor) {
          case List<Object?> l:
            if (i is! int || i < 0 || i >= l.length) {
              _erro(msg.rangeErrorAtribuicao(l.length), t);
            }
            l[i] = valor;
          case Map<Object?, Object?> m:
            m[i] = valor;
          default:
            _erro(msg.naoAceitaAtribuicaoColchetes, t);
        }

      default:
        _erro(msg.naoDaParaAtribuirValor, t);
    }
  }
}

class _MembroEstatico {
  const _MembroEstatico(this.tipo, this.nome);
  final EstaticoDart tipo;
  final String nome;
}

class _MetodoLigado {
  const _MetodoLigado(this.alvo, this.nome);
  final Object? alvo;
  final String nome;
}
