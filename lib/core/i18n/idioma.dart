enum Idioma {
  portugues('pt', 'Português', 'Português (Brasil)'),
  ingles('en', 'English', 'English (US)');

  const Idioma(this.codigo, this.nome, this.nomeCompleto);

  final String codigo;

  final String nome;

  final String nomeCompleto;

  bool get ehIngles => this == Idioma.ingles;

  static Idioma deCodigo(String? codigo) => Idioma.values.firstWhere(
    (i) => i.codigo == codigo,
    orElse: () => Idioma.portugues,
  );

  static Idioma doSistema(String codigoDoSistema) =>
      codigoDoSistema.toLowerCase().startsWith('pt')
      ? Idioma.portugues
      : Idioma.ingles;
}
