import '../../../../core/i18n/idioma.dart';
import '../../domain/entities/arquivo_dart.dart';
import '../../domain/repositories/playground_repositorio.dart';
import 'exemplos/en.dart';
import 'exemplos/pt.dart';

abstract interface class ExemplosLocaisDatasource {
  List<ArquivoDart> iniciais(Idioma idioma);
  List<ExemploPlayground> exemplos(Idioma idioma);
}

class ExemplosEmMemoria implements ExemplosLocaisDatasource {
  const ExemplosEmMemoria();

  @override
  List<ArquivoDart> iniciais(Idioma idioma) => switch (idioma) {
    Idioma.portugues => arquivosIniciaisPt,
    Idioma.ingles => arquivosIniciaisEn,
  };

  @override
  List<ExemploPlayground> exemplos(Idioma idioma) => switch (idioma) {
    Idioma.portugues => exemplosPt,
    Idioma.ingles => exemplosEn,
  };
}
