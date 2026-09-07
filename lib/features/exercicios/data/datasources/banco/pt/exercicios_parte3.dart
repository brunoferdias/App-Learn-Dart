import '../../../../domain/entities/exercicio.dart';

const List<Exercicio> exerciciosParte3 = [
  ExercicioCertoOuErrado(
    id: 'e11-1',
    licaoId: 'testes-widget',
    enunciado: 'Este teste passa?',
    codigo: '''testWidgets('conta o toque', (tester) async {
  var toques = 0;
  await tester.pumpWidget(montar(Botao(aoTocar: () => toques++)));

  await tester.tap(find.byType(Botao));
  expect(toques, 1);
});''',
    estaCorreto: true,
    explicacao:
        'Passa. O callback roda no próprio toque, então `toques` já vale 1. O '
        '`pump` só é obrigatório quando você vai AFIRMAR algo sobre a TELA — '
        'aí sim o novo frame precisa ser desenhado antes do `expect`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e11-2',
    licaoId: 'testes-widget',
    enunciado: 'Este teste falha. Qual é a linha que falta?',
    codigo: '''await tester.tap(find.text('Responder'));
expect(find.text('Resposta enviada'), findsOneWidget);
// TestFailure: Expected: exactly one matching candidate
//   Actual: _TextWidgetFinder:<Found 0 widgets ...>''',
    opcoes: [
      'await tester.pump(); depois do tap',
      'await tester.pumpWidget(...); depois do tap',
      'tester.view.resetPhysicalSize(); no fim',
      'expectLater em vez de expect',
    ],
    resposta: 0,
    explicacao:
        'O toque mudou o estado, mas a tela só reflete isso no PRÓXIMO frame. '
        'Sem `pump()` (ou `pumpAndSettle()` se houver animação) o teste procura '
        'numa árvore que ainda é a antiga.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e11-3',
    licaoId: 'testes-widget',
    enunciado:
        'A tela tem duas etiquetas com o texto "Nível". Qual finder '
        'alcança apenas a segunda?',
    opcoes: [
      "find.byKey(const Key('etiqueta-tema'))",
      "find.text('Nível')",
      'find.byType(Etiqueta)',
      "find.text('Nível').first",
    ],
    resposta: 0,
    explicacao:
        'A Key existe exatamente para desempatar widgets que o usuário vê '
        'iguais. `.first` até funciona, mas depende da ORDEM na árvore — muda '
        'o layout, muda o teste.',
  ),
  ExercicioCompletar(
    id: 'e11-4',
    licaoId: 'testes-widget',
    enunciado: 'Complete: você quer provar que o painel ainda NÃO apareceu.',
    codigoComLacuna: '''expect(find.byType(PainelExplicacao), ___);''',
    opcoes: ['findsNothing', 'findsNWidgets(0)', 'isNull', 'findsOneWidget'],
    resposta: 0,
    explicacao:
        '`findsNothing` é o matcher para "nenhum widget encontrado". '
        '`isNull` não serve: um Finder nunca é null, ele é um objeto que '
        'procura. E `findsNWidgets(0)` funciona, mas ninguém escreve assim.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e11-5',
    licaoId: 'testes-widget',
    enunciado:
        'A tela tem um CupertinoActivityIndicator girando para sempre. '
        'O que acontece com `await tester.pumpAndSettle()`?',
    opcoes: [
      'Trava e o teste falha por timeout',
      'Desenha um frame e segue em frente',
      'Para a animação automaticamente',
      'Lança "RenderFlex overflowed"',
    ],
    resposta: 0,
    explicacao:
        '`pumpAndSettle` repete frames até NÃO haver mais nada agendado. Com '
        'uma animação infinita esse momento nunca chega. Nesses casos use '
        '`pump(Duration(...))`, que avança um tanto e devolve o controle.',
  ),
  ExercicioCertoOuErrado(
    id: 'e11-6',
    licaoId: 'testes-widget',
    enunciado:
        'Este teste é uma boa forma de checar a cor do estado de acerto?',
    codigo: '''final container = tester.widget<Container>(
  find.byType(Container).at(3),
);
expect((container.decoration as BoxDecoration).color, CoresApp.acerto);''',
    estaCorreto: false,
    explicacao:
        'Depende de quantos Containers existem e da ordem deles — um Padding a '
        'mais no layout e o teste quebra sem nada ter estragado. Prefira mirar '
        'no que o usuário vê: `find.byIcon(...)` ou `find.text(...)`.',
  ),
];
