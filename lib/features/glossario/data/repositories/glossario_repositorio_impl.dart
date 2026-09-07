import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../../domain/entities/item_glossario.dart';
import '../../domain/repositories/glossario_repositorio.dart';
import '../datasources/glossario_local_datasource.dart';

class GlossarioRepositorioImpl implements GlossarioRepositorio {
  const GlossarioRepositorioImpl(this._datasource);

  final GlossarioLocalDatasource _datasource;

  @override
  Future<Resultado<List<ItemGlossario>>> listar(Textos textos) async {
    try {
      return Resultado.ok(await _datasource.buscarTodos(textos.idioma));
    } catch (e) {
      return Resultado.falha(textos.erroCarregarGlossario(e));
    }
  }
}
