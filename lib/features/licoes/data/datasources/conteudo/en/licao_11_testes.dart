import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao11TestesEn = Licao(
  id: 'testes-widget',
  titulo: 'Widget tests',
  resumo: 'Prove the screen works without opening the emulator.',
  nivel: NivelLicao.avancado,
  minutos: 12,
  objetivos: [
    'Write your first testWidgets from scratch',
    'Pick the right finder and matcher for each situation',
    'Know when to use pump() and when to use pumpAndSettle()',
    'Catch layout overflow automatically, without opening the app',
  ],
  blocos: [
    BlocoTexto(
      'The widget test is Flutter\'s sweet spot: it builds the screen **in '
      'memory**, with no emulator, and answers in milliseconds. You tap, type, '
      'scroll and check — all from code.',
    ),
    BlocoTabela(
      cabecalho: ('Level', 'What it covers'),
      linhas: [
        ('test', 'A pure function or class, no screen. Blisteringly fast.'),
        ('testWidgets', 'ONE screen built in a fake tree. This one.'),
        ('integration_test', 'The whole app on a real device. Slow.'),
      ],
    ),
    BlocoTexto(
      'Rule of thumb: **widget tests for reusable components**, plus three or '
      'four whole-app tests for the critical flows. This project has both: '
      '`test/aula_widget_test.dart` and `test/app_test.dart`.',
    ),

    BlocoTitulo('The cycle: build, find, assert'),
    BlocoTexto(
      'Every widget test is the same dance. The `tester` is a robot that '
      'builds the tree, looks for things in it and answers questions about '
      'what it found.',
    ),
    BlocoCodigo(
      '''
testWidgets('the tag shows its text', (tester) async {
  // 1. BUILD — constructs the tree and paints the first frame.
  await tester.pumpWidget(
    const CupertinoApp(home: Etiqueta('Beginner', cor: CoresApp.acerto)),
  );

  // 2. FIND + 3. ASSERT
  expect(find.text('Beginner'), findsOneWidget);
  expect(find.text('Advanced'), findsNothing);
});''',
      legenda: 'That is the whole test — nothing else is hidden away',
      saida: '00:00 +1: All tests passed!',
    ),
    BlocoDica(
      'A widget on its own rarely runs alone: if it uses `context.paleta` or '
      '`Theme.of(context)`, it needs a `CupertinoApp` above it. That is why '
      'every project ends up with a `montar(widget)` helper.',
    ),

    BlocoTitulo('Finders: how the robot sees'),
    BlocoTexto(
      'A finder is just a question asked of every node in the tree: **"do you '
      'match me?"**. The list below runs from the most durable to the most '
      'fragile.',
    ),
    BlocoTabela(
      cabecalho: ('Finder', 'Matches'),
      linhas: [
        ("find.text('Practice')", 'What the user READS. Survives refactoring.'),
        ('find.byIcon(CupertinoIcons.star_fill)', 'The icon that is drawn.'),
        ('find.byType(Etiqueta)', 'The widget type. Great for your own.'),
        ("find.byKey(const Key('x'))", 'The tie-breaker when text repeats.'),
        ('find.byWidgetPredicate(...)', 'Last resort: filter by property.'),
      ],
    ),
    BlocoAviso(
      'Avoid depending on internal structure ("the third Container inside the '
      'Row"). That kind of test breaks on every layout change, without '
      'anything actually being broken.',
    ),

    BlocoTitulo('Matchers: how many did you expect?'),
    BlocoTexto(
      'The finder answers **how many I found**. The matcher judges that '
      'number — and when it fails, writes the message you will read in the '
      'terminal.',
    ),
    BlocoTabela(
      cabecalho: ('Matcher', 'Passes when'),
      linhas: [
        ('findsOneWidget', 'Found exactly 1'),
        ('findsNothing', 'Found none — and that is a fine test in itself'),
        ('findsWidgets', 'Found 1 or more'),
        ('findsNWidgets(3)', 'Found exactly 3'),
      ],
    ),

    BlocoLaboratorio(
      titulo: 'Testing lab',
      chamada:
          'Your turn: build `expect(finder, matcher)` by tapping the '
          'pieces, run it, and see **which widgets the finder caught**, '
          'highlighted on screen. Four challenges, with the real output of '
          '`flutter test`.',
    ),

    BlocoTitulo('Interaction: tap, type, scroll'),
    BlocoCodigo(
      '''
var taps = 0; // the "spy" that proves the callback ran

await tester.pumpWidget(montar(
  OpcaoResposta(texto: 'final', letra: 'A', aoTocar: () => taps++),
));

await tester.tap(find.byType(OpcaoResposta));
await tester.pump(); // ← advance one frame

expect(taps, 1);''',
      legenda: 'tap, enterText and drag all follow this same shape',
    ),
    BlocoAviso(
      'Beginner mistake number one: **forgetting the `pump` after the tap**. '
      'The interaction changes the state, but the screen only reflects it on '
      'the NEXT frame — without the pump, the test "does not see" the change '
      'and fails with `findsNothing`.',
    ),

    BlocoTitulo('pump() or pumpAndSettle()?'),
    BlocoTabela(
      cabecalho: ('Call', 'When to use it'),
      linhas: [
        ('pump()', 'Paints ONE frame. No animation involved.'),
        (
          'pump(Duration)',
          'Advances the clock. To catch the MIDDLE of an animation.',
        ),
        (
          'pumpAndSettle()',
          'Repeats until things settle. After navigating or animating.',
        ),
      ],
    ),
    BlocoAviso(
      '`pumpAndSettle()` HANGS with a timeout if something animates forever — '
      'a `CupertinoActivityIndicator` on screen, for instance. Use '
      '`pump(Duration(...))` in that case.',
    ),

    BlocoTitulo('What separates a good test from a fragile one'),
    BlocoComparacao(
      codigoErrado: '''
final container = tester.widget<Container>(
  find.byType(Container).at(2),
);
expect((container.decoration as BoxDecoration).color, green);''',
      notaErrado:
          'It depends on HOW MANY Containers exist and on their ORDER. '
          'One extra `Padding` in the layout and the test breaks for no reason.',
      codigoCerto: '''
await tester.tap(find.text('String? accepts null'));
await tester.pumpAndSettle();
expect(find.byIcon(CupertinoIcons.checkmark_circle_fill), findsOneWidget);''',
      notaCerto:
          'It describes what the USER does and what they see. It '
          'survives any refactor that does not change the behaviour.',
    ),

    BlocoTitulo('A freebie: overflow turns the test red'),
    BlocoTexto(
      'That yellow-and-black `RenderFlex overflowed` stripe becomes an '
      '**exception** inside the test. Which means you can hunt overflow on '
      'small screens without opening a single simulator.',
    ),
    BlocoCodigo('''
testWidgets('nothing overflows on an iPhone SE', (tester) async {
  tester.view.physicalSize = const Size(320 * 3, 568 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const AprendaDartApp());
  await tester.pumpAndSettle();
  // Had there been overflow, the pump above would already have thrown.
});''', legenda: 'This is the test that guards this app\'s layout'),
    BlocoDica(
      'Run everything with `flutter test`, or a single file with '
      '`flutter test test/aula_widget_test.dart`. That project file has 17 '
      'tests commented line by line — the long version of this lesson.',
    ),
  ],
);
