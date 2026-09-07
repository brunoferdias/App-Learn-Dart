import 'erro_dart.dart';
import 'mensagens.dart';
import 'token.dart';

const List<String> _simbolos3 = ['??=', '...', '~/='];
const List<String> _simbolos2 = [
  '??',
  '?.',
  '=>',
  '==',
  '!=',
  '>=',
  '<=',
  '&&',
  '||',
  '++',
  '--',
  '+=',
  '-=',
  '*=',
  '/=',
  '%=',
  '~/',
  '..',
];
const String _simbolos1 = r'+-*/%=<>!?:;,.()[]{}&|^~@#';

class Lexer {
  Lexer(this.fonte, {required this.msg, this.arquivo = ''});

  final String fonte;

  final MensagensDart msg;

  final String arquivo;

  int _pos = 0;
  int _linha = 1;
  int _coluna = 1;

  final List<Token> _tokens = [];

  bool get _acabou => _pos >= fonte.length;
  String get _atual => _acabou ? ' ' : fonte[_pos];

  String _espiar(int adiante) {
    final i = _pos + adiante;
    return i < fonte.length ? fonte[i] : ' ';
  }

  String _avancar() {
    final c = fonte[_pos++];
    if (c == '\n') {
      _linha++;
      _coluna = 1;
    } else {
      _coluna++;
    }
    return c;
  }

  Never _erro(String mensagem, {String? dica}) {
    throw ErroDart(
      mensagem,
      linha: _linha,
      coluna: _coluna,
      dica: dica,
      arquivo: arquivo,
      fase: FaseErro.lexica,
    );
  }

  List<Token> tokenizar() {
    while (!_acabou) {
      _pularEspacosEComentarios();
      if (_acabou) break;

      final linhaInicio = _linha;
      final colunaInicio = _coluna;
      final c = _atual;

      if (_ehDigito(c)) {
        _lerNumero(linhaInicio, colunaInicio);
      } else if (c == 'r' && (_espiar(1) == "'" || _espiar(1) == '"')) {
        _avancar();
        _lerTexto(linhaInicio, colunaInicio, cru: true);
      } else if (_ehLetra(c)) {
        _lerIdentificador(linhaInicio, colunaInicio);
      } else if (c == "'" || c == '"') {
        _lerTexto(linhaInicio, colunaInicio, cru: false);
      } else {
        _lerSimbolo(linhaInicio, colunaInicio);
      }
    }

    _tokens.add(
      Token(
        tipo: TipoToken.fim,
        lexema: '',
        linha: _linha,
        coluna: _coluna,
        arquivo: arquivo,
      ),
    );
    return _tokens;
  }

  bool _ehDigito(String c) {
    final u = c.codeUnitAt(0);
    return u >= 48 && u <= 57;
  }

  bool _ehLetra(String c) {
    final u = c.codeUnitAt(0);
    return (u >= 65 && u <= 90) ||
        (u >= 97 && u <= 122) ||
        c == '_' ||
        c == r'$';
  }

  bool _ehLetraOuDigito(String c) => _ehLetra(c) || _ehDigito(c);

  void _pularEspacosEComentarios() {
    while (!_acabou) {
      final c = _atual;
      if (c == ' ' || c == '\t' || c == '\r' || c == '\n') {
        _avancar();
      } else if (c == '/' && _espiar(1) == '/') {
        while (!_acabou && _atual != '\n') {
          _avancar();
        }
      } else if (c == '/' && _espiar(1) == '*') {
        _avancar();
        _avancar();
        var profundidade = 1;
        while (!_acabou && profundidade > 0) {
          if (_atual == '/' && _espiar(1) == '*') {
            profundidade++;
            _avancar();
            _avancar();
          } else if (_atual == '*' && _espiar(1) == '/') {
            profundidade--;
            _avancar();
            _avancar();
          } else {
            _avancar();
          }
        }
        if (profundidade > 0) {
          _erro(msg.comentarioNaoFechado, dica: msg.comentarioNaoFechadoDica);
        }
      } else {
        return;
      }
    }
  }

  void _lerNumero(int linha, int coluna) {
    final buffer = StringBuffer();
    while (!_acabou && _ehDigito(_atual)) {
      buffer.write(_avancar());
    }

    var ehDecimal = false;
    if (_atual == '.' && _ehDigito(_espiar(1))) {
      ehDecimal = true;
      buffer.write(_avancar());
      while (!_acabou && _ehDigito(_atual)) {
        buffer.write(_avancar());
      }
    }

    final texto = buffer.toString();
    _tokens.add(
      Token(
        tipo: TipoToken.numero,
        lexema: texto,
        valor: ehDecimal ? double.parse(texto) : int.parse(texto),
        linha: linha,
        coluna: coluna,
        arquivo: arquivo,
      ),
    );
  }

