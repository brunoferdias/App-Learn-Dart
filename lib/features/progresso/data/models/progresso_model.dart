import '../../domain/entities/progresso.dart';

/// Os nomes dos campos no mapa que vai ao disco. Ficam aqui para o model e o
/// datasource não escreverem a mesma string em dois lugares.
abstract final class CamposProgresso {
  static const String licoesConcluidas = 'licoesConcluidas';
  static const String acertos = 'acertos';
  static const String erros = 'erros';
}

class ProgressoModel extends Progresso {
  const ProgressoModel({super.licoesConcluidas, super.acertos, super.erros});

  factory ProgressoModel.deMapa(Map<String, dynamic> mapa) {
    final lista =
        mapa[CamposProgresso.licoesConcluidas] as List<dynamic>? ?? const [];

    return ProgressoModel(
      licoesConcluidas: lista.map((e) => e.toString()).toSet(),
      acertos: mapa[CamposProgresso.acertos] as int? ?? 0,
      erros: mapa[CamposProgresso.erros] as int? ?? 0,
    );
  }

  Map<String, dynamic> paraMapa() => {
    CamposProgresso.licoesConcluidas: licoesConcluidas.toList(),
    CamposProgresso.acertos: acertos,
    CamposProgresso.erros: erros,
  };

  factory ProgressoModel.daEntidade(Progresso p) => ProgressoModel(
    licoesConcluidas: p.licoesConcluidas,
    acertos: p.acertos,
    erros: p.erros,
  );
}
