import 'package:flutter/widgets.dart';

import 'injecao.dart';

class EscopoApp extends InheritedWidget {
  const EscopoApp({super.key, required this.injecao, required super.child});

  final Injecao injecao;

  static Injecao de(BuildContext context) {
    final escopo = context.getInheritedWidgetOfExactType<EscopoApp>();

    assert(escopo != null, 'EscopoApp não encontrado acima deste widget.');
    return escopo!.injecao;
  }

  @override
  bool updateShouldNotify(EscopoApp oldWidget) => false;
}
