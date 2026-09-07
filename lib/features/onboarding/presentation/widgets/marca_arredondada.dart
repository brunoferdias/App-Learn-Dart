import 'package:flutter/cupertino.dart';

class MarcaArredondada extends StatelessWidget {
  const MarcaArredondada({super.key, this.tamanho = 96, this.sombra = true});

  final double tamanho;
  final bool sombra;

  @override
  Widget build(BuildContext context) {
    final raio = Radius.circular(tamanho * 0.2237);

    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(raio),
        boxShadow: sombra
            ? [
                BoxShadow(
                  color: const Color(0xFF001B2E).withValues(alpha: 0.45),
                  blurRadius: tamanho * 0.28,
                  offset: Offset(0, tamanho * 0.09),
                ),
              ]
            : null,
      ),
      child: ClipRSuperellipse(
        borderRadius: BorderRadius.all(raio),
        child: Image.asset(
          'assets/icon_dart.png',
          width: tamanho,
          height: tamanho,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}
