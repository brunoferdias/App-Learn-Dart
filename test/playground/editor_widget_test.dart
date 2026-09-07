import 'package:aprenda_dart/features/playground/presentation/widgets/editor_codigo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../ajuda.dart';

void main() {
  Future<void> abrirEditor(WidgetTester tester) async {
    await abrirApp(tester);

    await tester.tap(find.text('Editor'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Abrir o editor'));
    await tester.pumpAndSettle();
  }

  testWidgets('o editor abre com main.dart preenchido', (tester) async {
    await abrirEditor(tester);

    expect(find.byType(EditorCodigo), findsOneWidget);
    expect(find.text('main.dart'), findsOneWidget);
    expect(find.text('saudacao.dart'), findsOneWidget);
    expect(find.text('Rodar'), findsOneWidget);

    final campo = tester.widget<CupertinoTextField>(
      find.byType(CupertinoTextField),
    );
    expect(campo.controller!.text, contains('void main()'));
  });

  testWidgets('rodar executa e mostra a saída no console', (tester) async {
    await abrirEditor(tester);

    await tester.tap(find.text('Rodar'));
    await tester.pumpAndSettle();

    expect(find.text('Olá, Ana! Bem-vindo ao Dart.'), findsOneWidget);
    expect(find.text('sem apelido'), findsOneWidget);
    expect(find.text('Volta 3'), findsOneWidget);
    expect(find.textContaining('sem erros'), findsOneWidget);
  });

  testWidgets('código com erro mostra mensagem e dica', (tester) async {
    await abrirEditor(tester);

    await tester.enterText(
      find.byType(CupertinoTextField).first,
      "void main() { String nome = null; print(nome); }",
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rodar'));
    await tester.pumpAndSettle();

    expect(find.textContaining('null'), findsWidgets);
    expect(find.textContaining('ponto de interrogação'), findsOneWidget);
  });

  testWidgets('trocar de aba troca o conteúdo do editor', (tester) async {
    await abrirEditor(tester);

    await tester.tap(find.text('saudacao.dart'));
    await tester.pumpAndSettle();

    final campo = tester.widget<CupertinoTextField>(
      find.byType(CupertinoTextField),
    );
    expect(campo.controller!.text, contains('String saudar'));
  });

  testWidgets('adicionar uma aba nova', (tester) async {
    await abrirEditor(tester);

    await tester.tap(find.byIcon(CupertinoIcons.add));
    await tester.pumpAndSettle();

    expect(find.text('arquivo3.dart'), findsOneWidget);
  });
}
