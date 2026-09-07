import 'package:shared_preferences/shared_preferences.dart';

abstract interface class Preferencias {
  String? lerTexto(String chave);
  Future<void> gravarTexto(String chave, String valor);

  bool lerBooleano(String chave, {bool padrao = false});
  Future<void> gravarBooleano(String chave, bool valor);
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
}

abstract final class ChavesPref {
  static const String idioma = 'idioma';
  static const String tema = 'tema';
  static const String onboardingConcluido = 'onboarding_concluido';
}
