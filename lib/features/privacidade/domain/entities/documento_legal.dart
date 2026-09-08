/// A política de privacidade e os termos de uso, do jeito que a tela precisa
/// deles: um cabeçalho, um resumo e partes numeradas.
///
/// O texto mora dentro do app, e não numa página da internet, pelo mesmo
/// motivo das lições: o Aprenda Dart funciona offline e não abre conexão por
/// conta própria — inclusive para mostrar a política que diz isso.
class DocumentoLegal {
  const DocumentoLegal({
    required this.atualizadoEm,
    required this.contato,
    required this.resumo,
    required this.partes,
  });

  final String atualizadoEm;
  final String contato;

  /// A política inteira em uma frase, para quem não vai ler o resto.
  final String resumo;

  final List<ParteLegal> partes;
}

class ParteLegal {
  const ParteLegal({required this.titulo, required this.clausulas});

  final String titulo;
  final List<ClausulaLegal> clausulas;
}

class ClausulaLegal {
  const ClausulaLegal({
    required this.numero,
    required this.titulo,
    required this.paragrafos,
    this.itens = const [],
  });

  final int numero;
  final String titulo;

  /// Aceitam a marcação de [TextoRico]: `**negrito**` e crases para código.
  final List<String> paragrafos;

  /// A lista com marcadores que vem depois dos parágrafos, quando existe.
  final List<String> itens;
}
