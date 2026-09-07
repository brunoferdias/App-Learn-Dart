import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/texto_rico.dart';

class PainelExplicacao extends StatelessWidget {
  const PainelExplicacao({
    super.key,
    required this.acertou,
    required this.explicacao,
  });

  final bool acertou;
  final String explicacao;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final cor = acertou ? CoresApp.acerto : CoresApp.erro;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                acertou
                    ? CupertinoIcons.checkmark_seal_fill
                    : CupertinoIcons.info_circle_fill,
                size: 17,
                color: cor,
              ),
              const SizedBox(width: 7),
              Text(
                acertou ? textos.quizAcertou : textos.quizErrou,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: cor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          TextoRico(explicacao, tamanho: 14.5, cor: paleta.texto),
        ],
      ),
    );
  }
}
