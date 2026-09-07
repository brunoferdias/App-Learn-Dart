import 'package:shared_preferences/shared_preferences.dart';

abstract interface class Preferencias {
  String? lerTexto(String chave);
  Future<void> gravarTexto(String chave, String valor);

  bool lerBooleano(String chave, {bool padrao = false});
  Future<void> gravarBooleano(String chave, bool valor);

  int lerInteiro(String chave, {int padrao = 0});
  Future<void> gravarInteiro(String chave, int valor);

  List<String>? lerListaDeTextos(String chave);
  Future<void> gravarListaDeTextos(String chave, List<String> valor);
}

class PreferenciasCompartilhadas implements Preferencias {
  PreferenciasCompartilhadas._(this._prefs);

  final SharedPreferences _prefs;

  static Future<PreferenciasCompartilhadas> carregar() async =>
      PreferenciasCompartilhadas._(await SharedPreferences.getInstance());

  @override
  String? lerTexto(String chave) => _prefs.getString(chave);

  @override
  Future<void> gravarTexto(String chave, String valor) =>
      _prefs.setString(chave, valor);

  @override
  bool lerBooleano(String chave, {bool padrao = false}) =>
      _prefs.getBool(chave) ?? padrao;

  @override
  Future<void> gravarBooleano(String chave, bool valor) =>
      _prefs.setBool(chave, valor);

  @override
  int lerInteiro(String chave, {int padrao = 0}) =>
      _prefs.getInt(chave) ?? padrao;

  @override
  Future<void> gravarInteiro(String chave, int valor) =>
      _prefs.setInt(chave, valor);

  @override
  List<String>? lerListaDeTextos(String chave) => _prefs.getStringList(chave);

  @override
  Future<void> gravarListaDeTextos(String chave, List<String> valor) =>
      _prefs.setStringList(chave, valor);
}

class PreferenciasEmMemoria implements Preferencias {
  final Map<String, Object> _dados = {};

  @override
  String? lerTexto(String chave) => _dados[chave] as String?;

  @override
  Future<void> gravarTexto(String chave, String valor) async =>
      _dados[chave] = valor;

  @override
  bool lerBooleano(String chave, {bool padrao = false}) =>
      _dados[chave] as bool? ?? padrao;

  @override
  Future<void> gravarBooleano(String chave, bool valor) async =>
      _dados[chave] = valor;

  @override
  int lerInteiro(String chave, {int padrao = 0}) =>
      _dados[chave] as int? ?? padrao;

  @override
  Future<void> gravarInteiro(String chave, int valor) async =>
      _dados[chave] = valor;

  @override
  List<String>? lerListaDeTextos(String chave) =>
      (_dados[chave] as List<String>?)?.toList();

  /// Copia a lista ao gravar: quem chamou não pode mexer no que já foi salvo,
  /// que é como as SharedPreferences de verdade se comportam.
  @override
  Future<void> gravarListaDeTextos(String chave, List<String> valor) async =>
      _dados[chave] = List<String>.of(valor);
}

abstract final class ChavesPref {
  static const String idioma = 'idioma';
  static const String tema = 'tema';
  static const String onboardingConcluido = 'onboarding_concluido';

  static const String progressoLicoes = 'progresso_licoes_concluidas';
  static const String progressoAcertos = 'progresso_acertos';
  static const String progressoErros = 'progresso_erros';

  static const String avaliacaoPrimeiroUso = 'avaliacao_primeiro_uso';
  static const String avaliacaoPontos = 'avaliacao_pontos';
  static const String avaliacaoPedidos = 'avaliacao_pedidos';
  static const String avaliacaoUltimoPedido = 'avaliacao_ultimo_pedido';
  static const String avaliacaoEncerrada = 'avaliacao_encerrada';
}
