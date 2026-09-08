import '../../../../core/preferencias/preferencias.dart';
import '../models/progresso_model.dart';

abstract interface class ProgressoLocalDatasource {
  Future<Map<String, dynamic>> ler();
  Future<void> escrever(Map<String, dynamic> dados);

  /// Apaga o que foi gravado. Depois disso, `ler` devolve um progresso zerado.
  Future<void> limpar();
}

/// O progresso de verdade: sobrevive a fechar o app, trocar de idioma e
/// reiniciar o aparelho, porque mora nas SharedPreferences.
///
/// Guarda três chaves separadas em vez de um JSON só — assim um campo novo no
/// futuro não invalida o que já está gravado.
class ProgressoEmPreferencias implements ProgressoLocalDatasource {
  const ProgressoEmPreferencias(this._prefs);

  final Preferencias _prefs;

  @override
  Future<Map<String, dynamic>> ler() async => {
    CamposProgresso.licoesConcluidas:
        _prefs.lerListaDeTextos(ChavesPref.progressoLicoes) ??
        const <String>[],
    CamposProgresso.acertos: _prefs.lerInteiro(ChavesPref.progressoAcertos),
    CamposProgresso.erros: _prefs.lerInteiro(ChavesPref.progressoErros),
  };

  @override
  Future<void> escrever(Map<String, dynamic> dados) async {
    final licoes = dados[CamposProgresso.licoesConcluidas];
    if (licoes is List) {
      await _prefs.gravarListaDeTextos(
        ChavesPref.progressoLicoes,
        licoes.map((e) => e.toString()).toList(),
      );
    }

    await _prefs.gravarInteiro(
      ChavesPref.progressoAcertos,
      dados[CamposProgresso.acertos] as int? ?? 0,
    );
    await _prefs.gravarInteiro(
      ChavesPref.progressoErros,
      dados[CamposProgresso.erros] as int? ?? 0,
    );
  }

  /// Remove as chaves em vez de gravar zeros: o que o usuário pediu para
  /// apagar some do disco, não fica lá com outro valor.
  @override
  Future<void> limpar() async {
    await _prefs.remover(ChavesPref.progressoLicoes);
    await _prefs.remover(ChavesPref.progressoAcertos);
    await _prefs.remover(ChavesPref.progressoErros);
  }
}

/// Versão descartável, para testes que não querem tocar em disco.
class ProgressoEmMemoria implements ProgressoLocalDatasource {
  Map<String, dynamic> _dados = <String, dynamic>{};

  @override
  Future<Map<String, dynamic>> ler() async => _dados;

  @override
  Future<void> escrever(Map<String, dynamic> dados) async {
    _dados = dados;
  }

  @override
  Future<void> limpar() async {
    _dados = <String, dynamic>{};
  }
}
