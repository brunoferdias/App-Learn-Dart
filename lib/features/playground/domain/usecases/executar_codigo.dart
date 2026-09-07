import '../../../../core/i18n/textos.dart';
import '../entities/arquivo_dart.dart';
import '../entities/resultado_execucao.dart';
import '../repositories/playground_repositorio.dart';

class ExecutarCodigo {
  const ExecutarCodigo(this._repositorio);
  final PlaygroundRepositorio _repositorio;

  ResultadoExecucao call(List<ArquivoDart> arquivos, Textos textos) =>
      _repositorio.executar(arquivos, textos);
}
