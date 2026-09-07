import '../entities/exercicio.dart';

class CorrigirExercicio {
  const CorrigirExercicio();

  ({bool acertou, int indiceCorreto, String explicacao}) call(
    Exercicio exercicio,
    int indiceEscolhido,
  ) {
    return (
      acertou: exercicio.acertou(indiceEscolhido),
      indiceCorreto: exercicio.indiceCorreto,
      explicacao: exercicio.explicacao,
    );
  }
}
