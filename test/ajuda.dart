import 'package:aprenda_dart/app/app.dart';
import 'package:aprenda_dart/core/i18n/textos.dart';
import 'package:aprenda_dart/core/i18n/textos_pt.dart';
import 'package:aprenda_dart/core/preferencias/preferencias.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const Textos textosTeste = TextosPt();

Preferencias preferenciasDeTeste({bool onboardingConcluido = true}) {
  final prefs = PreferenciasEmMemoria();
  if (onboardingConcluido) {
    prefs.gravarBooleano(ChavesPref.onboardingConcluido, true);
  }
  return prefs;
}

Widget appDeTeste({
  bool onboardingConcluido = true,
  Preferencias? preferencias,
}) => AprendaDartApp(
  preferencias:
      preferencias ??
      preferenciasDeTeste(onboardingConcluido: onboardingConcluido),
  localeDoSistema: 'pt',
);

Future<void> abrirApp(WidgetTester tester) async {
  await tester.pumpWidget(appDeTeste());
  await tester.pumpAndSettle();
}
