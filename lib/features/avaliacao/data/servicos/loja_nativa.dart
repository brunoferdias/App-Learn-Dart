import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../../store/aso.dart';
import '../../domain/repositories/loja_de_apps.dart';

/// A App Store de verdade, pelo `SKStoreReviewController` do iOS.
///
/// Toda chamada é protegida: em plataforma sem loja (web, testes, desktop) o
/// plugin não existe, e a falha vira um "não dá" silencioso.
class LojaNativa implements LojaDeApps {
  const LojaNativa();

  static const Set<TargetPlatform> _comLoja = {
    TargetPlatform.iOS,
    TargetPlatform.macOS,
    TargetPlatform.android,
  };

  bool get _plataformaTemLoja => !kIsWeb && _comLoja.contains(defaultTargetPlatform);

  @override
  Future<bool> aceitaPedidoNativo() async {
    if (!_plataformaTemLoja) return false;
    try {
      return await InAppReview.instance.isAvailable();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> pedirAvaliacao() async {
    if (!_plataformaTemLoja) return;
    try {
      await InAppReview.instance.requestReview();
    } catch (_) {
      // Sem loja disponível, não há o que fazer — e nada a avisar.
    }
  }

  @override
  Future<void> abrirFichaParaAvaliar() async {
    if (!_plataformaTemLoja) return;
    try {
      await InAppReview.instance.openStoreListing(
        appStoreId: LojaApple.idDoApp,
      );
    } catch (_) {
      // idem.
    }
  }
}
