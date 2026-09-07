import 'package:flutter/cupertino.dart';

class Etiqueta extends StatelessWidget {
  const Etiqueta(
    this.texto, {
    super.key,
    required this.cor,
    this.icone,
    this.preenchida = false,
  });

  final String texto;
  final Color cor;
  final IconData? icone;
  final bool preenchida;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: preenchida ? 1 : 0.13),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cor.withValues(alpha: preenchida ? 1 : 0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icone case final i?) ...[
            Icon(i, size: 11, color: preenchida ? CupertinoColors.white : cor),
            const SizedBox(width: 4),
          ],
          Text(
            texto,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
              color: preenchida ? CupertinoColors.white : cor,
            ),
          ),
        ],
      ),
    );
  }
}
