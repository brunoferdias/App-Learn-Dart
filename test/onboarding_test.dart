import 'package:aprenda_dart/core/i18n/textos_en.dart';
import 'package:aprenda_dart/core/i18n/textos_pt.dart';
import 'package:aprenda_dart/features/onboarding/presentation/pages/fluxo_onboarding.dart';
import 'package:aprenda_dart/features/onboarding/presentation/pages/tela_boas_vindas.dart';
import 'package:aprenda_dart/features/onboarding/presentation/pages/tela_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'ajuda.dart';

void main() {
  const pt = TextosPt();
  const en = TextosEn();

  Future<void> abrirPrimeiraVez(WidgetTester tester) async {
    await tester.pumpWidget(appDeTeste(onboardingConcluido: false));
    await tester.pumpAndSettle();
  }

  testWidgets('o splash aparece antes de qualquer outra tela', (tester) async {
    await tester.pumpWidget(appDeTeste(onboardingConcluido: false));
    await tester.pump();

    expect(find.byType(TelaSplash), findsOneWidget);
    expect(find.text(pt.avisoNaoOficialCurto), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('quem chega pela primeira vez vê as boas-vindas', (tester) async {
    await abrirPrimeiraVez(tester);

    expect(find.byType(TelaBoasVindas), findsOneWidget);
    expect(find.text(pt.boasVindasTitulo), findsOneWidget);
    expect(find.text(pt.boasVindasComecar), findsOneWidget);
    expect(find.text(pt.boasVindasJaConheco), findsOneWidget);
  });

  testWidgets('quem já viu a apresentação cai direto nas abas', (tester) async {
    await abrirApp(tester);

    expect(find.byType(TelaBoasVindas), findsNothing);
    expect(find.byType(FluxoOnboarding), findsNothing);
    expect(find.text('Como o Dart funciona'), findsOneWidget);
  });

  testWidgets('trocar o idioma nas boas-vindas muda o app inteiro', (
    tester,
  ) async {
    await abrirPrimeiraVez(tester);

    expect(find.text(pt.boasVindasTitulo), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text(en.boasVindasTitulo), findsOneWidget);
    expect(find.text(pt.boasVindasTitulo), findsNothing);

    await tester.tap(find.text(en.boasVindasJaConheco));
    await tester.pumpAndSettle();

    expect(find.text(en.abaAprender), findsWidgets);
    expect(find.text('How Dart works'), findsOneWidget);
  });

  testWidgets('"ir direto para as lições" pula a apresentação', (tester) async {
    await abrirPrimeiraVez(tester);

    await tester.tap(find.text(pt.boasVindasJaConheco));
    await tester.pumpAndSettle();

    expect(find.byType(FluxoOnboarding), findsNothing);
    expect(find.text('Como o Dart funciona'), findsOneWidget);
  });

  testWidgets('a apresentação tem 5 passos e o último entra no app', (
    tester,
  ) async {
    await abrirPrimeiraVez(tester);

    await tester.tap(find.text(pt.boasVindasComecar));
    await tester.pumpAndSettle();

    expect(find.byType(FluxoOnboarding), findsOneWidget);

    for (var passo = 1; passo <= 5; passo++) {
      expect(
        find.text(pt.passoDe(passo, 5)),
        findsOneWidget,
        reason: 'esperava estar no passo $passo',
      );

      final rotulo = passo == 5 ? pt.onbPasso5Entrar : pt.continuar;
      await tester.tap(find.text(rotulo));
      await tester.pumpAndSettle();
    }

    expect(find.byType(FluxoOnboarding), findsNothing);
    expect(find.text('Como o Dart funciona'), findsOneWidget);
  });

  testWidgets('o exercício da apresentação corrige de verdade', (tester) async {
    await abrirPrimeiraVez(tester);
    await tester.tap(find.text(pt.boasVindasComecar));
    await tester.pumpAndSettle();

    await tester.tap(find.text(pt.continuar));
    await tester.pumpAndSettle();

    expect(find.text(pt.onbPasso2Convite), findsOneWidget);

    await tester.tap(find.text(pt.onbPasso2Alternativa1));
    await tester.pumpAndSettle();

    expect(find.text(pt.onbPasso2Erro), findsOneWidget);
    expect(find.text(pt.onbPasso2Convite), findsNothing);
  });

  testWidgets('o editor da apresentação só mostra a saída depois de rodar', (
    tester,
  ) async {
    await abrirPrimeiraVez(tester);
    await tester.tap(find.text(pt.boasVindasComecar));
    await tester.pumpAndSettle();

    for (var i = 0; i < 2; i++) {
      await tester.tap(find.text(pt.continuar));
      await tester.pumpAndSettle();
    }

    expect(find.text(pt.onbPasso3Convite), findsOneWidget);
    expect(find.text(pt.blocoSaidaConsole.toUpperCase()), findsNothing);

    await tester.tap(find.text(pt.onbPasso3Convite));
    await tester.pumpAndSettle();

    expect(find.text(pt.blocoSaidaConsole.toUpperCase()), findsWidgets);
  });

  testWidgets('o último passo é o aviso de que o app não é do Google', (
    tester,
  ) async {
    await abrirPrimeiraVez(tester);
    await tester.tap(find.text(pt.boasVindasComecar));
    await tester.pumpAndSettle();

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text(pt.continuar));
      await tester.pumpAndSettle();
    }

    expect(find.text(pt.onbPasso5Titulo), findsOneWidget);
    expect(find.text(pt.avisoNaoOficialTitulo.toUpperCase()), findsOneWidget);
    expect(find.textContaining('Google LLC'), findsOneWidget);
  });

  testWidgets('o aviso também fica fixo na aba Progresso', (tester) async {
    await abrirApp(tester);

    await tester.tap(find.text(pt.abaProgresso));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text(pt.avisoNaoOficialTitulo.toUpperCase()),
      find.byType(CustomScrollView).first,
      const Offset(0, -300),
      maxIteration: 60,
    );
    await tester.pumpAndSettle();

    expect(find.text(pt.avisoNaoOficialTitulo.toUpperCase()), findsOneWidget);
  });

  testWidgets('"rever a apresentação" reabre o fluxo', (tester) async {
    await abrirApp(tester);

    await tester.tap(find.text(pt.abaProgresso));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text(pt.perfilRevisarOnboarding),
      find.byType(CustomScrollView).first,
      const Offset(0, -300),
      maxIteration: 60,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(pt.perfilRevisarOnboarding));
    await tester.pumpAndSettle();

    expect(find.byType(FluxoOnboarding), findsOneWidget);
  });

  testWidgets('trocar o idioma na aba Progresso traduz as lições', (
    tester,
  ) async {
    await abrirApp(tester);

    await tester.tap(find.text(pt.abaProgresso));
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    await tester.tap(find.text(en.abaAprender));
    await tester.pumpAndSettle();

    expect(find.text('How Dart works'), findsOneWidget);
    expect(find.text('Como o Dart funciona'), findsNothing);
  });
}
