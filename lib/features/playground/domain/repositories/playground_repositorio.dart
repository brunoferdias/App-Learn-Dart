import '../../../../core/i18n/textos.dart';
import '../entities/arquivo_dart.dart';
import '../entities/diagnostico.dart';
import '../entities/resultado_execucao.dart';

abstract interface class PlaygroundRepositorio {
  ResultadoExecucao executar(List<ArquivoDart> arquivos, Textos textos);

  List<Diagnostico> analisar(List<ArquivoDart> arquivos, Textos textos);

  List<ArquivoDart> arquivosIniciais(Textos textos);

  List<ExemploPlayground> exemplos(Textos textos);
}

class ExemploPlayground {
  const ExemploPlayground({
    required this.titulo,
    required this.descricao,
    required this.arquivos,
  });

  final String titulo;
  final String descricao;
  final List<ArquivoDart> arquivos;
}
