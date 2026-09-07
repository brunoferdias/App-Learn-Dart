import 'package:aprenda_dart/features/progresso/data/models/progresso_model.dart';
import 'package:aprenda_dart/features/progresso/domain/entities/progresso.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Progresso', () {
    test('aproveitamento não divide por zero quando ninguém respondeu', () {
      const p = Progresso();
      expect(p.totalRespondido, 0);
      expect(p.aproveitamento, 0);
      expect(p.percentual, 0);
    });

    test('calcula o percentual corretamente', () {
      const p = Progresso(acertos: 3, erros: 1);
      expect(p.percentual, 75);
    });

    test('copiarCom mantém o que não foi informado', () {
      const original = Progresso(acertos: 2, erros: 1);
      final novo = original.copiarCom(acertos: 5);

      expect(novo.acertos, 5);
      expect(novo.erros, 1);
    });
  });

  group('ProgressoModel (serialização)', () {
    test('ida e volta pelo Map preserva os dados', () {
      const original = ProgressoModel(
        licoesConcluidas: {'funcoes', 'null-safety'},
        acertos: 4,
        erros: 2,
      );

      final mapa = original.paraMapa();
      final reconstruido = ProgressoModel.deMapa(mapa);

      expect(reconstruido.acertos, 4);
      expect(reconstruido.erros, 2);
      expect(reconstruido.licoesConcluidas, contains('funcoes'));
    });

    test('um Map vazio vira um progresso zerado, sem quebrar', () {
      final vazio = ProgressoModel.deMapa(const {});
      expect(vazio.acertos, 0);
      expect(vazio.licoesConcluidas, isEmpty);
    });
  });
}
