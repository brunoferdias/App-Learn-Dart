import 'package:aprenda_dart/features/exercicios/domain/entities/exercicio.dart';
import 'package:aprenda_dart/features/exercicios/domain/usecases/corrigir_exercicio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const corrigir = CorrigirExercicio();

  group('ExercicioCertoOuErrado', () {
    const exercicio = ExercicioCertoOuErrado(
      id: 't1',
      licaoId: 'null-safety',
      codigo: 'String nome = null;',
      estaCorreto: false,
      explicacao: 'String não aceita null.',
    );

    test('a resposta correta é "Está errado" (índice 1)', () {
      expect(exercicio.indiceCorreto, 1);
      expect(exercicio.acertou(1), isTrue);
      expect(exercicio.acertou(0), isFalse);
    });

    test('o caso de uso devolve o record com acerto e explicação', () {
      final r = corrigir(exercicio, 1);
      expect(r.acertou, isTrue);
      expect(r.explicacao, contains('não aceita null'));
    });
  });

  group('ExercicioCompletar', () {
    const exercicio = ExercicioCompletar(
      id: 't2',
      licaoId: 'funcoes',
      codigoComLacuna: 'void f({___ String texto}) {}',
      opcoes: ['required', 'final'],
      resposta: 0,
      explicacao: 'required obriga o argumento.',
    );

    test('preenche a lacuna com a opção escolhida', () {
      expect(
        exercicio.codigoPreenchido(0),
        'void f({required String texto}) {}',
      );
    });

    test('erra quando a opção não é a esperada', () {
      expect(corrigir(exercicio, 1).acertou, isFalse);
    });
  });
}
