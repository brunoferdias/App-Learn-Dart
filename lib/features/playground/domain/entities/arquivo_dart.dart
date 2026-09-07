class ArquivoDart {
  const ArquivoDart({
    required this.id,
    required this.nome,
    required this.conteudo,
  });

  final String id;
  final String nome;
  final String conteudo;

  bool get temMain => RegExp(r'\bmain\s*\(').hasMatch(conteudo);

  int get linhas => '\n'.allMatches(conteudo).length + 1;

  ArquivoDart copiarCom({String? nome, String? conteudo}) => ArquivoDart(
    id: id,
    nome: nome ?? this.nome,
    conteudo: conteudo ?? this.conteudo,
  );
}
