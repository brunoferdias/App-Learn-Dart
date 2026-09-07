import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/licao.dart';
import '../repositories/licao_repositorio.dart';

class ObterLicao {
  const ObterLicao(this._repositorio);

  final LicaoRepositorio _repositorio;

  Future<Resultado<Licao>> call(String id, Textos textos) =>
      _repositorio.obterPorId(id, textos);
}
