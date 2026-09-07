import 'estado_avaliacao.dart';

/// A regra de bom senso do pedido de avaliação, em Dart puro e sem Flutter.
///
/// A ideia é nunca interromper: o pedido só aparece depois de a pessoa usar o
/// app por dias, acumular vários momentos bons e sempre logo após terminar
/// algo. Se ela ignorar, esperamos meses; e são no máximo dois pedidos na vida
/// do app neste aparelho.
abstract final class PoliticaAvaliacao {
  /// Pontos necessários: dá, por exemplo, uma lição + dois quizzes bons.
  static const int pontosParaPerguntar = 5;

  /// Nada de pedir para quem acabou de instalar.
  static const Duration carencia = Duration(days: 3);

  /// Se o primeiro pedido não deu em nada, o segundo demora um trimestre.
  static const Duration intervaloEntrePedidos = Duration(days: 120);

  static const int limiteDePedidos = 2;

  static bool podePedir(EstadoAvaliacao estado, {required DateTime agora}) {
    if (estado.encerrado) return false;
    if (estado.pedidos >= limiteDePedidos) return false;
    if (estado.pontos < pontosParaPerguntar) return false;

    final primeiroUso = estado.primeiroUsoEm;
    if (primeiroUso == null) return false;
    if (agora.difference(primeiroUso) < carencia) return false;

    final ultimoPedido = estado.ultimoPedidoEm;
    if (ultimoPedido != null &&
        agora.difference(ultimoPedido) < intervaloEntrePedidos) {
      return false;
    }

    return true;
  }
}
