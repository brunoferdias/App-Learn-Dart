import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao11Testes = Licao(
  id: 'testes-widget',
  titulo: 'Testes de widget',
  resumo: 'Prove que a tela funciona sem abrir o emulador.',
  nivel: NivelLicao.avancado,
  minutos: 12,
  objetivos: [
    'Escrever seu primeiro testWidgets do zero',
    'Escolher o finder e o matcher certos para cada situação',
    'Saber quando usar pump() e quando usar pumpAndSettle()',
    'Pegar overflow de layout automaticamente, sem abrir o app',
  ],
  blocos: [
    BlocoTexto(
      'Teste de widget é o ponto doce do Flutter: ele monta a tela **em '
      'memória**, sem emulador, e responde em milissegundos. Você toca, '
      'digita, rola e confere — tudo por código.',
    ),
    BlocoTabela(
      cabecalho: ('Nível', 'O que cobre'),
      linhas: [
        ('test', 'Uma função ou classe pura, sem tela. Rápido demais.'),
        ('testWidgets', 'UMA tela montada numa árvore de mentira. Este aqui.'),
        ('integration_test', 'O app inteiro num aparelho de verdade. Lento.'),
      ],
    ),
    BlocoTexto(
      'A regra prática: **teste de widget para componentes reutilizáveis**, e '
      'três ou quatro testes de app inteiro para os fluxos críticos. Este '
      'projeto tem os dois: `test/aula_widget_test.dart` e `test/app_test.dart`.',
    ),

    BlocoTitulo('O ciclo: montar, procurar, afirmar'),
    BlocoTexto(
      'Todo teste de widget é a mesma dança. O `tester` é um robô que monta a '
      'árvore, procura coisas nela e responde perguntas sobre o que achou.',
    ),
    BlocoCodigo(
      '''
testWidgets('a etiqueta mostra o texto', (tester) async {
  // 1. MONTAR — constrói a árvore e desenha o primeiro frame.
  await tester.pumpWidget(
    const CupertinoApp(home: Etiqueta('Iniciante', cor: CoresApp.acerto)),
  );

  // 2. PROCURAR + 3. AFIRMAR
  expect(find.text('Iniciante'), findsOneWidget);
  expect(find.text('Avançado'), findsNothing);
});''',
      legenda: 'O teste completo — não tem mais nada escondido',
      saida: '00:00 +1: All tests passed!',
    ),
    BlocoDica(
      'Um widget solto quase nunca roda sozinho: se ele usa `context.paleta` '
      'ou `Theme.of(context)`, precisa de um `CupertinoApp` acima. Por isso '
      'todo projeto acaba tendo um helper `montar(widget)`.',
    ),

    BlocoTitulo('Finders: como o robô enxerga'),
    BlocoTexto(
      'Um finder é só uma pergunta feita a cada nó da árvore: **"você combina '
      'comigo?"**. A ordem abaixo vai do mais durável ao mais frágil.',
    ),
    BlocoTabela(
      cabecalho: ('Finder', 'Casa com'),
      linhas: [
        (
          "find.text('Praticar')",
          'O que o usuário LÊ. Sobrevive a refatoração.',
        ),
        ('find.byIcon(CupertinoIcons.star_fill)', 'O ícone desenhado.'),
        ('find.byType(Etiqueta)', 'O tipo do widget. Ótimo para os seus.'),
        ("find.byKey(const Key('x'))", 'Desempate quando o texto se repete.'),
        (
          'find.byWidgetPredicate(...)',
          'Última saída: filtra por propriedade.',
        ),
      ],
    ),
    BlocoAviso(
      'Evite depender de estrutura interna ("o terceiro Container dentro da '
      'Row"). Esse tipo de teste quebra a cada mudança de layout, sem que nada '
      'tenha realmente estragado.',
    ),

    BlocoTitulo('Matchers: quantos você esperava?'),
    BlocoTexto(
      'O finder responde **quantos achei**. O matcher julga esse número — e, '
      'quando reprova, escreve a mensagem que você vai ler no terminal.',
    ),
    BlocoTabela(
      cabecalho: ('Matcher', 'Passa quando'),
      linhas: [
        ('findsOneWidget', 'Achou exatamente 1'),
        ('findsNothing', 'Não achou nenhum — e isso é um teste e tanto'),
        ('findsWidgets', 'Achou 1 ou mais'),
        ('findsNWidgets(3)', 'Achou exatamente 3'),
      ],
    ),

    BlocoLaboratorio(
      titulo: 'Laboratório de testes',
      chamada:
          'Agora é a sua vez: monte `expect(finder, matcher)` tocando nas '
          'peças, rode e veja **quais widgets o finder pegou**, destacados na '
          'tela. São 4 desafios, com a saída real do `flutter test`.',
    ),

    BlocoTitulo('Interação: tocar, digitar, rolar'),
    BlocoCodigo(
      '''
var toques = 0; // o "espião" que prova que o callback rodou

await tester.pumpWidget(montar(
  OpcaoResposta(texto: 'final', letra: 'A', aoTocar: () => toques++),
));

await tester.tap(find.byType(OpcaoResposta));
await tester.pump(); // ← avança um frame

expect(toques, 1);''',
      legenda: 'tap, enterText e drag seguem sempre esse formato',
    ),
    BlocoAviso(
      'Erro número 1 de quem começa: **esquecer o `pump` depois do toque**. A '
      'interação muda o estado, mas a tela só reflete isso no PRÓXIMO frame — '
      'sem o pump, o teste "não vê" a mudança e falha com `findsNothing`.',
    ),

    BlocoTitulo('pump() ou pumpAndSettle()?'),
    BlocoTabela(
      cabecalho: ('Chamada', 'Quando usar'),
      linhas: [
        ('pump()', 'Desenha UM frame. Sem animação envolvida.'),
        ('pump(Duration)', 'Avança o relógio. Para ver o MEIO da animação.'),
        (
          'pumpAndSettle()',
          'Repete até assentar. Depois de navegar ou animar.',
        ),
      ],
    ),
    BlocoAviso(
      '`pumpAndSettle()` TRAVA com timeout se algo animar para sempre — um '
      '`CupertinoActivityIndicator` na tela, por exemplo. Nesse caso use '
      '`pump(Duration(...))`.',
    ),

    BlocoTitulo('O que separa um teste bom de um frágil'),
    BlocoComparacao(
      codigoErrado: '''
final container = tester.widget<Container>(
  find.byType(Container).at(2),
);
expect((container.decoration as BoxDecoration).color, verde);''',
      notaErrado:
          'Depende de QUANTOS Containers existem e da ORDEM deles. '
          'Um `Padding` a mais no layout e o teste quebra sem motivo.',
      codigoCerto: '''
await tester.tap(find.text('String? aceita null'));
await tester.pumpAndSettle();
expect(find.byIcon(CupertinoIcons.checkmark_circle_fill), findsOneWidget);''',
      notaCerto:
          'Descreve o que o USUÁRIO faz e o que ele vê. Sobrevive a '
          'qualquer refatoração que não mude o comportamento.',
    ),

    BlocoTitulo('De brinde: overflow vira teste vermelho'),
    BlocoTexto(
      'Aquele zebrado amarelo e preto do `RenderFlex overflowed` vira uma '
      '**exceção** dentro do teste. Ou seja: dá para caçar overflow em telas '
      'pequenas sem abrir nenhum simulador.',
    ),
    BlocoCodigo('''
testWidgets('nada estoura num iPhone SE', (tester) async {
  tester.view.physicalSize = const Size(320 * 3, 568 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const AprendaDartApp());
  await tester.pumpAndSettle();
  // Se houvesse overflow, o pump acima já teria lançado exceção.
});''', legenda: 'É esse teste que protege o layout deste app'),
    BlocoDica(
      'Rode tudo com `flutter test`, ou um arquivo só com '
      '`flutter test test/aula_widget_test.dart`. Esse arquivo do projeto tem '
      '17 testes comentados linha a linha — é a versão longa desta lição.',
    ),
  ],
);
