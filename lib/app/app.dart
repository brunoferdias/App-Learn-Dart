import 'package:flutter/cupertino.dart';

import '../core/i18n/escopo_textos.dart';
import '../core/preferencias/preferencias.dart';
import '../core/tema/tema_app.dart';
import 'escopo_app.dart';
import 'injecao.dart';
import 'portal.dart';

class AprendaDartApp extends StatefulWidget {
  const AprendaDartApp({
    super.key,
    required this.preferencias,
    required this.localeDoSistema,
  });

  final Preferencias preferencias;
  final String localeDoSistema;

  @override
  State<AprendaDartApp> createState() => _AprendaDartAppState();
}

class _AprendaDartAppState extends State<AprendaDartApp> {
  late final Injecao _injecao = Injecao(
    preferencias: widget.preferencias,
    localeDoSistema: widget.localeDoSistema,
  );

  @override
  void initState() {
    super.initState();
    _injecao.controladorProgresso.iniciar();
    _injecao.controladorIdioma.addListener(_sincronizarIdioma);
  }

  void _sincronizarIdioma() =>
      _injecao.controladorProgresso.textos = _injecao.controladorIdioma.textos;

  @override
  void dispose() {
    _injecao.controladorIdioma.removeListener(_sincronizarIdioma);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EscopoApp(
      injecao: _injecao,
      child: ListenableBuilder(
        listenable: Listenable.merge([
          _injecao.controladorTema,
          _injecao.controladorIdioma,
        ]),
        builder: (context, _) {
          final brilho = _injecao.controladorTema.brilho;

          final brilhoEfetivo =
              brilho ?? MediaQuery.platformBrightnessOf(context);

          return EscopoTextos(
            textos: _injecao.controladorIdioma.textos,
            child: CupertinoApp(
              title: 'Aprenda Dart',
              debugShowCheckedModeBanner: false,
              theme: brilhoEfetivo == Brightness.dark
                  ? TemaApp.escuro()
                  : TemaApp.claro(),
              home: const Portal(),
            ),
          );
        },
      ),
    );
  }
}
