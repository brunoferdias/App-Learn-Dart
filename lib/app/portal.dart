import 'package:flutter/cupertino.dart';

import '../features/onboarding/presentation/controllers/controlador_onboarding.dart';
import '../features/onboarding/presentation/pages/fluxo_onboarding.dart';
import '../features/onboarding/presentation/pages/tela_boas_vindas.dart';
import '../features/onboarding/presentation/pages/tela_splash.dart';
import 'abas.dart';
import 'escopo_app.dart';

enum _Etapa { splash, boasVindas, apresentacao, app }

class Portal extends StatefulWidget {
  const Portal({super.key});

  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  _Etapa _etapa = _Etapa.splash;
  ControladorOnboarding? _onboarding;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_onboarding != null) return;
    _onboarding = EscopoApp.de(context).controladorOnboarding
      ..addListener(_ouvirOnboarding);
  }

  void _ouvirOnboarding() {
    final onboarding = _onboarding;
    if (onboarding == null || !mounted) return;
    if (!onboarding.concluido && _etapa == _Etapa.app) {
      setState(() => _etapa = _Etapa.apresentacao);
    }
  }

  @override
  void dispose() {
    _onboarding?.removeListener(_ouvirOnboarding);
    super.dispose();
  }

  void _depoisDoSplash() {
    if (!mounted) return;
    final injecao = EscopoApp.de(context);
    setState(() {
      _etapa = injecao.controladorOnboarding.concluido
          ? _Etapa.app
          : _Etapa.boasVindas;
    });
  }

  Future<void> _entrarNoApp() async {
    await EscopoApp.de(context).controladorOnboarding.concluir();
    if (!mounted) return;
    setState(() => _etapa = _Etapa.app);
  }

  @override
  Widget build(BuildContext context) {
    final tela = switch (_etapa) {
      _Etapa.splash => TelaSplash(
        key: const ValueKey('splash'),
        aoTerminar: _depoisDoSplash,
      ),
      _Etapa.boasVindas => TelaBoasVindas(
        key: const ValueKey('boas-vindas'),
        aoVerApresentacao: () => setState(() => _etapa = _Etapa.apresentacao),
        aoPular: _entrarNoApp,
      ),
      _Etapa.apresentacao => FluxoOnboarding(
        key: const ValueKey('apresentacao'),
        aoConcluir: _entrarNoApp,
      ),
      _Etapa.app => const Abas(key: ValueKey('abas')),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: tela,
    );
  }
}
