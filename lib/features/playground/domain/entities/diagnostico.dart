import '../../../../core/i18n/textos.dart';

class Diagnostico {
  const Diagnostico({
    required this.mensagem,
    required this.linha,
    required this.coluna,
    required this.arquivo,
    required this.tipo,
    this.dica,
  });

  final String mensagem;
  final int linha;
  final int coluna;
  final String arquivo;
  final String? dica;
  final TipoDiagnostico tipo;
}

enum TipoDiagnostico {
  sintaxe,
  execucao;

  String rotulo(Textos t) => switch (this) {
    TipoDiagnostico.sintaxe => t.diagErroSintaxe,
    TipoDiagnostico.execucao => t.diagErroExecucao,
  };
}
