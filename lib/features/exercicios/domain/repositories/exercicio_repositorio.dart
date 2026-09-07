import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/exercicio.dart';

abstract interface class ExercicioRepositorio {
  Future<Resultado<List<Exercicio>>> listar(Textos textos, {String? licaoId});
}
