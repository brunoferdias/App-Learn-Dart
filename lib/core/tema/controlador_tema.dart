import 'package:flutter/cupertino.dart';

import '../preferencias/preferencias.dart';
import 'modo_tema.dart';

class ControladorTema extends ChangeNotifier {
  ControladorTema({required Preferencias preferencias})
    : _prefs = preferencias {
    _modo = ModoTema.deCodigo(_prefs.lerTexto(ChavesPref.tema));
  }

  final Preferencias _prefs;
  late ModoTema _modo;

  ModoTema get modo => _modo;

  Brightness? get brilho => switch (_modo) {
    ModoTema.sistema => null,
    ModoTema.claro => Brightness.light,
    ModoTema.escuro => Brightness.dark,
  };

  Future<void> trocarPara(ModoTema novo) async {
    if (novo == _modo) return;
    _modo = novo;
    notifyListeners();
    await _prefs.gravarTexto(ChavesPref.tema, novo.codigo);
  }
}
