import '../entities/cenario.dart';
import '../entities/finder_simulado.dart';
import '../entities/matcher_simulado.dart';
import '../entities/no_widget.dart';
import '../entities/resultado_teste.dart';

class RodarTeste {
  const RodarTeste();

  ResultadoTeste call({
    required Cenario cenario,
    required FinderSimulado finder,
    required MatcherSimulado matcher,
    bool comInteracao = false,
  }) {
    final arvore = cenario.arvoreEm(aposToque: comInteracao);
    final encontrados = finder.encontrar(arvore);
    final quantidade = encontrados.length;
    final passou = matcher.aceita(quantidade);

    final linhaExpect = 'expect(${finder.codigo}, ${matcher.codigo});';

    return ResultadoTeste(
      passou: passou,
      linhaExpect: linhaExpect,
      quantidadeEncontrada: quantidade,
      caminhosEncontrados: [for (final e in encontrados) e.caminho],
      saida: passou
          ? _saidaDeSucesso(cenario, comInteracao)
          : _saidaDeFalha(
              finder: finder,
              matcher: matcher,
              encontrados: encontrados,
            ),
    );
  }

  List<LinhaSaida> _saidaDeSucesso(Cenario cenario, bool comInteracao) => [
    (tom: TomSaida.apagado, texto: '00:00 +0: ${cenario.titulo}'),
    if (comInteracao)
      (tom: TomSaida.apagado, texto: '   ${cenario.acaoDeToque}'),
    (tom: TomSaida.sucesso, texto: '00:00 +1: All tests passed!'),
  ];

  List<LinhaSaida> _saidaDeFalha({
    required FinderSimulado finder,
    required MatcherSimulado matcher,
    required List<NoLocalizado> encontrados,
  }) {
    final quantidade = encontrados.length;

    final corpo = quantidade == 0
        ? '[]'
        : '[\n${[for (final e in encontrados) '            ${e.no.rotulo},'].join('\n')}\n          ]';

    return [
      (
        tom: TomSaida.falha,
        texto: '══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞══',
      ),
      (
        tom: TomSaida.normal,
        texto: 'The following TestFailure was thrown running a test:',
      ),
      (tom: TomSaida.normal, texto: 'Expected: ${matcher.esperado}'),
      (
        tom: TomSaida.normal,
        texto:
            '  Actual: ${finder.nomeInterno}:<Found $quantidade '
            '${finder.descricao}: $corpo>',
      ),
      (tom: TomSaida.falha, texto: '   Which: ${matcher.motivo(quantidade)}'),
      (tom: TomSaida.falha, texto: '00:01 -1: Some tests failed.'),
    ];
  }
}
