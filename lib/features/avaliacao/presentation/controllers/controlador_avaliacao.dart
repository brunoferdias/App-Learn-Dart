import 'package:flutter/foundation.dart';

import '../../domain/entities/estado_avaliacao.dart';
import '../../domain/entities/momento_avaliacao.dart';
import '../../domain/entities/politica_avaliacao.dart';
import '../../domain/repositories/loja_de_apps.dart';
import '../../domain/usecases/gerenciar_avaliacao.dart';

/// Decide se, e quando, a caixa de avaliação da loja aparece.
///
/// As telas só avisam "terminou uma lição", "gabaritou o quiz" — quem julga se
/// aquilo vira um pedido é a [PoliticaAvaliacao]. Nenhuma tela chama a loja
/// direto.
class ControladorAvaliacao extends ChangeNotifier {
  ControladorAvaliacao({
    required this.carregar,
    required this.registrar,
    required this.registrarPedido,
    required this.encerrar,
    required this.loja,
    this.relogio = DateTime.now,
    this.esperaAntesDeAparecer = const Duration(milliseconds: 900),
  });

  final CarregarAvaliacao carregar;
  final RegistrarMomento registrar;
  final RegistrarPedido registrarPedido;
  final EncerrarPedidos encerrar;

  final LojaDeApps loja;

  /// Injetável para o teste poder simular "três dias depois".
  final DateTime Function() relogio;

  /// Um respiro para a tela de resultado terminar de aparecer antes da caixa
  /// da loja: pedir por cima de uma animação parece um pop-up.
  final Duration esperaAntesDeAparecer;

  EstadoAvaliacao _estado = const EstadoAvaliacao();
  EstadoAvaliacao get estado => _estado;

  bool _pedindo = false;

  /// A pessoa já avaliou pelo botão do perfil.
  bool get jaAvaliou => _estado.encerrado;

  Future<void> iniciar() async {
    _estado = await carregar(agora: relogio());
    notifyListeners();
  }

  /// Chamado pelas telas nos pontos altos do uso. Nunca lança e nunca precisa
  /// de `await`: se não for hora, some sem deixar rastro na interface.
  Future<void> registrarMomento(MomentoAvaliacao momento) async {
    if (_estado.encerrado || _pedindo) return;

    _estado = await registrar(_estado, momento);
    notifyListeners();

    await _talvezPedir();
  }

  Future<void> _talvezPedir() async {
    if (!PoliticaAvaliacao.podePedir(_estado, agora: relogio())) return;
    if (!await loja.aceitaPedidoNativo()) return;

    _pedindo = true;
    try {
      await Future<void>.delayed(esperaAntesDeAparecer);

      // O pedido é registrado antes de aparecer: se o iOS decidir não mostrar
      // a caixa (ele tem um limite próprio), ainda assim não insistimos.
      _estado = await registrarPedido(_estado, relogio());
      notifyListeners();

      await loja.pedirAvaliacao();
    } finally {
      _pedindo = false;
    }
  }

  /// O caminho explícito: o botão do perfil. Abre a ficha na loja e desliga o
  /// pedido automático de vez.
  Future<void> avaliarNaLoja() async {
    _estado = await encerrar(_estado);
    notifyListeners();

    await loja.abrirFichaParaAvaliar();
  }
}
