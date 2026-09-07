import 'package:aprenda_dart/features/avaliacao/domain/entities/estado_avaliacao.dart';
import 'package:aprenda_dart/features/avaliacao/domain/entities/momento_avaliacao.dart';
import 'package:aprenda_dart/features/avaliacao/domain/entities/politica_avaliacao.dart';
import 'package:flutter_test/flutter_test.dart';

final DateTime hoje = DateTime(2026, 9, 7);

EstadoAvaliacao estadoPronto({
  int pontos = PoliticaAvaliacao.pontosParaPerguntar,
  int pedidos = 0,
  DateTime? ultimoPedidoEm,
  bool encerrado = false,
}) => EstadoAvaliacao(
  primeiroUsoEm: hoje.subtract(const Duration(days: 30)),
  pontos: pontos,
  pedidos: pedidos,
  ultimoPedidoEm: ultimoPedidoEm,
  encerrado: encerrado,
);

void main() {
  group('a política só libera o pedido na hora certa', () {
    test('libera quem já usa há dias e acumulou momentos bons', () {
      expect(PoliticaAvaliacao.podePedir(estadoPronto(), agora: hoje), isTrue);
    });

    test('não pede a quem acabou de instalar', () {
      final recemChegado = estadoPronto().copiarCom(
        primeiroUsoEm: hoje.subtract(const Duration(days: 1)),
      );

      expect(PoliticaAvaliacao.podePedir(recemChegado, agora: hoje), isFalse);
    });

    test('não pede antes de a pessoa terminar coisas suficientes', () {
      final poucosPontos = estadoPronto(
        pontos: PoliticaAvaliacao.pontosParaPerguntar - 1,
      );

      expect(PoliticaAvaliacao.podePedir(poucosPontos, agora: hoje), isFalse);
    });

    test('não pede sem saber quando o app foi aberto pela primeira vez', () {
      const semInicio = EstadoAvaliacao(pontos: 99);

      expect(PoliticaAvaliacao.podePedir(semInicio, agora: hoje), isFalse);
    });
  });

  group('um pedido ignorado não vira insistência', () {
    test('nada de segundo pedido dentro do intervalo', () {
      final recemPedido = estadoPronto(
        pedidos: 1,
        ultimoPedidoEm: hoje.subtract(const Duration(days: 30)),
      );

      expect(PoliticaAvaliacao.podePedir(recemPedido, agora: hoje), isFalse);
    });

    test('passado o intervalo, e com novos momentos bons, pode de novo', () {
      final fazTempo = estadoPronto(
        pedidos: 1,
        ultimoPedidoEm: hoje.subtract(
          PoliticaAvaliacao.intervaloEntrePedidos + const Duration(days: 1),
        ),
      );

      expect(PoliticaAvaliacao.podePedir(fazTempo, agora: hoje), isTrue);
    });

    test('o limite de pedidos na vida do app é respeitado', () {
      final noLimite = estadoPronto(
        pedidos: PoliticaAvaliacao.limiteDePedidos,
        ultimoPedidoEm: hoje.subtract(const Duration(days: 900)),
      );

      expect(PoliticaAvaliacao.podePedir(noLimite, agora: hoje), isFalse);
    });

    test('quem avaliou pelo perfil nunca mais é perguntado', () {
      expect(
        PoliticaAvaliacao.podePedir(estadoPronto(encerrado: true), agora: hoje),
        isFalse,
      );
    });
  });

  group('a contagem de momentos', () {
    test('cada momento soma o próprio peso', () {
      const zerado = EstadoAvaliacao();

      final depois = zerado
          .comMomento(MomentoAvaliacao.licaoConcluida)
          .comMomento(MomentoAvaliacao.quizPerfeito);

      expect(depois.pontos, 4);
    });

    test('pedir zera os pontos, para o próximo pedido custar tudo de novo', () {
      final depois = estadoPronto(pontos: 12).comPedidoEm(hoje);

      expect(depois.pontos, 0);
      expect(depois.pedidos, 1);
      expect(depois.ultimoPedidoEm, hoje);
    });

    test('um quiz mediano sozinho não chega ao pedido', () {
      var estado = EstadoAvaliacao(
        primeiroUsoEm: hoje.subtract(const Duration(days: 30)),
      );
      estado = estado.comMomento(MomentoAvaliacao.quizComBomDesempenho);

      expect(PoliticaAvaliacao.podePedir(estado, agora: hoje), isFalse);
    });
  });
}
