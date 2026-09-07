import 'package:flutter/cupertino.dart';

import '../i18n/escopo_textos.dart';
import '../i18n/textos.dart';
import '../tema/cores_app.dart';
import 'texto_rico.dart';

enum TipoDestaque {
  dica(CupertinoIcons.lightbulb, CoresApp.dica),
  aviso(CupertinoIcons.exclamationmark_triangle, CoresApp.atencao);

  const TipoDestaque(this.icone, this.cor);
  final IconData icone;
  final Color cor;

  String rotulo(Textos t) => switch (this) {
    TipoDestaque.dica => t.blocoDica,
    TipoDestaque.aviso => t.blocoAtencao,
  };
}

class CaixaDestaque extends StatelessWidget {
  const CaixaDestaque({super.key, required this.tipo, required this.texto});

  final TipoDestaque tipo;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: tipo.cor.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tipo.cor.withValues(alpha: 0.20)),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 3, color: tipo.cor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(tipo.icone, size: 13, color: tipo.cor),
                          const SizedBox(width: 6),
                          Text(
                            tipo.rotulo(context.textos).toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: tipo.cor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      TextoRico(texto, tamanho: 14.5),
                    ],
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
