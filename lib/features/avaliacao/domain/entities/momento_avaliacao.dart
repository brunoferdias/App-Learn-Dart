/// Os momentos em que faz sentido pensar em pedir uma avaliação.
///
/// Todos são pontos altos do uso — a pessoa acabou de terminar algo e está
/// satisfeita. O [peso] mede quanto cada um conta para a política: um quiz
/// perfeito vale mais que uma lição marcada como concluída.
enum MomentoAvaliacao {
  licaoConcluida(peso: 1),
  quizComBomDesempenho(peso: 2),
  quizPerfeito(peso: 3);

  const MomentoAvaliacao({required this.peso});

  final int peso;
}
