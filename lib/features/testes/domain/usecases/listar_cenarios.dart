import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/cenario.dart';
import '../repositories/cenario_repositorio.dart';

class ListarCenarios {
  const ListarCenarios(this._repositorio);

  final CenarioRepositorio _repositorio;

  Future<Resultado<List<Cenario>>> call(Textos textos) =>
      _repositorio.listarTodos(textos);
}
