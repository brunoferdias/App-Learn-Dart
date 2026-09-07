import 'package:flutter/cupertino.dart';

import 'cores_app.dart';

class PaletaApp {
  const PaletaApp({
    required this.fundo,
    required this.superficie,
    required this.superficie2,
    required this.texto,
    required this.textoSuave,
    required this.borda,
    required this.fundoCodigo,
    required this.escuro,
  });

  final Color fundo;
  final Color superficie;
  final Color superficie2;
  final Color texto;
  final Color textoSuave;
  final Color borda;
  final Color fundoCodigo;
  final bool escuro;

  const PaletaApp.clara()
    : fundo = CoresApp.fundoClaro,
      superficie = CoresApp.superficieClara,
      superficie2 = CoresApp.superficieClara2,
      texto = CoresApp.textoClaro,
      textoSuave = CoresApp.textoSuaveClaro,
      borda = CoresApp.bordaClara,
      fundoCodigo = CoresApp.fundoCodigoClaro,
      escuro = false;

  const PaletaApp.escura()
    : fundo = CoresApp.fundoEscuro,
      superficie = CoresApp.superficieEscura,
      superficie2 = CoresApp.superficieEscura2,
      texto = CoresApp.textoEscuro,
      textoSuave = CoresApp.textoSuaveEscuro,
      borda = CoresApp.bordaEscura,
      fundoCodigo = CoresApp.fundoCodigoEscuro,
      escuro = true;
}

extension PaletaDoContexto on BuildContext {
  PaletaApp get paleta => CupertinoTheme.of(this).brightness == Brightness.dark
      ? const PaletaApp.escura()
      : const PaletaApp.clara();

  bool get temaEscuro => paleta.escuro;
}

abstract final class TemaApp {
  static const String fonteMono = 'Menlo';

  static CupertinoThemeData claro() => const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CoresApp.azulDart,
    scaffoldBackgroundColor: CoresApp.fundoClaro,
    barBackgroundColor: Color(0xF2FFFFFF),
    textTheme: CupertinoTextThemeData(
      primaryColor: CoresApp.azulDart,
      textStyle: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Text',
        fontSize: 16,
        height: 1.45,
        color: CoresApp.textoClaro,
        letterSpacing: -0.2,
        decoration: TextDecoration.none,
      ),
      navTitleTextStyle: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Text',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.41,
        color: CoresApp.textoClaro,
        decoration: TextDecoration.none,
      ),
      navLargeTitleTextStyle: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Display',
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: CoresApp.textoClaro,
        decoration: TextDecoration.none,
      ),
    ),
  );

  static CupertinoThemeData escuro() => const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CoresApp.azulClaroDart,
    scaffoldBackgroundColor: CoresApp.fundoEscuro,
    barBackgroundColor: Color(0xF20A0F18),
    textTheme: CupertinoTextThemeData(
      primaryColor: CoresApp.azulClaroDart,
      textStyle: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Text',
        fontSize: 16,
        height: 1.45,
        color: CoresApp.textoEscuro,
        letterSpacing: -0.2,
        decoration: TextDecoration.none,
      ),
      navTitleTextStyle: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Text',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.41,
        color: CoresApp.textoEscuro,
        decoration: TextDecoration.none,
      ),
      navLargeTitleTextStyle: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Display',
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: CoresApp.textoEscuro,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
