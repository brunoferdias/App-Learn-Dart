import 'package:aprenda_dart/features/playground/presentation/widgets/controlador_editor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const formatador = FormatadorDart();

  TextEditingValue digitar(String texto, int cursor, String caractere) {
    final antigo = TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: cursor),
    );
    final novoTexto =
        texto.substring(0, cursor) + caractere + texto.substring(cursor);
    final novo = TextEditingValue(
      text: novoTexto,
      selection: TextSelection.collapsed(offset: cursor + 1),
    );
    return formatador.formatEditUpdate(antigo, novo);
  }

  group('indentação automática', () {
    test('Enter repete a indentação da linha anterior', () {
      final r = digitar('  print(1);', 11, '\n');
      expect(r.text, '  print(1);\n  ');
      expect(r.selection.baseOffset, r.text.length);
    });

    test('Enter depois de { adiciona um nível', () {
      final r = digitar('void main() {', 13, '\n');
      expect(r.text, 'void main() {\n  ');
    });

    test('Enter depois de => adiciona um nível', () {
      final r = digitar('  final f = () =>', 17, '\n');
      expect(r.text, '  final f = () =>\n    ');
    });

    test('Enter entre { e } cria o bloco e desce a chave', () {
      final r = digitar('void main() {}', 13, '\n');
      expect(r.text, 'void main() {\n  \n}');
      expect(r.selection.baseOffset, 16);
    });

    test('} recua um nível', () {
      final r = digitar('void main() {\n  \n', 17, '}');
      expect(r.text, 'void main() {\n  \n}');
    });
  });

  group('fechamento automático', () {
    test('( fecha sozinho e o cursor fica no meio', () {
      final r = digitar('print', 5, '(');
      expect(r.text, 'print()');
      expect(r.selection.baseOffset, 6);
    });

    test('aspas fecham sozinhas', () {
      final r = digitar('print()', 6, "'");
      expect(r.text, "print('')");
      expect(r.selection.baseOffset, 7);
    });

    test('digitar o fechamento sobre o já existente apenas avança', () {
      final r = digitar('print()', 6, ')');
      expect(r.text, 'print()');
      expect(r.selection.baseOffset, 7);
    });

    test('aspas antes de uma palavra não duplicam', () {
      final r = digitar('oi', 0, "'");
      expect(r.text, "'oi");
    });

    test('colar texto não é alterado', () {
      const antigo = TextEditingValue(text: 'a');
      const novo = TextEditingValue(
        text: 'a monte de texto colado',
        selection: TextSelection.collapsed(offset: 23),
      );
      expect(formatador.formatEditUpdate(antigo, novo).text, novo.text);
    });
  });
}
