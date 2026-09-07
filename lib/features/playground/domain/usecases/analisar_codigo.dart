import '../../../../core/i18n/textos.dart';
import '../entities/arquivo_dart.dart';
import '../entities/diagnostico.dart';
import '../repositories/playground_repositorio.dart';

class AnalisarCodigo {
  const AnalisarCodigo(this._repositorio);
  final PlaygroundRepositorio _repositorio;

  List<Diagnostico> call(List<ArquivoDart> arquivos, Textos textos) =>
      _repositorio.analisar(arquivos, textos);
}
