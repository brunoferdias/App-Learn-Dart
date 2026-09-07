import 'package:aprenda_dart/app/escopo_app.dart';
import 'package:aprenda_dart/app/injecao.dart';
import 'package:aprenda_dart/core/i18n/escopo_textos.dart';
import 'package:aprenda_dart/features/testes/presentation/pages/pagina_laboratorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../ajuda.dart';

void main() {
  Future<void> abrirLaboratorio(WidgetTester tester) async {
    tester.view.physicalSize = const Size(420, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      EscopoApp(
        injecao: Injecao(
          preferencias: preferenciasDeTeste(),
          localeDoSistema: 'pt',
        ),
        child: const EscopoTextos(
          textos: textosTeste,
          child: CupertinoApp(home: PaginaLaboratorio()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> rodar(WidgetTester tester) async {
    await tester.tap(find.textContaining('Rodar teste'));
    await tester.pumpAndSettle();
  }

  testWidgets('abre no primeiro cenário, com o desafio à vista', (
    tester,
  ) async {
    await abrirLaboratorio(tester);

    expect(find.text('Uma etiqueta na tela'), findsOneWidget);
    expect(find.text('DESAFIO'), findsOneWidget);
    expect(find.text('0/4'), findsOneWidget);
    expect(find.text("expect(…, …);"), findsOneWidget);
  });

  testWidgets('montar uma asserção verdadeira faz o teste passar', (
    tester,
  ) async {
    await abrirLaboratorio(tester);

    await tester.tap(find.text("find.text('Iniciante')"));
    await tester.tap(find.text('findsOneWidget'));
    await tester.pumpAndSettle();

    expect(
      find.text("expect(find.text('Iniciante'), findsOneWidget);"),
      findsOneWidget,
    );

    await rodar(tester);

    expect(find.text('Passou — 1 widget encontrado'), findsOneWidget);
    expect(find.textContaining('All tests passed!'), findsOneWidget);
  });

  testWidgets('uma asserção falsa mostra a mensagem real do flutter_test', (
    tester,
  ) async {
    await abrirLaboratorio(tester);

    await tester.tap(find.text("find.text('Avançado')"));
    await tester.tap(find.text('findsOneWidget'));
    await tester.pumpAndSettle();
    await rodar(tester);

    expect(find.text('Falhou — 0 widgets encontrados'), findsOneWidget);
    expect(
      find.text('Expected: exactly one matching candidate'),
      findsOneWidget,
    );
    expect(
      find.textContaining('means none were found but one was expected'),
      findsOneWidget,
    );
  });

  testWidgets('resolver o desafio libera o próximo cenário', (tester) async {
    await abrirLaboratorio(tester);

    await tester.tap(find.text("find.text('Avançado')"));
    await tester.tap(find.text('findsNothing'));
    await tester.pumpAndSettle();
    await rodar(tester);

    expect(find.text('DESAFIO CONCLUÍDO'), findsOneWidget);
    expect(find.text('1/4'), findsOneWidget);

    await tester.tap(find.text('Próximo cenário'));
    await tester.pumpAndSettle();
    expect(find.text('Três alternativas'), findsOneWidget);
  });

  testWidgets('o contador n alimenta o findsNWidgets', (tester) async {
    await abrirLaboratorio(tester);

    await tester.tap(find.byKey(const Key('cenario-2')));
    await tester.pumpAndSettle();

    expect(find.text('findsNWidgets(2)'), findsOneWidget);
    await tester.tap(find.text('+'));
    await tester.pumpAndSettle();
    expect(find.text('findsNWidgets(3)'), findsOneWidget);

    await tester.tap(find.text('find.byType(OpcaoResposta)'));
    await tester.tap(find.text('findsNWidgets(3)'));
    await tester.pumpAndSettle();
    await rodar(tester);

    expect(find.text('Passou — 3 widgets encontrados'), findsOneWidget);
    expect(find.text('DESAFIO CONCLUÍDO'), findsOneWidget);
  });

  testWidgets('a interação muda a árvore e o resultado junto', (tester) async {
    await abrirLaboratorio(tester);

    await tester.tap(find.byKey(const Key('cenario-3')));
    await tester.pumpAndSettle();

    await tester.tap(find.text("find.text('Boa! String? aceita null.')"));
    await tester.tap(find.text('findsOneWidget'));
    await tester.pumpAndSettle();
    await rodar(tester);

    expect(find.text('Falhou — 0 widgets encontrados'), findsOneWidget);

    await tester.tap(find.text('Rodar essa interação'));
    await tester.pumpAndSettle();
    await rodar(tester);

    expect(find.text('Passou — 1 widget encontrado'), findsOneWidget);
    expect(find.text('DESAFIO CONCLUÍDO'), findsOneWidget);
  });

  testWidgets('o laboratório não estoura numa tela de 320px', (tester) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      EscopoApp(
        injecao: Injecao(
          preferencias: preferenciasDeTeste(),
          localeDoSistema: 'pt',
        ),
        child: const EscopoTextos(
          textos: textosTeste,
          child: CupertinoApp(home: PaginaLaboratorio()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    for (var cenario = 1; cenario <= 4; cenario++) {
      await tester.drag(find.byType(ListView), const Offset(0, 2000));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('cenario-$cenario')));
      await tester.pumpAndSettle();

      for (var i = 0; i < 6; i++) {
        await tester.drag(find.byType(ListView), const Offset(0, -260));
        await tester.pumpAndSettle();
      }
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('a lição 11 leva ao laboratório', (tester) async {
    await abrirApp(tester);

    await tester.dragUntilVisible(
      find.text('Testes de widget'),
      find.byType(CustomScrollView).first,
      const Offset(0, -300),
      maxIteration: 80,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Testes de widget'));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text('Abrir o laboratório'),
      find.byType(ListView),
      const Offset(0, -300),
      maxIteration: 100,
    );
    await tester.drag(find.byType(ListView), const Offset(0, 150));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Abrir o laboratório'));
    await tester.pumpAndSettle();

    expect(find.text('Uma etiqueta na tela'), findsOneWidget);
    expect(find.text('DESAFIO'), findsOneWidget);
  });
}