  void _lerIdentificador(int linha, int coluna) {
    final buffer = StringBuffer();
    while (!_acabou && _ehLetraOuDigito(_atual)) {
      buffer.write(_avancar());
    }
    final nome = buffer.toString();

    _tokens.add(
      Token(
        tipo: palavrasChave.contains(nome)
            ? TipoToken.palavraChave
            : TipoToken.identificador,
        lexema: nome,
        linha: linha,
        coluna: coluna,
        arquivo: arquivo,
      ),
    );
  }

  void _lerTexto(int linha, int coluna, {required bool cru}) {
    final aspas = _avancar();
    final triplo = _atual == aspas && _espiar(1) == aspas;
    if (triplo) {
      _avancar();
      _avancar();
    }

    final partes = <ParteTexto>[];
    final buffer = StringBuffer();

    void fecharLiteral() {
      if (buffer.isNotEmpty) {
        partes.add(ParteTexto(buffer.toString()));
        buffer.clear();
      }
    }

    while (true) {
      if (_acabou) {
        _erro(msg.textoNaoFechado, dica: msg.textoNaoFechadoDica(aspas));
      }

      if (_atual == aspas) {
        if (!triplo) {
          _avancar();
          break;
        }
        if (_espiar(1) == aspas && _espiar(2) == aspas) {
          _avancar();
          _avancar();
          _avancar();
          break;
        }
      }

      if (!triplo && _atual == '\n') {
        _erro(msg.textoQuebraLinha, dica: msg.textoQuebraLinhaDica);
      }

      if (!cru && _atual == r'\') {
        _avancar();
        final e = _avancar();
        buffer.write(switch (e) {
          'n' => '\n',
          't' => '\t',
          'r' => '\r',
          r'$' => r'$',
          r'\' => r'\',
          "'" => "'",
          '"' => '"',
          _ => e,
        });
        continue;
      }

      if (!cru && _atual == r'$') {
        _avancar();
        if (_atual == '{') {
          _avancar();
          final expr = StringBuffer();
          var profundidade = 1;
          while (!_acabou) {
            if (_atual == '{') profundidade++;
            if (_atual == '}') {
              profundidade--;
              if (profundidade == 0) {
                _avancar();
                break;
              }
            }
            expr.write(_avancar());
          }
          fecharLiteral();
          partes.add(ParteTexto(expr.toString(), ehExpressao: true));
        } else if (_ehLetra(_atual) && _atual != r'$') {
          final nome = StringBuffer();
          while (!_acabou && _ehLetraOuDigito(_atual) && _atual != r'$') {
            nome.write(_avancar());
          }
          fecharLiteral();
          partes.add(ParteTexto(nome.toString(), ehExpressao: true));
        } else {
          buffer.write(r'$');
        }
        continue;
      }

      buffer.write(_avancar());
    }

    fecharLiteral();
    _tokens.add(
      Token(
        tipo: TipoToken.texto,
        lexema: 'texto',
        valor: partes,
        linha: linha,
        coluna: coluna,
        arquivo: arquivo,
      ),
    );
  }

  void _lerSimbolo(int linha, int coluna) {
    for (final tamanho in const [3, 2]) {
      if (_pos + tamanho <= fonte.length) {
        final trecho = fonte.substring(_pos, _pos + tamanho);
        final lista = tamanho == 3 ? _simbolos3 : _simbolos2;
        if (lista.contains(trecho)) {
          for (var i = 0; i < tamanho; i++) {
            _avancar();
          }
          _tokens.add(
            Token(
              tipo: TipoToken.simbolo,
              lexema: trecho,
              linha: linha,
              coluna: coluna,
            ),
          );
          return;
        }
      }
    }

    final c = _avancar();
    if (!_simbolos1.contains(c)) {
      _erro(msg.caractereInesperado(c), dica: msg.caractereInesperadoDica);
    }
    _tokens.add(
      Token(
        tipo: TipoToken.simbolo,
        lexema: c,
        linha: linha,
        coluna: coluna,
        arquivo: arquivo,
      ),
    );
  }
}
