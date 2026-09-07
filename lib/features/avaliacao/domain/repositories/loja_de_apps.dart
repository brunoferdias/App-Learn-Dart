/// A loja vista pelo domínio: só o que o app precisa saber fazer.
///
/// Quem implementa (a App Store via SKStoreReviewController) fica na camada
/// data — o domínio não conhece plugin nenhum.
abstract interface class LojaDeApps {
  /// A loja está disponível neste aparelho para o pedido dentro do app?
  Future<bool> aceitaPedidoNativo();

  /// Mostra a caixa de avaliação nativa, sem sair do app.
  Future<void> pedirAvaliacao();

  /// Abre a ficha do app na loja, na tela de escrever avaliação.
  Future<void> abrirFichaParaAvaliar();
}
