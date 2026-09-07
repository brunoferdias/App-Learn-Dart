import 'package:aprenda_dart/core/i18n/textos_pt.dart';
import 'package:aprenda_dart/features/avaliacao/presentation/widgets/cartao_avaliacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../ajuda.dart';

void main() {
  const pt = TextosPt();

  testWidgets('o convite para avaliar fica à mão na aba Progresso', (
    tester,
  ) async {
    await abrirApp(tester);

    await tester.tap(find.text(pt.abaProgresso));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.byType(CartaoAvaliacao),
      find.byType(CustomScrollView).first,
      const Offset(0, -300),
      maxIteration: 60,
    );
    await tester.pumpAndSettle();

    expect(find.text(pt.avaliarTitulo), findsOneWidget);
    expect(find.text(pt.avaliarBotao), findsOneWidget);
  });

  testWidgets('concluir uma lição segue direto, sem nada no caminho', (
    tester,
  ) async {
    await abrirApp(tester);

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

    // A lição foi registrada e a navegação voltou à lista, sem que o momento
    // avisado ao ControladorAvaliacao atrapalhe o caminho.
    expect(find.text('Como o Dart funciona'), findsOneWidget);

    await tester.tap(find.text(pt.abaProgresso));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsWidgets);
  });
}
