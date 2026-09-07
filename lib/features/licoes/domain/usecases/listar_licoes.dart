import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/licao.dart';
import '../repositories/licao_repositorio.dart';

class ListarLicoes {
  const ListarLicoes(this._repositorio);

  final LicaoRepositorio _repositorio;

  Future<Resultado<List<Licao>>> call(Textos textos) =>
      _repositorio.listarTodas(textos);
}
