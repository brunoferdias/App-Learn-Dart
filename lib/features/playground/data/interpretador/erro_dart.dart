class ErroDart implements Exception {
  const ErroDart(
    this.mensagem, {
    required this.linha,
    required this.coluna,
    this.dica,
    this.arquivo = '',
    this.fase = FaseErro.execucao,
  });

  final String mensagem;
  final int linha;
  final int coluna;

  final String? dica;

  final String arquivo;

  final FaseErro fase;

  @override
  String toString() => 'Linha $linha: $mensagem';
}

enum FaseErro { lexica, sintatica, execucao }
