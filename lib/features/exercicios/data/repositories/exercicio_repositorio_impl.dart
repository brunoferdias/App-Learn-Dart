import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../../domain/entities/exercicio.dart';
import '../../domain/repositories/exercicio_repositorio.dart';
import '../datasources/exercicios_locais_datasource.dart';

class ExercicioRepositorioImpl implements ExercicioRepositorio {
  const ExercicioRepositorioImpl(this._datasource);

  final ExerciciosLocaisDatasource _datasource;

  @override
  Future<Resultado<List<Exercicio>>> listar(
    Textos textos, {
    String? licaoId,
  }) async {
    try {
      final todos = await _datasource.buscarTodos(textos.idioma);

      final filtrados = licaoId == null
          ? todos
          : todos.where((e) => e.licaoId == licaoId).toList();

      return Resultado.ok(filtrados);
    } catch (e) {
      return Resultado.falha(textos.erroCarregarExercicios(e));
    }
  }
}
