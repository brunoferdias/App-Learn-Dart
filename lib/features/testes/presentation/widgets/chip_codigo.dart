import 'package:flutter/cupertino.dart';

import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';

class ChipCodigo extends StatelessWidget {
  const ChipCodigo({
    super.key,
    required this.texto,
    required this.selecionado,
    required this.aoTocar,
    this.cor = CoresApp.azulDart,
  });

  final String texto;
  final bool selecionado;
  final VoidCallback? aoTocar;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: aoTocar,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: selecionado ? cor.withValues(alpha: 0.16) : paleta.superficie2,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selecionado ? cor : paleta.borda,
            width: selecionado ? 1.5 : 1,
          ),
        ),
        child: Text(
          texto,
          style: TextStyle(
            fontFamily: TemaApp.fonteMono,
            fontSize: 12,
            fontWeight: selecionado ? FontWeight.w600 : FontWeight.w400,
            color: selecionado ? cor : paleta.textoSuave,
          ),
        ),
      ),
    );
  }
}
