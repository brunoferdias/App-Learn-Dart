import '../../../../core/i18n/idioma.dart';
import '../../domain/entities/cenario.dart';
import 'cenarios/en.dart';
import 'cenarios/pt.dart';

abstract interface class CenariosLocaisDatasource {
  Future<List<Cenario>> buscarTodos(Idioma idioma);
}

class CenariosEmMemoria implements CenariosLocaisDatasource {
  const CenariosEmMemoria();

  @override
  Future<List<Cenario>> buscarTodos(Idioma idioma) async => switch (idioma) {
    Idioma.portugues => cenariosPt,
    Idioma.ingles => cenariosEn,
  };
}
