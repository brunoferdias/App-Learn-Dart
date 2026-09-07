import '../entities/estado_avaliacao.dart';

/// Guarda e devolve o estado da avaliação.
///
/// Sem [Resultado] de propósito: uma falha ao ler ou gravar isto nunca deve
/// virar mensagem de erro na tela — no pior caso o app simplesmente não pede
/// avaliação.
abstract interface class AvaliacaoRepositorio {
  Future<EstadoAvaliacao> carregar();
  Future<void> salvar(EstadoAvaliacao estado);
}
