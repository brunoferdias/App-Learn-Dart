import '../../../../domain/entities/exercicio.dart';

const List<Exercicio> exerciciosParte3En = [
  ExercicioCertoOuErrado(
    id: 'e11-1',
    licaoId: 'testes-widget',
    enunciado: 'Does this test pass?',
    codigo: '''testWidgets('counts the tap', (tester) async {
  var taps = 0;
  await tester.pumpWidget(montar(Button(onTap: () => taps++)));

  await tester.tap(find.byType(Button));
  expect(taps, 1);
});''',
    estaCorreto: true,
    explicacao:
        'It passes. The callback runs on the tap itself, so `taps` is already '
        '1. The `pump` is only mandatory when you are going to ASSERT '
        'something about the SCREEN — then the new frame has to be painted '
        'before the `expect`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e11-2',
    licaoId: 'testes-widget',
    enunciado: 'This test fails. Which line is missing?',
    codigo: '''await tester.tap(find.text('Answer'));
expect(find.text('Answer sent'), findsOneWidget);
// TestFailure: Expected: exactly one matching candidate
//   Actual: _TextWidgetFinder:<Found 0 widgets ...>''',
    opcoes: [
      'await tester.pump(); after the tap',
      'await tester.pumpWidget(...); after the tap',
      'tester.view.resetPhysicalSize(); at the end',
      'expectLater instead of expect',
    ],
    resposta: 0,
    explicacao:
        'The tap changed the state, but the screen only reflects that on the '
        'NEXT frame. Without `pump()` (or `pumpAndSettle()` when there is an '
        'animation) the test searches a tree that is still the old one.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e11-3',
    licaoId: 'testes-widget',
    enunciado:
        'The screen has two tags reading "Level". Which finder reaches '
        'only the second one?',
    opcoes: [
      "find.byKey(const Key('tag-theme'))",
      "find.text('Level')",
      'find.byType(Etiqueta)',
      "find.text('Level').first",
    ],
    resposta: 0,
    explicacao:
        'The Key exists precisely to break ties between widgets the user sees '
        'as identical. `.first` does work, but it depends on the ORDER in the '
        'tree — change the layout, change the test.',
  ),
  ExercicioCompletar(
    id: 'e11-4',
    licaoId: 'testes-widget',
    enunciado: 'Fill in: you want to prove the panel has NOT appeared yet.',
    codigoComLacuna: '''expect(find.byType(PainelExplicacao), ___);''',
    opcoes: ['findsNothing', 'findsNWidgets(0)', 'isNull', 'findsOneWidget'],
    resposta: 0,
    explicacao:
        '`findsNothing` is the matcher for "no widget found". `isNull` will '
        'not do: a Finder is never null, it is an object that searches. And '
        '`findsNWidgets(0)` works, but nobody writes it that way.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e11-5',
    licaoId: 'testes-widget',
    enunciado:
        'The screen has a CupertinoActivityIndicator spinning forever. '
        'What happens to `await tester.pumpAndSettle()`?',
    opcoes: [
      'It hangs and the test fails with a timeout',
      'It paints one frame and carries on',
      'It stops the animation automatically',
      'It throws "RenderFlex overflowed"',
    ],
    resposta: 0,
    explicacao:
        '`pumpAndSettle` repeats frames until there is NOTHING left scheduled. '
        'With an endless animation that moment never comes. In those cases use '
        '`pump(Duration(...))`, which advances a set amount and hands control '
        'back.',
  ),
  ExercicioCertoOuErrado(
    id: 'e11-6',
    licaoId: 'testes-widget',
    enunciado: 'Is this a good way to check the colour of the correct state?',
    codigo: '''final container = tester.widget<Container>(
  find.byType(Container).at(3),
);
expect((container.decoration as BoxDecoration).color, CoresApp.acerto);''',
    estaCorreto: false,
    explicacao:
        'It depends on how many Containers exist and on their order — one '
        'extra Padding in the layout and the test breaks with nothing actually '
        'broken. Aim at what the user sees instead: `find.byIcon(...)` or '
        '`find.text(...)`.',
  ),
];
