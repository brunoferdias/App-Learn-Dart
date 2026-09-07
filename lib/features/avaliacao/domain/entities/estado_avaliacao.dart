import 'momento_avaliacao.dart';

/// O que o app lembra sobre avaliação entre uma abertura e outra.
///
/// Nada aqui identifica a pessoa: são só contadores e datas no aparelho.
class EstadoAvaliacao {
  const EstadoAvaliacao({
    this.primeiroUsoEm,
    this.pontos = 0,
    this.pedidos = 0,
    this.ultimoPedidoEm,
    this.encerrado = false,
  });

  /// Quando o app foi aberto pela primeira vez, para respeitar a carência.
  final DateTime? primeiroUsoEm;

  /// Soma dos pesos dos momentos bons desde o último pedido.
  final int pontos;

  /// Quantas vezes já pedimos a avaliação sozinhos.
  final int pedidos;

  final DateTime? ultimoPedidoEm;

  /// Ligado quando a pessoa avalia pelo botão do perfil: a partir daí o app
  /// nunca mais toma a iniciativa.
  final bool encerrado;

  EstadoAvaliacao copiarCom({
    DateTime? primeiroUsoEm,
    int? pontos,
    int? pedidos,
    DateTime? ultimoPedidoEm,
    bool? encerrado,
  }) {
    return EstadoAvaliacao(
      primeiroUsoEm: primeiroUsoEm ?? this.primeiroUsoEm,
      pontos: pontos ?? this.pontos,
      pedidos: pedidos ?? this.pedidos,
      ultimoPedidoEm: ultimoPedidoEm ?? this.ultimoPedidoEm,
      encerrado: encerrado ?? this.encerrado,
    );
  }

  EstadoAvaliacao comMomento(MomentoAvaliacao momento) =>
      copiarCom(pontos: pontos + momento.peso);

  /// Depois de pedir, os pontos voltam a zero: um eventual segundo pedido só
  /// vem depois de a pessoa usar o app de novo, e bastante.
  EstadoAvaliacao comPedidoEm(DateTime agora) =>
      copiarCom(pontos: 0, pedidos: pedidos + 1, ultimoPedidoEm: agora);

  EstadoAvaliacao encerrada() => copiarCom(encerrado: true);
}
