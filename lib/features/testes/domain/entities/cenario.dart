import 'finder_simulado.dart';
import 'matcher_simulado.dart';
import 'no_widget.dart';

class Desafio {
  const Desafio({
    required this.enunciado,
    required this.finder,
    required this.matcher,
    required this.dica,
    this.exigeInteracao = false,
  });

  final String enunciado;
  final FinderSimulado finder;
  final MatcherSimulado matcher;
  final String dica;

  final bool exigeInteracao;

  bool resolvidoPor({
    required FinderSimulado finder,
    required MatcherSimulado matcher,
    required bool comInteracao,
  }) =>
      finder.codigo == this.finder.codigo &&
      matcher.codigo == this.matcher.codigo &&
      comInteracao == exigeInteracao;
}

class Cenario {
  const Cenario({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.codigoFonte,
    required this.arvore,
    required this.finders,
    required this.desafio,
    this.arvoreAposToque,
    this.acaoDeToque,
  });

  final String id;
  final String titulo;
  final String resumo;

  final String codigoFonte;

  final NoWidget arvore;

  final NoWidget? arvoreAposToque;

  final String? acaoDeToque;

  final List<FinderSimulado> finders;
  final Desafio desafio;

  bool get temInteracao => arvoreAposToque != null;

  NoWidget arvoreEm({required bool aposToque}) =>
      aposToque ? (arvoreAposToque ?? arvore) : arvore;
}
