import 'package:flutter/foundation.dart';

import '../../../../core/i18n/textos.dart';
import '../../domain/entities/licao.dart';
import '../../domain/usecases/listar_licoes.dart';

sealed class EstadoLicoes {
  const EstadoLicoes();
}

final class LicoesCarregando extends EstadoLicoes {
  const LicoesCarregando();
}

final class LicoesCarregadas extends EstadoLicoes {
  const LicoesCarregadas(this.licoes);
  final List<Licao> licoes;
}

final class LicoesComErro extends EstadoLicoes {
  const LicoesComErro(this.mensagem);
  final String mensagem;
}

class ControladorLicoes extends ChangeNotifier {
  ControladorLicoes({required this.listarLicoes});

  final ListarLicoes listarLicoes;

  EstadoLicoes _estado = const LicoesCarregando();
  EstadoLicoes get estado => _estado;

  Future<void> carregar(Textos textos) async {
    _estado = const LicoesCarregando();
    notifyListeners();

    final resultado = await listarLicoes(textos);

    _estado = resultado.quando(
      sucesso: LicoesCarregadas.new,
      falha: LicoesComErro.new,
    );
    notifyListeners();
  }
}
