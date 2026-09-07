import 'package:flutter/cupertino.dart';

import '../tema/tema_app.dart';

class Cartao extends StatelessWidget {
  const Cartao({
    super.key,
    required this.child,
    this.aoTocar,
    this.padding = const EdgeInsets.all(16),
    this.corFundo,
    this.corBorda,
  });

  final Widget child;
  final VoidCallback? aoTocar;
  final EdgeInsets padding;
  final Color? corFundo;
  final Color? corBorda;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    final conteudo = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: corFundo ?? paleta.superficie,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: corBorda ?? paleta.borda),
      ),
      child: child,
    );

    if (aoTocar == null) return conteudo;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: aoTocar,
      child: conteudo,
    );
  }
}
