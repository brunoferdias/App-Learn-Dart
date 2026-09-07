import 'package:flutter/cupertino.dart';

import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../domain/entities/resultado_teste.dart';

class ConsoleTeste extends StatelessWidget {
  const ConsoleTeste({super.key, required this.linhas});

  final List<LinhaSaida> linhas;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: paleta.fundoCodigo,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: paleta.borda),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final linha in linhas)
              Text(
                linha.texto,
                style: TextStyle(
                  fontFamily: TemaApp.fonteMono,
                  fontSize: 11.5,
                  height: 1.5,
                  color: switch (linha.tom) {
                    TomSaida.sucesso => CoresApp.acerto,
                    TomSaida.falha => CoresApp.erro,
                    TomSaida.apagado => CoresApp.synComentario,
                    TomSaida.normal => CoresApp.synPadrao,
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
