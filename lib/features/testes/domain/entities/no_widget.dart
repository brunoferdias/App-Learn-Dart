typedef NoLocalizado = ({String caminho, NoWidget no});

class NoWidget {
  const NoWidget(
    this.tipo, {
    this.texto,
    this.icone,
    this.chave,
    this.filhos = const [],
  });

  final String tipo;

  final String? texto;

  final String? icone;

  final String? chave;

  final List<NoWidget> filhos;

  static List<NoLocalizado> achatar(NoWidget raiz, [String caminho = '0']) {
    return [
      (caminho: caminho, no: raiz),
      for (final (indice, filho) in raiz.filhos.indexed)
        ...achatar(filho, '$caminho.$indice'),
    ];
  }

  String get rotulo => texto != null
      ? '$tipo("$texto")'
      : icone != null
      ? '$tipo(CupertinoIcons.$icone)'
      : tipo;
}
