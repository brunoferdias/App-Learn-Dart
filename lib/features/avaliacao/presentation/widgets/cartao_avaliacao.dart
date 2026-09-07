import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../controllers/controlador_avaliacao.dart';

/// O caminho explícito para avaliar, sempre disponível no perfil — para quem
/// quer avaliar sem esperar o app perguntar.
class CartaoAvaliacao extends StatelessWidget {
  const CartaoAvaliacao({super.key, required this.controlador});

  final ControladorAvaliacao controlador;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return ListenableBuilder(
      listenable: controlador,
      builder: (context, _) => Cartao(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.star_fill,
                  size: 17,
                  color: CoresApp.atencao,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    controlador.jaAvaliou
                        ? textos.avaliarObrigadoTitulo
                        : textos.avaliarTitulo,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: paleta.texto,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              controlador.jaAvaliou
                  ? textos.avaliarObrigadoTexto
                  : textos.avaliarTexto,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: paleta.textoSuave,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton.filled(
                borderRadius: BorderRadius.circular(12),
                sizeStyle: CupertinoButtonSize.medium,
                onPressed: controlador.avaliarNaLoja,
                child: Text(
                  controlador.jaAvaliou
                      ? textos.avaliarBotaoDeNovo
                      : textos.avaliarBotao,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
