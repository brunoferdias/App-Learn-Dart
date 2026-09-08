import '../../../../core/i18n/idioma.dart';
import '../../domain/entities/documento_legal.dart';
import 'conteudo/en.dart';
import 'conteudo/pt.dart';

abstract interface class DocumentoLegalDatasource {
  DocumentoLegal obter(Idioma idioma);
}

class DocumentoLegalEmMemoria implements DocumentoLegalDatasource {
  const DocumentoLegalEmMemoria();

  @override
  DocumentoLegal obter(Idioma idioma) => switch (idioma) {
    Idioma.portugues => documentoLegalPt,
    Idioma.ingles => documentoLegalEn,
  };
}
