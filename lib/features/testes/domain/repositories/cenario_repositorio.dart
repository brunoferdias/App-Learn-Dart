import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/cenario.dart';

abstract interface class CenarioRepositorio {
  Future<Resultado<List<Cenario>>> listarTodos(Textos textos);
}
