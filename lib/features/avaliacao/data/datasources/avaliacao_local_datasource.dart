import '../../../../core/preferencias/preferencias.dart';

abstract interface class AvaliacaoLocalDatasource {
  Map<String, Object?> ler();
  Future<void> escrever(Map<String, Object?> dados);
}

/// Grava nas preferências do aparelho. Valores nulos são ignorados: uma data
/// que ainda não existe simplesmente não vai ao disco.
class AvaliacaoEmPreferencias implements AvaliacaoLocalDatasource {
  const AvaliacaoEmPreferencias(this._prefs);

  final Preferencias _prefs;

  @override
  Map<String, Object?> ler() => {
    ChavesPref.avaliacaoPrimeiroUso: _prefs.lerTexto(
      ChavesPref.avaliacaoPrimeiroUso,
    ),
    ChavesPref.avaliacaoPontos: _prefs.lerInteiro(ChavesPref.avaliacaoPontos),
    ChavesPref.avaliacaoPedidos: _prefs.lerInteiro(ChavesPref.avaliacaoPedidos),
    ChavesPref.avaliacaoUltimoPedido: _prefs.lerTexto(
      ChavesPref.avaliacaoUltimoPedido,
    ),
    ChavesPref.avaliacaoEncerrada: _prefs.lerBooleano(
      ChavesPref.avaliacaoEncerrada,
    ),
  };

  @override
  Future<void> escrever(Map<String, Object?> dados) async {
    for (final MapEntry(:key, :value) in dados.entries) {
      switch (value) {
        case final String texto:
          await _prefs.gravarTexto(key, texto);
        case final int numero:
          await _prefs.gravarInteiro(key, numero);
        case final bool booleano:
          await _prefs.gravarBooleano(key, booleano);
        case null:
          break;
      }
    }
  }
}
