import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../../domain/entities/cenario.dart';
import '../../domain/repositories/cenario_repositorio.dart';
import '../datasources/cenarios_locais_datasource.dart';

class CenarioRepositorioImpl implements CenarioRepositorio {
  const CenarioRepositorioImpl(this._datasource);

  final CenariosLocaisDatasource _datasource;

  @override
  Future<Resultado<List<Cenario>>> listarTodos(Textos textos) async {
    try {
      return Resultado.ok(await _datasource.buscarTodos(textos.idioma));
    } catch (e) {
      return Resultado.falha(textos.erroCarregarCenarios(e));
    }
  }
}
