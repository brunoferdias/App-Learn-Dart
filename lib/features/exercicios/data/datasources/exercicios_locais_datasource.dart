import '../../../../core/i18n/idioma.dart';
import '../../domain/entities/exercicio.dart';
import 'banco/en/exercicios_parte1.dart';
import 'banco/en/exercicios_parte2.dart';
import 'banco/en/exercicios_parte3.dart';
import 'banco/pt/exercicios_parte1.dart';
import 'banco/pt/exercicios_parte2.dart';
import 'banco/pt/exercicios_parte3.dart';

abstract interface class ExerciciosLocaisDatasource {
  Future<List<Exercicio>> buscarTodos(Idioma idioma);
}

class ExerciciosEmMemoria implements ExerciciosLocaisDatasource {
  const ExerciciosEmMemoria();

  @override
  Future<List<Exercicio>> buscarTodos(Idioma idioma) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return switch (idioma) {
      Idioma.portugues => const [
        ...exerciciosParte1,
        ...exerciciosParte2,
        ...exerciciosParte3,
      ],
      Idioma.ingles => const [
        ...exerciciosParte1En,
        ...exerciciosParte2En,
        ...exerciciosParte3En,
      ],
    };
  }
}
