import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/tema_app.dart';
import '../widgets/marca_arredondada.dart';
import '../widgets/seletor_idioma.dart';

class TelaBoasVindas extends StatelessWidget {
  const TelaBoasVindas({
    super.key,
    required this.aoVerApresentacao,
    required this.aoPular,
  });

  final VoidCallback aoVerApresentacao;
  final VoidCallback aoPular;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),

              const MarcaArredondada(tamanho: 66, sombra: false),
              const SizedBox(height: 22),

              Text(
                textos.boasVindasSaudacao,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  color: paleta.textoSuave,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                textos.boasVindasTitulo,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.9,
                  height: 1.12,
                  color: paleta.texto,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                textos.boasVindasTexto,
                style: TextStyle(
                  fontSize: 15.5,
                  height: 1.5,
                  letterSpacing: -0.1,
                  color: paleta.textoSuave,
                ),
              ),

              const Spacer(flex: 2),

              Text(
                textos.boasVindasEscolhaIdioma.toUpperCase(),
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: paleta.textoSuave,
                ),
              ),
              const SizedBox(height: 10),
              SeletorIdioma(
                controlador: EscopoApp.de(context).controladorIdioma,
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(12),
                  onPressed: aoVerApresentacao,
                  child: Text(textos.boasVindasComecar),
                ),
              ),
              CupertinoButton(
                onPressed: aoPular,
                child: Text(
                  textos.boasVindasJaConheco,
                  style: TextStyle(fontSize: 15, color: paleta.textoSuave),
                ),
              ),

              const SizedBox(height: 2),
              Center(
                child: Text(
                  textos.avisoNaoOficialCurto,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: paleta.textoSuave.withValues(alpha: 0.75),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
