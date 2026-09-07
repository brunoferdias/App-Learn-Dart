class Progresso {
  const Progresso({
    this.licoesConcluidas = const {},
    this.acertos = 0,
    this.erros = 0,
  });

  final Set<String> licoesConcluidas;
  final int acertos;
  final int erros;

  int get totalRespondido => acertos + erros;

  double get aproveitamento =>
      totalRespondido == 0 ? 0 : acertos / totalRespondido;

  int get percentual => (aproveitamento * 100).round();

  bool concluiu(String licaoId) => licoesConcluidas.contains(licaoId);

  Progresso copiarCom({
    Set<String>? licoesConcluidas,
    int? acertos,
    int? erros,
  }) {
    return Progresso(
      licoesConcluidas: licoesConcluidas ?? this.licoesConcluidas,
      acertos: acertos ?? this.acertos,
      erros: erros ?? this.erros,
    );
  }
}
