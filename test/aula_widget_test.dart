import 'package:aprenda_dart/core/tema/cores_app.dart';
import 'package:aprenda_dart/core/tema/tema_app.dart';
import 'package:aprenda_dart/core/widgets/etiqueta.dart';
import 'package:aprenda_dart/features/exercicios/presentation/widgets/opcao_resposta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

Widget montar(Widget filho, {Brightness brilho = Brightness.light}) {
  return CupertinoApp(
    theme: brilho == Brightness.dark ? TemaApp.escuro() : TemaApp.claro(),
    home: CupertinoPageScaffold(
      child: Center(
        child: Padding(padding: const EdgeInsets.all(16), child: filho),
      ),
    ),
  );
}

void main() {
  group('1. o básico', () {
    testWidgets('monta a Etiqueta e encontra o texto', (tester) async {
      await tester.pumpWidget(
        montar(const Etiqueta('Iniciante', cor: CoresApp.acerto)),
      );

      expect(find.text('Iniciante'), findsOneWidget);

      expect(find.text('Avançado'), findsNothing);
    });

    testWidgets('os matchers de quantidade', (tester) async {
      await tester.pumpWidget(
        montar(
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Etiqueta('Dart', cor: CoresApp.azulDart),
              Etiqueta('Flutter', cor: CoresApp.azulDart),
            ],
          ),
        ),
      );

      expect(find.byType(Etiqueta), findsNWidgets(2));
      expect(find.byType(Etiqueta), findsWidgets);
      expect(find.byType(Etiqueta).first, findsOneWidget);
      expect(find.byType(CupertinoButton), findsNothing);
    });
  });

  group('2. finders', () {
    testWidgets('byIcon: o ícone só aparece quando é passado', (tester) async {
      await tester.pumpWidget(
        montar(const Etiqueta('Sem ícone', cor: CoresApp.dica)),
      );
      expect(find.byIcon(CupertinoIcons.star_fill), findsNothing);

      await tester.pumpWidget(
        montar(
          const Etiqueta(
            'Com ícone',
            cor: CoresApp.dica,
            icone: CupertinoIcons.star_fill,
          ),
        ),
      );
      expect(find.byIcon(CupertinoIcons.star_fill), findsOneWidget);
    });

    testWidgets('byKey: distingue itens iguais', (tester) async {
      await tester.pumpWidget(
        montar(
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Etiqueta('Nível', key: Key('etiqueta-nivel'), cor: CoresApp.erro),
              Etiqueta('Nível', key: Key('etiqueta-tema'), cor: CoresApp.dica),
            ],
          ),
        ),
      );

      expect(find.text('Nível'), findsNWidgets(2));
      expect(find.byKey(const Key('etiqueta-tema')), findsOneWidget);
    });

    testWidgets('byWidgetPredicate: filtra por propriedade', (tester) async {
      await tester.pumpWidget(
        montar(
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Etiqueta('normal', cor: CoresApp.acerto),
              Etiqueta('preenchida', cor: CoresApp.acerto, preenchida: true),
            ],
          ),
        ),
      );

      expect(
        find.byWidgetPredicate((w) => w is Etiqueta && w.preenchida),
        findsOneWidget,
      );
    });

    testWidgets('descendant: "o X que está dentro do Y"', (tester) async {
      await tester.pumpWidget(
        montar(
          const OpcaoResposta(
            texto: 'var é inferido',
            letra: 'A',
            estado: EstadoOpcao.neutra,
            aoTocar: null,
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(OpcaoResposta),
          matching: find.text('A'),
        ),
        findsOneWidget,
      );
    });
  });

  group('3. inspeção', () {
    testWidgets('a etiqueta preenchida escreve em branco', (tester) async {
      await tester.pumpWidget(
        montar(const Etiqueta('Feito', cor: CoresApp.acerto, preenchida: true)),
      );

      final texto = tester.widget<Text>(find.text('Feito'));
      expect(texto.style!.color, CupertinoColors.white);
    });

    testWidgets('a etiqueta vazada escreve na cor da etiqueta', (tester) async {
      await tester.pumpWidget(
        montar(const Etiqueta('Feito', cor: CoresApp.acerto)),
      );

      final texto = tester.widget<Text>(find.text('Feito'));
      expect(texto.style!.color, CoresApp.acerto);
    });

    testWidgets('o tema escuro chega no widget', (tester) async {
      await tester.pumpWidget(
        montar(
          const OpcaoResposta(
            texto: 'resposta',
            letra: 'A',
            estado: EstadoOpcao.neutra,
            aoTocar: null,
          ),
          brilho: Brightness.dark,
        ),
      );

      final containers = tester.widgetList<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final decoracao = containers.first.decoration! as BoxDecoration;
      expect(decoracao.color, CoresApp.superficieEscura);
    });
  });

  group('4. interação', () {
    testWidgets('tocar dispara o callback', (tester) async {
      var toques = 0;

      await tester.pumpWidget(
        montar(
          OpcaoResposta(
            texto: 'final é constante em tempo de execução',
            letra: 'A',
            estado: EstadoOpcao.neutra,
            aoTocar: () => toques++,
          ),
        ),
      );

      await tester.tap(find.byType(OpcaoResposta));
      await tester.pump();

      expect(toques, 1);
    });

    testWidgets('opção desabilitada (aoTocar: null) não dispara nada', (
      tester,
    ) async {
      await tester.pumpWidget(
        montar(
          const OpcaoResposta(
            texto: 'já respondida',
            letra: 'B',
            estado: EstadoOpcao.escolhidaCerta,
            aoTocar: null,
          ),
        ),
      );

      await tester.tap(find.byType(OpcaoResposta));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('digitar num campo', (tester) async {
      final controlador = TextEditingController();
      addTearDown(controlador.dispose);

      await tester.pumpWidget(
        montar(CupertinoTextField(controller: controlador)),
      );

      await tester.enterText(find.byType(CupertinoTextField), 'null safety');
      await tester.pump();

      expect(controlador.text, 'null safety');
      expect(find.text('null safety'), findsOneWidget);
    });

    testWidgets('rolar até um item fora da tela', (tester) async {
      await tester.pumpWidget(
        montar(
          SizedBox(
            height: 200,
            child: ListView(
              children: [
                for (var i = 1; i <= 40; i++)
                  SizedBox(height: 50, child: Text('item $i')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('item 40'), findsNothing);

      await tester.dragUntilVisible(
        find.text('item 40'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.pumpAndSettle();

      expect(find.text('item 40'), findsOneWidget);
    });
  });

  group('5. tempo e animação', () {
    testWidgets('a borda anima do neutro para o verde', (tester) async {
      await tester.pumpWidget(
        montar(
          const OpcaoResposta(
            texto: 'certa',
            letra: 'A',
            estado: EstadoOpcao.neutra,
            aoTocar: null,
          ),
        ),
      );

      await tester.pumpWidget(
        montar(
          const OpcaoResposta(
            texto: 'certa',
            letra: 'A',
            estado: EstadoOpcao.escolhidaCerta,
            aoTocar: null,
          ),
        ),
      );

      BoxDecoration decoracaoAtual() {
        return tester
                .widgetList<Container>(
                  find.descendant(
                    of: find.byType(AnimatedContainer),
                    matching: find.byType(Container),
                  ),
                )
                .first
                .decoration!
            as BoxDecoration;
      }

      await tester.pump(const Duration(milliseconds: 90));
      expect(decoracaoAtual().border!.top.color, isNot(CoresApp.acerto));

      await tester.pumpAndSettle();
      expect(decoracaoAtual().border!.top.color, CoresApp.acerto);
    });

    testWidgets('estado real: StatefulBuilder simula a tela do quiz', (
      tester,
    ) async {
      var escolhida = false;

      await tester.pumpWidget(
        montar(
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OpcaoResposta(
                    texto: 'String? aceita null',
                    letra: 'A',
                    estado: escolhida
                        ? EstadoOpcao.escolhidaCerta
                        : EstadoOpcao.neutra,
                    aoTocar: escolhida
                        ? null
                        : () => setState(() => escolhida = true),
                  ),
                  if (escolhida) const Text('Boa! String? aceita null.'),
                ],
              );
            },
          ),
        ),
      );

      expect(find.text('Boa! String? aceita null.'), findsNothing);
      expect(find.byIcon(CupertinoIcons.checkmark_circle_fill), findsNothing);

      await tester.tap(find.byType(OpcaoResposta));
      await tester.pumpAndSettle();

      expect(find.text('Boa! String? aceita null.'), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.checkmark_circle_fill), findsOneWidget);
    });
  });

  group('6. layout', () {
    testWidgets('texto longo não estoura numa tela de 320px', (tester) async {
      tester.view.physicalSize = const Size(320 * 3, 568 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        montar(
          const OpcaoResposta(
            texto:
                'Uma alternativa bem comprida para forçar quebra de linha '
                'e provar que o Expanded está fazendo o trabalho dele.',
            letra: 'C',
            estado: EstadoOpcao.neutra,
            aoTocar: null,
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('medindo tamanho e posição', (tester) async {
      await tester.pumpWidget(
        montar(const Etiqueta('oi', cor: CoresApp.azulDart)),
      );

      final tamanho = tester.getSize(find.byType(Etiqueta));
      expect(tamanho.height, greaterThan(0));

      expect(tester.getCenter(find.byType(Etiqueta)).dx, closeTo(400, 1));
    });
  });
}
