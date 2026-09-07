import 'package:flutter/cupertino.dart';

import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';

enum EstadoOpcao { neutra, escolhidaCerta, escolhidaErrada, reveladaCerta }

class OpcaoResposta extends StatelessWidget {
  const OpcaoResposta({
    super.key,
    required this.texto,
    required this.letra,
    required this.estado,
    required this.aoTocar,
  });

  final String texto;
  final String letra;
  final EstadoOpcao estado;
  final VoidCallback? aoTocar;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    final (Color cor, IconData? icone) = switch (estado) {
      EstadoOpcao.neutra => (paleta.borda, null),
      EstadoOpcao.escolhidaCerta => (
        CoresApp.acerto,
        CupertinoIcons.checkmark_circle_fill,
      ),
      EstadoOpcao.escolhidaErrada => (
        CoresApp.erro,
        CupertinoIcons.xmark_circle_fill,
      ),
      EstadoOpcao.reveladaCerta => (
        CoresApp.acerto,
        CupertinoIcons.arrow_turn_down_right,
      ),
    };

    final destacada = estado != EstadoOpcao.neutra;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: aoTocar,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: destacada ? cor.withValues(alpha: 0.10) : paleta.superficie,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: destacada ? cor : paleta.borda,
            width: destacada ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: destacada
                    ? cor.withValues(alpha: 0.18)
                    : paleta.superficie2,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                letra,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: destacada ? cor : paleta.textoSuave,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                texto,
                style: TextStyle(
                  fontFamily: texto.contains(RegExp(r'[(){};=>$]'))
                      ? TemaApp.fonteMono
                      : null,
                  fontSize: 14.5,
                  height: 1.35,
                  fontWeight: destacada ? FontWeight.w600 : FontWeight.w400,
                  color: paleta.texto,
                ),
              ),
            ),
            if (icone case final i?) ...[
              const SizedBox(width: 8),
              Icon(i, size: 19, color: cor),
            ],
          ],
        ),
      ),
    );
  }
}
