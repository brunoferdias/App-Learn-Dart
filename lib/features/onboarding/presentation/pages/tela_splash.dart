import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../widgets/marca_arredondada.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({super.key, required this.aoTerminar});

  final VoidCallback aoTerminar;

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controlador = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1750),
  );

  late final Animation<double> _brilho = _intervalo(0.00, 0.45);
  late final Animation<double> _marca = _intervalo(0.05, 0.55);
  late final Animation<double> _titulo = _intervalo(0.30, 0.70);
  late final Animation<double> _linha = _intervalo(0.45, 0.85);

  Animation<double> _intervalo(double inicio, double fim) => CurvedAnimation(
    parent: _controlador,
    curve: Interval(inicio, fim, curve: Curves.easeOutCubic),
  );

  @override
  void initState() {
    super.initState();
    _controlador.forward().whenComplete(widget.aoTerminar);
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textos = context.textos;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CoresApp.splashTopo,
            CoresApp.splashMeio,
            CoresApp.splashBase,
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: AnimatedBuilder(
        animation: _controlador,
        builder: (context, _) => Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: _brilho.value * 0.5,
              child: Transform.scale(
                scale: 0.7 + _brilho.value * 0.4,
                child: Container(
                  width: 420,
                  height: 420,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [CoresApp.splashBrilho, Color(0x0013B9FD)],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: _marca.value,
                  child: Transform.scale(
                    scale: 0.88 + _marca.value * 0.12,
                    child: const MarcaArredondada(tamanho: 104),
                  ),
                ),
                const SizedBox(height: 26),
                Opacity(
                  opacity: _titulo.value,
                  child: Transform.translate(
                    offset: Offset(0, 10 * (1 - _titulo.value)),
                    child: Text(
                      textos.nomeApp,
                      style: TextStyle(
                        inherit: false,
                        fontFamily: '.SF Pro Display',
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                        color: Color(0xFFF2F8FF),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Opacity(
                  opacity: _linha.value * 0.85,
                  child: Text(
                    textos.splashSubtitulo,
                    style: const TextStyle(
                      inherit: false,
                      fontFamily: '.SF Pro Text',
                      fontSize: 14.5,
                      letterSpacing: -0.1,
                      color: Color(0xFF9FC2DE),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              left: 24,
              right: 24,
              bottom: 34 + MediaQuery.paddingOf(context).bottom,
              child: Opacity(
                opacity: _linha.value * 0.6,
                child: Text(
                  textos.avisoNaoOficialCurto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    inherit: false,
                    fontFamily: '.SF Pro Text',
                    fontSize: 11.5,
                    height: 1.4,
                    color: Color(0xFF7FA0BC),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
