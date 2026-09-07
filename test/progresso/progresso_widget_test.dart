import 'package:aprenda_dart/core/i18n/textos_pt.dart';
import 'package:aprenda_dart/core/preferencias/preferencias.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../ajuda.dart';

void main() {
  const pt = TextosPt();

  /// Sobe o app de novo sobre as mesmas preferências — o equivalente, no
  /// teste, a matar o app e abrir outra vez.
  Future<void> reabrirApp(WidgetTester tester, Preferencias prefs) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(appDeTeste(preferencias: prefs));
    await tester.pumpAndSettle();
  }

  testWidgets('a lição concluída ainda está lá depois de reabrir o app', (
    tester,
  ) async {
    final prefs = preferenciasDeTeste();

    await tester.pumpWidget(appDeTeste(preferencias: prefs));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Como o Dart funciona'));
    await tester.pumpAndSettle();

    final botao = find.text(pt.licaoMarcarConcluida);
    await tester.dragUntilVisible(
      botao,
      find.byType(ListView).first,
      const Offset(0, -400),
      maxIteration: 80,
    );
    await tester.ensureVisible(botao);
    await tester.pumpAndSettle();
    await tester.tap(botao);
    await tester.pumpAndSettle();

    await reabrirApp(tester, prefs);

    await tester.tap(find.text(pt.abaProgresso));
    await tester.pumpAndSettle();

    expect(
      find.text('1'),
      findsWidgets,
      reason: 'a métrica de lições concluídas voltou zerada',
    );
  });

  testWidgets('acertos e erros do quiz também voltam depois de reabrir', (
    tester,
  ) async {
    final prefs = preferenciasDeTeste();

    await tester.pumpWidget(appDeTeste(preferencias: prefs));
    await tester.pumpAndSettle();

    await tester.tap(find.text(pt.abaPraticar));
    await tester.pumpAndSettle();

    await tester.tap(find.text(pt.praticarTudo));
    await tester.pumpAndSettle();

    // Responder uma pergunta qualquer já grava um acerto ou um erro.
    await tester.tap(find.text('A').first);
    await tester.pumpAndSettle();

    await reabrirApp(tester, prefs);

    await tester.tap(find.text(pt.abaProgresso));
    await tester.pumpAndSettle();

    expect(
      find.text('—'),
      findsNothing,
      reason: 'o aproveitamento voltou como "nada respondido"',
    );
  });
}
