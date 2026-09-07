import 'package:flutter/cupertino.dart';

import '../tema/cores_app.dart';

const String _palavrasChave =
    'abstract|as|assert|async|await|base|break|case|catch|class|const|continue|'
    'covariant|default|deferred|do|dynamic|else|enum|export|extends|extension|'
    'external|factory|false|final|finally|for|Function|get|hide|if|implements|'
    'import|in|interface|is|late|library|mixin|new|null|on|operator|part|'
    'required|rethrow|return|sealed|set|show|static|super|switch|sync|this|'
    'throw|true|try|typedef|var|void|when|while|with|yield';

final RegExp tokensDart = RegExp(
  <String>[
    r"(?<comentario>//[^\n]*|/\*[\s\S]*?\*/)",
    r"""(?<texto>r?'''[\s\S]*?'''|r?'(?:[^'\\\n]|\\.)*'|r?"(?:[^"\\\n]|\\.)*")""",
    r"(?<lacuna>_{3})",
    r"(?<anotacao>@\w+)",
    r"(?<numero>\b\d+(?:\.\d+)?\b)",
    '(?<palavra>\\b(?:$_palavrasChave)\\b)',
    r"(?<tipo>\b[A-Z]\w*\b)",
  ].join('|'),
);

List<TextSpan> destacarDart(String fonte, {bool destacarLacuna = true}) {
  final spans = <TextSpan>[];
  var posicao = 0;

  for (final m in tokensDart.allMatches(fonte)) {
    if (m.start > posicao) {
      spans.add(TextSpan(text: fonte.substring(posicao, m.start)));
    }

    final ehLacuna = m.namedGroup('lacuna') != null;
    if (ehLacuna && !destacarLacuna) {
      spans.add(TextSpan(text: m[0]));
      posicao = m.end;
      continue;
    }

    final (Color cor, FontWeight peso, bool italico) = switch (m) {
      _ when m.namedGroup('comentario') != null => (
        CoresApp.synComentario,
        FontWeight.w400,
        true,
      ),
      _ when m.namedGroup('texto') != null => (
        CoresApp.synTexto,
        FontWeight.w400,
        false,
      ),
      _ when ehLacuna => (CoresApp.atencao, FontWeight.w700, false),
      _ when m.namedGroup('anotacao') != null => (
        CoresApp.synAnotacao,
        FontWeight.w500,
        false,
      ),
      _ when m.namedGroup('numero') != null => (
        CoresApp.synNumero,
        FontWeight.w400,
        false,
      ),
      _ when m.namedGroup('palavra') != null => (
        CoresApp.synPalavraChave,
        FontWeight.w600,
        false,
      ),
      _ => (CoresApp.synTipo, FontWeight.w400, false),
    };

    spans.add(
      TextSpan(
        text: m[0],
        style: TextStyle(
          color: cor,
          fontWeight: peso,
          fontStyle: italico ? FontStyle.italic : FontStyle.normal,
          backgroundColor: ehLacuna
              ? CoresApp.atencao.withValues(alpha: 0.18)
              : null,
        ),
      ),
    );
    posicao = m.end;
  }

  if (posicao < fonte.length) {
    spans.add(TextSpan(text: fonte.substring(posicao)));
  }
  return spans;
}
