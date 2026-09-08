import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/progresso.dart';

abstract interface class ProgressoRepositorio {
  Future<Resultado<Progresso>> carregar(Textos textos);
  Future<Resultado<Progresso>> salvar(Progresso progresso, Textos textos);

  /// Apaga o progresso guardado e devolve o estado zerado.
  Future<Resultado<Progresso>> apagar(Textos textos);
}
