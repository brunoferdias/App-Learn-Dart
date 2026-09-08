import '../../../../core/i18n/idioma.dart';
import '../entities/documento_legal.dart';
import '../repositories/documento_legal_repositorio.dart';

class ObterDocumentoLegal {
  const ObterDocumentoLegal(this._repositorio);
  final DocumentoLegalRepositorio _repositorio;

  DocumentoLegal call(Idioma idioma) => _repositorio.obter(idioma);
}
