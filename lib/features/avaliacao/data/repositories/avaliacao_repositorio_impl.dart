import '../../domain/entities/estado_avaliacao.dart';
import '../../domain/repositories/avaliacao_repositorio.dart';
import '../datasources/avaliacao_local_datasource.dart';
import '../models/avaliacao_model.dart';

class AvaliacaoRepositorioImpl implements AvaliacaoRepositorio {
  const AvaliacaoRepositorioImpl(this._datasource);

  final AvaliacaoLocalDatasource _datasource;

  /// Se o disco falhar, começamos do zero em silêncio: no máximo o app deixa
  /// de pedir avaliação, e isso nunca é motivo para incomodar quem está
  /// estudando.
  @override
  Future<EstadoAvaliacao> carregar() async {
    try {
      return AvaliacaoModel.deMapa(_datasource.ler());
    } catch (_) {
      return const EstadoAvaliacao();
    }
  }

  @override
  Future<void> salvar(EstadoAvaliacao estado) async {
    try {
      await _datasource.escrever(AvaliacaoModel.paraMapa(estado));
    } catch (_) {
      // Silêncio proposital: ver o comentário de carregar().
    }
  }
}
