import 'package:aprenda_dart/features/testes/domain/entities/cenario.dart';
import 'package:aprenda_dart/features/testes/domain/entities/finder_simulado.dart';
import 'package:aprenda_dart/features/testes/domain/entities/matcher_simulado.dart';
import 'package:aprenda_dart/features/testes/domain/entities/no_widget.dart';
import 'package:aprenda_dart/features/testes/domain/usecases/rodar_teste.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const arvore = NoWidget(
    'Column',
    filhos: [
      NoWidget('Text', texto: 'Dart'),
      NoWidget(
        'Etiqueta',
        chave: 'et-1',
        filhos: [
          NoWidget('Icon', icone: 'star_fill'),
          NoWidget('Text', texto: 'Dart'),
        ],
      ),
    ],
  );

  group('achatar', () {
    test('percorre em profundidade e dá um caminho a cada nó', () {
      final caminhos = [for (final n in NoWidget.achatar(arvore)) n.caminho];
      expect(caminhos, ['0', '0.0', '0.1', '0.1.0', '0.1.1']);
    });
  });

  group('finders', () {
    test('find.text casa só com Text de conteúdo exato', () {
      expect(const FinderTexto('Dart').encontrar(arvore).length, 2);
      expect(const FinderTexto('dart').encontrar(arvore), isEmpty);
    });

    test('find.byType casa pelo tipo', () {
      expect(const FinderTipo('Text').encontrar(arvore).length, 2);
      expect(const FinderTipo('Etiqueta').encontrar(arvore).length, 1);
    });

    test('find.byIcon e find.byKey', () {
      expect(const FinderIcone('star_fill').encontrar(arvore).length, 1);
      expect(const FinderChave('et-1').encontrar(arvore).length, 1);
      expect(const FinderChave('et-9').encontrar(arvore), isEmpty);
    });

    test('o código gerado é Dart de verdade', () {
      expect(const FinderTexto('Dart').codigo, "find.text('Dart')");
      expect(const FinderTipo('Etiqueta').codigo, 'find.byType(Etiqueta)');
      expect(const FinderChave('et-1').codigo, "find.byKey(const Key('et-1'))");
    });
  });

  group('matchers', () {
    test('aceitam as quantidades certas', () {
      expect(const EncontraUm().aceita(1), isTrue);
      expect(const EncontraUm().aceita(2), isFalse);
      expect(const EncontraNada().aceita(0), isTrue);
      expect(const EncontraVarios().aceita(3), isTrue);
      expect(const EncontraVarios().aceita(0), isFalse);
      expect(const EncontraN(3).aceita(3), isTrue);
    });

    test('explicam a falha como o flutter_test explica', () {
      expect(
        const EncontraUm().motivo(0),
        'means none were found but one was expected',
      );
      expect(const EncontraUm().motivo(2), 'is too many');
      expect(const EncontraN(3).motivo(1), 'is not enough');
    });
  });

  group('rodar teste', () {
    const cenario = Cenario(
      id: 'x',
      titulo: 'cenário de teste',
      resumo: '',
      codigoFonte: '',
      arvore: arvore,
      arvoreAposToque: NoWidget(
        'Column',
        filhos: [NoWidget('Text', texto: 'Depois')],
      ),
      acaoDeToque: 'await tester.tap(...);',
      finders: [FinderTexto('Dart')],
      desafio: Desafio(
        enunciado: '',
        finder: FinderTexto('Dart'),
        matcher: EncontraN(2),
        dica: '',
      ),
    );

    test('passa e devolve os caminhos encontrados', () {
      final r = const RodarTeste()(
        cenario: cenario,
        finder: const FinderTexto('Dart'),
        matcher: const EncontraN(2),
      );

      expect(r.passou, isTrue);
      expect(r.quantidadeEncontrada, 2);
      expect(r.caminhosEncontrados, ['0.0', '0.1.1']);
      expect(r.linhaExpect, "expect(find.text('Dart'), findsNWidgets(2));");
      expect(r.saida.last.texto, contains('All tests passed!'));
    });

    test('falha com a mensagem real do flutter_test', () {
      final r = const RodarTeste()(
        cenario: cenario,
        finder: const FinderTexto('Dart'),
        matcher: const EncontraUm(),
      );

      expect(r.passou, isFalse);
      final saida = [for (final l in r.saida) l.texto].join('\n');
      expect(saida, contains('Expected: exactly one matching candidate'));
      expect(saida, contains('_TextWidgetFinder:<Found 2 widgets'));
      expect(saida, contains('Which: is too many'));
    });

    test('com interação, a árvore usada é a de depois do toque', () {
      final r = const RodarTeste()(
        cenario: cenario,
        finder: const FinderTexto('Dart'),
        matcher: const EncontraNada(),
        comInteracao: true,
      );

      expect(r.passou, isTrue);
      expect(r.quantidadeEncontrada, 0);
    });
  });
}
