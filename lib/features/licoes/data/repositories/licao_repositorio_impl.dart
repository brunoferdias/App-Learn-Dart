import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../../domain/entities/licao.dart';
import '../../domain/repositories/licao_repositorio.dart';
import '../datasources/licoes_locais_datasource.dart';

class LicaoRepositorioImpl implements LicaoRepositorio {
  const LicaoRepositorioImpl(this._datasource);

  final LicoesLocaisDatasource _datasource;

  @override
  Future<Resultado<List<Licao>>> listarTodas(Textos textos) async {
    try {
      final licoes = await _datasource.buscarTodas(textos.idioma);
      return Resultado.ok(licoes);
    } catch (e) {
      return Resultado.falha(textos.erroCarregarLicoes(e));
    }
  }

  @override
  Future<Resultado<Licao>> obterPorId(String id, Textos textos) async {
    try {
      final licoes = await _datasource.buscarTodas(textos.idioma);

      final Licao? encontrada = licoes
          .where((licao) => licao.id == id)
          .firstOrNull;

      if (encontrada == null) {
        return Resultado.falha(textos.erroLicaoNaoEncontrada(id));
      }
      return Resultado.ok(encontrada);
    } catch (e) {
      return Resultado.falha(textos.erroAbrirLicao(e));
    }
  }
}
