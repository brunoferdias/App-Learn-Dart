import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/etiqueta.dart';
import '../../domain/entities/licao.dart';

Color corDoNivel(NivelLicao nivel) => switch (nivel) {
  NivelLicao.iniciante => CoresApp.acerto,
  NivelLicao.intermediario => CoresApp.azulDart,
  NivelLicao.avancado => CoresApp.dica,
};

class CartaoLicao extends StatelessWidget {
  const CartaoLicao({
    super.key,
    required this.licao,
    required this.numero,
    required this.concluida,
    required this.aoTocar,
  });

  final Licao licao;
  final int numero;
  final bool concluida;
  final VoidCallback aoTocar;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final cor = corDoNivel(licao.nivel);

    return Cartao(
      aoTocar: aoTocar,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: concluida
                  ? CoresApp.acerto.withValues(alpha: 0.14)
                  : cor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: (concluida ? CoresApp.acerto : cor).withValues(
                  alpha: 0.24,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: concluida
                ? const Icon(
                    CupertinoIcons.checkmark_alt,
                    size: 18,
                    color: CoresApp.acerto,
                  )
                : Text(
                    numero.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontFamily: TemaApp.fonteMono,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: cor,
                    ),
                  ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textos.licaoNumero(numero).toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: paleta.textoSuave,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  licao.titulo,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.4,
                    color: paleta.texto,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  licao.resumo,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.35,
                    color: paleta.textoSuave,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    Etiqueta(licao.nivel.rotulo(textos), cor: cor),
                    Etiqueta(
                      textos.minutos(licao.minutos),
                      cor: paleta.textoSuave,
                      icone: CupertinoIcons.clock,
                    ),
                    Etiqueta(
                      textos.exemplos(licao.quantidadeDeExemplos),
                      cor: paleta.textoSuave,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 4),
            child: Icon(
              CupertinoIcons.chevron_right,
              size: 15,
              color: paleta.textoSuave.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
