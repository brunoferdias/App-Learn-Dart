import '../../../../core/i18n/idioma.dart';
import '../entities/documento_legal.dart';

/// Sem [Future] e sem [Resultado]: o documento é uma constante compilada junto
/// com o app. Não há disco para falhar nem espera para mostrar.
abstract interface class DocumentoLegalRepositorio {
  DocumentoLegal obter(Idioma idioma);
}
