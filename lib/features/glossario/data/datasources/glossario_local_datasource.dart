import '../../../../core/i18n/idioma.dart';
import '../../domain/entities/item_glossario.dart';
import 'itens/en.dart';
import 'itens/pt.dart';

abstract interface class GlossarioLocalDatasource {
  Future<List<ItemGlossario>> buscarTodos(Idioma idioma);
}

class GlossarioEmMemoria implements GlossarioLocalDatasource {
  const GlossarioEmMemoria();

  @override
  Future<List<ItemGlossario>> buscarTodos(Idioma idioma) async =>
      switch (idioma) {
        Idioma.portugues => glossarioPt,
        Idioma.ingles => glossarioEn,
      };
}
