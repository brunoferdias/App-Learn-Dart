import 'package:flutter/cupertino.dart';

import '../tema/cores_app.dart';
import '../tema/tema_app.dart';

final RegExp _marcacao = RegExp(r'\*\*(.+?)\*\*|`(.+?)`');

class TextoRico extends StatelessWidget {
  const TextoRico(
    this.texto, {
    super.key,
    this.tamanho = 16,
    this.cor,
    this.alturaLinha = 1.55,
  });

  final String texto;
  final double tamanho;
  final Color? cor;
  final double alturaLinha;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final corBase = cor ?? paleta.texto;
    final spans = <InlineSpan>[];
    var posicao = 0;

    for (final m in _marcacao.allMatches(texto)) {
      if (m.start > posicao) {
        spans.add(TextSpan(text: texto.substring(posicao, m.start)));
      }

      final negrito = m.group(1);
      final codigo = m.group(2);

      if (negrito != null) {
        spans.add(
          TextSpan(
            text: negrito,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        );
      } else if (codigo != null) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: BoxDecoration(
                color: CoresApp.azulDart.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: CoresApp.azulDart.withValues(alpha: 0.22),
                ),
              ),
              child: Text(
                codigo,
                style: TextStyle(
                  fontFamily: TemaApp.fonteMono,
                  fontSize: tamanho - 2.5,
                  color: paleta.escuro
                      ? CoresApp.azulClaroDart
                      : CoresApp.azulEscuroDart,
                ),
              ),
            ),
          ),
        );
      }
      posicao = m.end;
    }

    if (posicao < texto.length) {
      spans.add(TextSpan(text: texto.substring(posicao)));
    }

    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: tamanho,
          height: alturaLinha,
          color: corBase,
          letterSpacing: -0.2,
        ),
        children: spans,
      ),
    );
  }
}
