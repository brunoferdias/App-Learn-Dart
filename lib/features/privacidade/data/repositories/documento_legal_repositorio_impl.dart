import '../../../../core/i18n/idioma.dart';
import '../../domain/entities/documento_legal.dart';
import '../../domain/repositories/documento_legal_repositorio.dart';
import '../datasources/documento_legal_datasource.dart';

class DocumentoLegalRepositorioImpl implements DocumentoLegalRepositorio {
  const DocumentoLegalRepositorioImpl(this._datasource);

  final DocumentoLegalDatasource _datasource;

  @override
  DocumentoLegal obter(Idioma idioma) => _datasource.obter(idioma);
}
