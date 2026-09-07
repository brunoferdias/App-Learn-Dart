import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/exercicio.dart';
import '../repositories/exercicio_repositorio.dart';

class ListarExercicios {
  const ListarExercicios(this._repositorio);

  final ExercicioRepositorio _repositorio;

  Future<Resultado<List<Exercicio>>> call(Textos textos, {String? licaoId}) =>
      _repositorio.listar(textos, licaoId: licaoId);
}
