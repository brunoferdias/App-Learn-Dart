import 'package:flutter/foundation.dart';

import '../preferencias/preferencias.dart';
import 'idioma.dart';
import 'textos.dart';

class ControladorIdioma extends ChangeNotifier {
  ControladorIdioma({
    required Preferencias preferencias,
    required String localeDoSistema,
  }) : _prefs = preferencias {
    final salvo = _prefs.lerTexto(ChavesPref.idioma);
    _idioma = salvo == null
        ? Idioma.doSistema(localeDoSistema)
        : Idioma.deCodigo(salvo);
  }

  final Preferencias _prefs;
  late Idioma _idioma;

  Idioma get idioma => _idioma;

  Textos get textos => Textos.de(_idioma);

  bool get escolhidoPeloSistema => _prefs.lerTexto(ChavesPref.idioma) == null;

  Future<void> trocarPara(Idioma novo) async {
    if (novo == _idioma) return;
    _idioma = novo;
    notifyListeners();
    await _prefs.gravarTexto(ChavesPref.idioma, novo.codigo);
  }
}
