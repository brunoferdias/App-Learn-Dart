import 'package:flutter/foundation.dart';

import '../../../../core/i18n/textos.dart';
import '../../domain/entities/cenario.dart';
import '../../domain/entities/finder_simulado.dart';
import '../../domain/entities/matcher_simulado.dart';
import '../../domain/entities/resultado_teste.dart';
import '../../domain/usecases/listar_cenarios.dart';
import '../../domain/usecases/rodar_teste.dart';

class ControladorLaboratorio extends ChangeNotifier {
  ControladorLaboratorio({
    required this.listarCenarios,
    this.rodarTeste = const RodarTeste(),
  });

  final ListarCenarios listarCenarios;
  final RodarTeste rodarTeste;

  bool _carregando = true;
  bool get carregando => _carregando;

  String? _erro;
  String? get erro => _erro;

  List<Cenario> _cenarios = const [];
  List<Cenario> get cenarios => _cenarios;

  int _indice = 0;
  int get indice => _indice;
  Cenario get cenario => _cenarios[_indice];

  FinderSimulado? _finder;
  FinderSimulado? get finder => _finder;

  MatcherSimulado? _matcher;
  MatcherSimulado? get matcher => _matcher;

  int _quantidadeN = 2;
  int get quantidadeN => _quantidadeN;

  bool _comInteracao = false;
  bool get comInteracao => _comInteracao;

  bool _mostrandoDica = false;
  bool get mostrandoDica => _mostrandoDica;

  ResultadoTeste? _resultado;
  ResultadoTeste? get resultado => _resultado;

  final Set<String> _resolvidos = {};
  int get desafiosResolvidos => _resolvidos.length;
  bool get desafioAtualResolvido =>
      _cenarios.isNotEmpty && resolveu(cenario.id);

  bool resolveu(String idDoCenario) => _resolvidos.contains(idDoCenario);

  List<MatcherSimulado> get matchers => [
    const EncontraUm(),
    const EncontraNada(),
    const EncontraVarios(),
    EncontraN(_quantidadeN),
  ];

  bool get podeRodar => _finder != null && _matcher != null;

  String get linhaExpect =>
      'expect(${_finder?.codigo ?? '…'}, ${_matcher?.codigo ?? '…'});';

  Future<void> carregar(Textos textos) async {
    final resultado = await listarCenarios(textos);

    resultado.quando(
      sucesso: (lista) {
        _cenarios = lista;
        _erro = null;
      },
      falha: (mensagem) => _erro = mensagem,
    );

    _carregando = false;
    notifyListeners();
  }

  void escolherFinder(FinderSimulado novo) {
    _finder = _finder?.codigo == novo.codigo ? null : novo;
    _limparResultado();
  }

  void escolherMatcher(MatcherSimulado novo) {
    _matcher = _matcher?.codigo == novo.codigo ? null : novo;
    _limparResultado();
  }

  void ajustarQuantidade(int delta) {
    final nova = (_quantidadeN + delta).clamp(0, 9);
    if (nova == _quantidadeN) return;
    _quantidadeN = nova;
    if (_matcher is EncontraN) _matcher = EncontraN(_quantidadeN);
    _limparResultado();
  }

  void alternarInteracao() {
    if (!cenario.temInteracao) return;
    _comInteracao = !_comInteracao;
    _limparResultado();
  }

  void alternarDica() {
    _mostrandoDica = !_mostrandoDica;
    notifyListeners();
  }

  void rodar() {
    final finder = _finder;
    final matcher = _matcher;
    if (finder == null || matcher == null) return;

    final resultado = rodarTeste(
      cenario: cenario,
      finder: finder,
      matcher: matcher,
      comInteracao: _comInteracao,
    );

    if (resultado.passou &&
        cenario.desafio.resolvidoPor(
          finder: finder,
          matcher: matcher,
          comInteracao: _comInteracao,
        )) {
      _resolvidos.add(cenario.id);
    }

    _resultado = resultado;
    notifyListeners();
  }

  void irPara(int novoIndice) {
    if (novoIndice < 0 || novoIndice >= _cenarios.length) return;
    _indice = novoIndice;
    _finder = null;
    _matcher = null;
    _comInteracao = false;
    _mostrandoDica = false;
    _resultado = null;
    notifyListeners();
  }

  void proximo() => irPara(_indice + 1);

  void _limparResultado() {
    _resultado = null;
    notifyListeners();
  }
}
