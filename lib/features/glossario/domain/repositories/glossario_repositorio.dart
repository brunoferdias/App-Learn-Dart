import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/item_glossario.dart';

abstract interface class GlossarioRepositorio {
  Future<Resultado<List<ItemGlossario>>> listar(Textos textos);
}
