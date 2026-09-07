enum TipoToken { numero, texto, identificador, palavraChave, simbolo, fim }

class ParteTexto {
  const ParteTexto(this.conteudo, {this.ehExpressao = false});

  final String conteudo;
  final bool ehExpressao;
}

class Token {
  const Token({
    required this.tipo,
    required this.lexema,
    required this.linha,
    required this.coluna,
    this.valor,
    this.arquivo = '',
  });

  final TipoToken tipo;

  final String lexema;

  final Object? valor;

  final int linha;
  final int coluna;

  final String arquivo;

  bool ehSimbolo(String s) => tipo == TipoToken.simbolo && lexema == s;
  bool ehPalavra(String p) => tipo == TipoToken.palavraChave && lexema == p;

  @override
  String toString() => '$tipo("$lexema") @ $linha:$coluna';
}

const Set<String> palavrasChave = {
  'var',
  'final',
  'const',
  'late',
  'dynamic',
  'if',
  'else',
  'for',
  'in',
  'while',
  'do',
  'switch',
  'case',
  'default',
  'break',
  'continue',
  'return',
  'true',
  'false',
  'null',
  'class',
  'extends',
  'this',
  'super',
  'new',
  'get',
  'set',
  'static',
  'void',
  'required',
  'is',
  'as',
  'try',
  'catch',
  'finally',
  'throw',
  'on',
  'rethrow',
  'async',
  'await',
  'yield',
  'sync',
  'enum',
  'typedef',
  'abstract',
  'interface',
  'sealed',
  'mixin',
  'with',
  'import',
  'export',
  'part',
  'library',
  'show',
  'hide',
  'factory',
  'operator',
  'assert',
  'covariant',
  'external',
  'implements',
};
