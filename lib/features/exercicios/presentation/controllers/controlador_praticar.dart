import 'package:flutter/foundation.dart';

import '../../../../core/i18n/textos.dart';
import '../../../licoes/domain/entities/licao.dart';
import '../../../licoes/domain/usecases/listar_licoes.dart';
import '../../domain/usecases/listar_exercicios.dart';

class ControladorPraticar extends ChangeNotifier {
  ControladorPraticar({
    required this.listarLicoes,
    required this.listarExercicios,
  });

  final ListarLicoes listarLicoes;
  final ListarExercicios listarExercicios;

  bool _carregando = true;
  bool get carregando => _carregando;

  List<(Licao licao, int quantidade)> _itens = const [];
  List<(Licao licao, int quantidade)> get itens => _itens;

  int get totalExercicios =>
      _itens.fold<int>(0, (soma, item) => soma + item.$2);

  Future<void> carregar(Textos textos) async {
    _carregando = true;
    notifyListeners();

    final (rLicoes, rExercicios) = await (
      listarLicoes(textos),
      listarExercicios(textos),
    ).wait;

    final licoes = rLicoes.valorOuNulo ?? const [];
    final exercicios = rExercicios.valorOuNulo ?? const [];

    _itens = [
      for (final licao in licoes)
        (licao, exercicios.where((e) => e.licaoId == licao.id).length),
    ];

    _carregando = false;
    notifyListeners();
  }
}
