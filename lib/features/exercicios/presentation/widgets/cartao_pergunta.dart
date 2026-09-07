import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/etiqueta.dart';
import '../../../../core/widgets/texto_rico.dart';
import '../../../../core/widgets/visualizador_codigo.dart';
import '../../domain/entities/exercicio.dart';

class CartaoPergunta extends StatelessWidget {
  const CartaoPergunta({super.key, required this.exercicio});

  final Exercicio exercicio;

  (String, Color, IconData) _identidade(Textos t) => switch (exercicio) {
    ExercicioCertoOuErrado() => (
      t.formatoCertoOuErrado,
      CoresApp.erro,
      CupertinoIcons.checkmark_shield,
    ),
    ExercicioMultiplaEscolha() => (
      t.formatoMultiplaEscolha,
      CoresApp.azulDart,
      CupertinoIcons.list_bullet,
    ),
    ExercicioCompletar() => (
      t.formatoCompletar,
      CoresApp.atencao,
      CupertinoIcons.pencil_outline,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final (rotulo, cor, icone) = _identidade(textos);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Etiqueta(rotulo, cor: cor, icone: icone),
        const SizedBox(height: 12),
        TextoRico(
          exercicio.enunciadoDe(textos),
          tamanho: 18,
          alturaLinha: 1.35,
          cor: paleta.texto,
        ),
        const SizedBox(height: 14),

        switch (exercicio) {
          ExercicioCertoOuErrado(:final codigo) => VisualizadorCodigo(
            codigo: codigo,
          ),
          ExercicioMultiplaEscolha(:final codigo) =>
            codigo == null
                ? const SizedBox.shrink()
                : VisualizadorCodigo(codigo: codigo),
          ExercicioCompletar(:final codigoComLacuna) => VisualizadorCodigo(
            codigo: codigoComLacuna,
            legenda: textos.legendaLacuna,
          ),
        },
      ],
    );
  }
}
