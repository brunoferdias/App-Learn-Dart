import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../core/widgets/destaque_dart.dart';

const int tamanhoIndentacao = 2;

class ControladorEditorDart extends TextEditingController {
  ControladorEditorDart({super.text});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(
      style: style,
      children: destacarDart(text, destacarLacuna: false),
    );
  }
}

const Map<String, String> _pares = {
  '(': ')',
  '[': ']',
  '{': '}',
  "'": "'",
  '"': '"',
};

class FormatadorDart extends TextInputFormatter {
  const FormatadorDart();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue antigo,
    TextEditingValue novo,
  ) {
    if (novo.text.length != antigo.text.length + 1) return novo;

    final cursor = novo.selection.baseOffset;
    if (cursor <= 0 || cursor > novo.text.length) return novo;

    final digitado = novo.text[cursor - 1];
    final antes = novo.text.substring(0, cursor - 1);
    final depois = novo.text.substring(cursor);

    if (digitado == '\n') {
      final linhaAnterior = _linhaQueTermina(antes);
      final semEspacos = linhaAnterior.trimRight();
      var recuo = _recuoDe(linhaAnterior);

      final abriuBloco =
          semEspacos.endsWith('{') ||
          semEspacos.endsWith('(') ||
          semEspacos.endsWith('[') ||
          semEspacos.endsWith('=>');
      if (abriuBloco) recuo += tamanhoIndentacao;

      final espacos = ' ' * recuo;

      final fechaLogoDepois =
          depois.trimLeft().startsWith('}') && semEspacos.endsWith('{');
      if (fechaLogoDepois) {
        final recuoFecha = ' ' * (recuo - tamanhoIndentacao);
        final texto = '$antes\n$espacos\n$recuoFecha${depois.trimLeft()}';
        return TextEditingValue(
          text: texto,
          selection: TextSelection.collapsed(
            offset: antes.length + 1 + espacos.length,
          ),
        );
      }

      return TextEditingValue(
        text: '$antes\n$espacos$depois',
        selection: TextSelection.collapsed(
          offset: antes.length + 1 + espacos.length,
        ),
      );
    }

    if (_pares.containsValue(digitado) &&
        depois.isNotEmpty &&
        depois[0] == digitado) {
      return TextEditingValue(
        text: antes + depois,
        selection: TextSelection.collapsed(offset: cursor),
      );
    }

    if (digitado == '}') {
      final linhaAtual = _linhaQueTermina(antes);
      if (linhaAtual.trim().isEmpty && linhaAtual.length >= tamanhoIndentacao) {
        final cortado = antes.substring(0, antes.length - tamanhoIndentacao);
        return TextEditingValue(
          text: '$cortado}$depois',
          selection: TextSelection.collapsed(offset: cortado.length + 1),
        );
      }
      return novo;
    }

    final fechamento = _pares[digitado];
    if (fechamento != null) {
      final ehAspas = digitado == "'" || digitado == '"';
      if (ehAspas && depois.isNotEmpty && _ehLetraOuDigito(depois[0])) {
        return novo;
      }
      return TextEditingValue(
        text: '$antes$digitado$fechamento$depois',
        selection: TextSelection.collapsed(offset: cursor),
      );
    }

    return novo;
  }

  String _linhaQueTermina(String texto) {
    final i = texto.lastIndexOf('\n');
    return i == -1 ? texto : texto.substring(i + 1);
  }

  int _recuoDe(String linha) => linha.length - linha.trimLeft().length;

  bool _ehLetraOuDigito(String c) {
    final u = c.codeUnitAt(0);
    return (u >= 48 && u <= 57) ||
        (u >= 65 && u <= 90) ||
        (u >= 97 && u <= 122) ||
        c == '_';
  }
}
