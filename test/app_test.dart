import 'package:aprenda_dart/core/widgets/visualizador_codigo.dart';
import 'package:aprenda_dart/features/exercicios/presentation/widgets/opcao_resposta.dart';
import 'package:aprenda_dart/features/exercicios/presentation/widgets/painel_explicacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'ajuda.dart';

void main() {
  testWidgets('o app inicia e mostra a lista de lições', (tester) async {
    await abrirApp(tester);

    expect(find.text('Aprenda Dart'), findsWidgets);
    expect(find.text('Como o Dart funciona'), findsOneWidget);
    expect(find.text('Variáveis e tipos'), findsOneWidget);
  });

  testWidgets('abre uma lição e mostra objetivos e ação de praticar', (
    tester,
  ) async {
    await abrirApp(tester);

    await tester.tap(find.text('Como o Dart funciona'));
    await tester.pumpAndSettle();

    expect(find.text('O QUE VOCÊ VAI APRENDER'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    expect(find.byType(VisualizadorCodigo), findsWidgets);

    await tester.dragUntilVisible(
      find.text('Praticar esta lição'),
      find.byType(ListView),
      const Offset(0, -400),
      maxIteration: 80,
    );
    await tester.pumpAndSettle();
    expect(find.text('Praticar esta lição'), findsOneWidget);
  });

  testWidgets('responde um exercício e vê a explicação', (tester) async {
    await abrirApp(tester);

    await tester.tap(find.text('Praticar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Praticar tudo, misturado'));
    await tester.pumpAndSettle();

    expect(
      find.text('Escolha uma alternativa para ver a explicação.'),
      findsOneWidget,
    );

    await tester.tap(find.byType(OpcaoResposta).first);
    await tester.pumpAndSettle();

    expect(find.byType(PainelExplicacao), findsOneWidget);
    await tester.dragUntilVisible(
      find.text('Próxima pergunta'),
      find.byType(ListView),
      const Offset(0, -300),
      maxIteration: 80,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Próxima pergunta'));
    await tester.pumpAndSettle();
    expect(find.textContaining('2 de '), findsOneWidget);
  });

  testWidgets('o glossário filtra pela busca', (tester) async {
    await abrirApp(tester);

    await tester.tap(find.text('Sintaxe'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(CupertinoSearchTextField), 'late');
    await tester.pumpAndSettle();

    expect(find.text('late'), findsWidgets);
  });

  testWidgets('nenhuma tela estoura numa largura pequena (320px)', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await abrirApp(tester);

    for (var i = 0; i < 14; i++) {
      await tester.drag(
        find.byType(CustomScrollView).first,
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
    }
    expect(find.text('Clean Architecture na prática'), findsOneWidget);

    for (final aba in const ['Praticar', 'Editor', 'Sintaxe', 'Progresso']) {
      await tester.tap(find.text(aba));
      await tester.pumpAndSettle();
      for (var i = 0; i < 6; i++) {
        await tester.drag(
          find.byType(CustomScrollView).first,
          const Offset(0, -300),
        );
        await tester.pumpAndSettle();
      }
    }
  });
}
