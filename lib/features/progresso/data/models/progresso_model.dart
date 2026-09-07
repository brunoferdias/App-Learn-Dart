import '../../domain/entities/progresso.dart';

class ProgressoModel extends Progresso {
  const ProgressoModel({super.licoesConcluidas, super.acertos, super.erros});

  factory ProgressoModel.deMapa(Map<String, dynamic> mapa) {
    final lista = mapa['licoesConcluidas'] as List<dynamic>? ?? const [];

    return ProgressoModel(
      licoesConcluidas: lista.map((e) => e.toString()).toSet(),
      acertos: mapa['acertos'] as int? ?? 0,
      erros: mapa['erros'] as int? ?? 0,
    );
  }

  Map<String, dynamic> paraMapa() => {
    'licoesConcluidas': licoesConcluidas.toList(),
    'acertos': acertos,
    'erros': erros,
  };

  factory ProgressoModel.daEntidade(Progresso p) => ProgressoModel(
    licoesConcluidas: p.licoesConcluidas,
    acertos: p.acertos,
    erros: p.erros,
  );
}
