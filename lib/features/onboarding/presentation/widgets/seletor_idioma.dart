import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/controlador_idioma.dart';
import '../../../../core/i18n/idioma.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';

class SeletorIdioma extends StatelessWidget {
  const SeletorIdioma({super.key, required this.controlador});

  final ControladorIdioma controlador;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) => Row(
        children: [
          for (final idioma in Idioma.values) ...[
            Expanded(
              child: _Opcao(
                idioma: idioma,
                ativo: controlador.idioma == idioma,
                aoTocar: () => controlador.trocarPara(idioma),
              ),
            ),
            if (idioma != Idioma.values.last) const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _Opcao extends StatelessWidget {
  const _Opcao({
    required this.idioma,
    required this.ativo,
    required this.aoTocar,
  });

  final Idioma idioma;
  final bool ativo;
  final VoidCallback aoTocar;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: aoTocar,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: ativo
              ? CoresApp.azulDart.withValues(alpha: paleta.escuro ? 0.20 : 0.09)
              : paleta.superficie,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ativo ? CoresApp.azulDart : paleta.borda,
            width: ativo ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idioma.nome,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                      color: paleta.texto,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    idioma.codigo.toUpperCase(),
                    style: TextStyle(
                      fontFamily: TemaApp.fonteMono,
                      fontSize: 11,
                      color: paleta.textoSuave,
                    ),
                  ),
                ],
              ),
            ),
            if (ativo)
              const Icon(
                CupertinoIcons.checkmark_alt,
                size: 16,
                color: CoresApp.azulDart,
              ),
          ],
        ),
      ),
    );
  }
}
