import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/texto_rico.dart';

class AvisoNaoOficial extends StatelessWidget {
  const AvisoNaoOficial({super.key, this.compacto = false});

  final bool compacto;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    final conteudo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.info_circle,
              size: 14,
              color: paleta.textoSuave,
            ),
            const SizedBox(width: 7),
            Text(
              textos.avisoNaoOficialTitulo.toUpperCase(),
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.9,
                color: paleta.textoSuave,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        TextoRico(
          textos.avisoNaoOficialCompleto,
          tamanho: 13.5,
          alturaLinha: 1.5,
          cor: paleta.textoSuave,
        ),
      ],
    );

    if (compacto) return conteudo;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 15),
      decoration: BoxDecoration(
        color: paleta.superficie2.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: paleta.borda),
      ),
      child: conteudo,
    );
  }
}
