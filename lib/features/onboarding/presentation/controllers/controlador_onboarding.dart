import 'package:flutter/foundation.dart';

import '../../../../core/preferencias/preferencias.dart';

class ControladorOnboarding extends ChangeNotifier {
  ControladorOnboarding({required Preferencias preferencias})
    : _prefs = preferencias {
    _concluido = _prefs.lerBooleano(ChavesPref.onboardingConcluido);
  }

  final Preferencias _prefs;
  late bool _concluido;

  bool get concluido => _concluido;

  Future<void> concluir() async {
    if (_concluido) return;
    _concluido = true;
    notifyListeners();
    await _prefs.gravarBooleano(ChavesPref.onboardingConcluido, true);
  }

  void reabrir() {
    _concluido = false;
    notifyListeners();
  }
}
