import 'package:flutter/widgets.dart';

import 'textos.dart';

class EscopoTextos extends InheritedWidget {
  const EscopoTextos({super.key, required this.textos, required super.child});

  final Textos textos;

  static Textos de(BuildContext context) {
    final escopo = context.dependOnInheritedWidgetOfExactType<EscopoTextos>();
    assert(escopo != null, 'EscopoTextos não encontrado acima deste widget.');
    return escopo!.textos;
  }

  @override
  bool updateShouldNotify(EscopoTextos oldWidget) =>
      textos.idioma != oldWidget.textos.idioma;
}

extension TextosDoContexto on BuildContext {
  Textos get textos => EscopoTextos.de(this);
}
