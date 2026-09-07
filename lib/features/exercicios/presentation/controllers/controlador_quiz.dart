import 'package:flutter/foundation.dart';

import '../../../../core/i18n/textos.dart';
import '../../domain/entities/exercicio.dart';
import '../../domain/usecases/corrigir_exercicio.dart';
import '../../domain/usecases/listar_exercicios.dart';

class ControladorQuiz extends ChangeNotifier {
  ControladorQuiz({
    required this.listarExercicios,
    required this.corrigirExercicio,
    this.aoResponder,
  });

  final ListarExercicios listarExercicios;
  final CorrigirExercicio corrigirExercicio;

  final void Function({required bool acertou})? aoResponder;

  List<Exercicio> _exercicios = const [];
  int _indice = 0;
  int? _escolha;
  int _acertos = 0;
  bool _carregando = true;
  String? _erro;

  bool get carregando => _carregando;
  String? get erro => _erro;
  List<Exercicio> get exercicios => _exercicios;
  int get indice => _indice;
  int get total => _exercicios.length;
  int get acertos => _acertos;
  int? get escolha => _escolha;
  bool get respondeu => _escolha != null;
  bool get ehUltimo => _indice >= total - 1;
  bool get terminou => _indice >= total;

  Exercicio? get atual =>
      _indice < _exercicios.length ? _exercicios[_indice] : null;

  double get progresso => total == 0 ? 0 : (_indice) / total;

  Future<void> carregar(Textos textos, {String? licaoId}) async {
    _carregando = true;
    notifyListeners();

    final resultado = await listarExercicios(textos, licaoId: licaoId);

    resultado.quando(
      sucesso: (lista) {
        _exercicios = lista;
        _erro = null;
      },
      falha: (msg) => _erro = msg,
    );

    _carregando = false;
    _indice = 0;
    _escolha = null;
    _acertos = 0;
    notifyListeners();
  }

  ({bool acertou, int indiceCorreto, String explicacao})? responder(
    int indiceEscolhido,
  ) {
    if (_escolha != null) return null;

    final exercicio = atual;
    if (exercicio == null) return null;

    _escolha = indiceEscolhido;
    final correcao = corrigirExercicio(exercicio, indiceEscolhido);
    if (correcao.acertou) _acertos++;

    aoResponder?.call(acertou: correcao.acertou);

    notifyListeners();
    return correcao;
  }

  void proximo() {
    _indice++;
    _escolha = null;
    notifyListeners();
  }

  void reiniciar() {
    _indice = 0;
    _escolha = null;
    _acertos = 0;
    notifyListeners();
  }
}
