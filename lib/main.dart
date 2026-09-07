import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/cupertino.dart';

import 'app/app.dart';
import 'core/preferencias/preferencias.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Preferencias preferencias;
  try {
    preferencias = await PreferenciasCompartilhadas.carregar();
  } catch (_) {
    preferencias = PreferenciasEmMemoria();
  }

  runApp(
    AprendaDartApp(
      preferencias: preferencias,
      localeDoSistema: PlatformDispatcher.instance.locale.languageCode,
    ),
  );
}
