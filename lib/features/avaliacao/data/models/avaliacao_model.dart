import '../../../../core/preferencias/preferencias.dart';
import '../../domain/entities/estado_avaliacao.dart';

/// Traduz o [EstadoAvaliacao] de e para o mapa cru que vai ao disco.
///
/// As datas viram texto ISO-8601 porque é o formato que `DateTime.parse`
/// entende de volta sem ambiguidade de fuso.
abstract final class AvaliacaoModel {
  static EstadoAvaliacao deMapa(Map<String, Object?> mapa) {
    return EstadoAvaliacao(
      primeiroUsoEm: _data(mapa[ChavesPref.avaliacaoPrimeiroUso]),
      pontos: mapa[ChavesPref.avaliacaoPontos] as int? ?? 0,
      pedidos: mapa[ChavesPref.avaliacaoPedidos] as int? ?? 0,
      ultimoPedidoEm: _data(mapa[ChavesPref.avaliacaoUltimoPedido]),
      encerrado: mapa[ChavesPref.avaliacaoEncerrada] as bool? ?? false,
    );
  }

  static Map<String, Object?> paraMapa(EstadoAvaliacao estado) => {
    ChavesPref.avaliacaoPrimeiroUso: estado.primeiroUsoEm?.toIso8601String(),
    ChavesPref.avaliacaoPontos: estado.pontos,
    ChavesPref.avaliacaoPedidos: estado.pedidos,
    ChavesPref.avaliacaoUltimoPedido: estado.ultimoPedidoEm?.toIso8601String(),
    ChavesPref.avaliacaoEncerrada: estado.encerrado,
  };

  static DateTime? _data(Object? valor) =>
      valor is String ? DateTime.tryParse(valor) : null;
}
