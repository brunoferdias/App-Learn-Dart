import 'package:flutter/foundation.dart';

import '../../../../core/i18n/textos.dart';
import '../../domain/entities/progresso.dart';
import '../../domain/usecases/gerenciar_progresso.dart';

class ControladorProgresso extends ChangeNotifier {
  ControladorProgresso({
    required this.carregar,
    required this.concluir,
    required this.registrar,
    required this.apagar,
    required this.textos,
  });

  Textos textos;

  final CarregarProgresso carregar;
  final ConcluirLicao concluir;
  final RegistrarResposta registrar;
  final ApagarProgresso apagar;

  Progresso _progresso = const Progresso();
  Progresso get progresso => _progresso;

  Future<void> iniciar() async {
    final r = await carregar(textos);
    _progresso = r.valorOuNulo ?? const Progresso();
    notifyListeners();
  }

  Future<void> marcarLicaoConcluida(String licaoId) async {
    if (_progresso.concluiu(licaoId)) return;
    final r = await concluir(_progresso, licaoId, textos);
    _progresso = r.valorOuNulo ?? _progresso;
    notifyListeners();
  }

  Future<void> registrarResposta({required bool acertou}) async {
    final r = await registrar(_progresso, textos, acertou: acertou);
    _progresso = r.valorOuNulo ?? _progresso;
    notifyListeners();
  }

  /// Devolve `true` quando o apagamento foi até o fim — a tela só avisa
  /// "pronto" se o disco realmente ficou limpo.
  Future<bool> apagarDados() async {
    final r = await apagar(textos);
    final zerado = r.valorOuNulo;
    if (zerado == null) return false;
    _progresso = zerado;
    notifyListeners();
    return true;
  }
}
