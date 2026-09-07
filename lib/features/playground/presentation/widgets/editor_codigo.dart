import 'package:flutter/cupertino.dart';

import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import 'controlador_editor.dart';

const TextStyle estiloCodigo = TextStyle(
  fontFamily: TemaApp.fonteMono,
  fontSize: 13.5,
  height: 1.55,
  color: CoresApp.synPadrao,
  letterSpacing: 0,
);

class EditorCodigo extends StatelessWidget {
  const EditorCodigo({
    super.key,
    required this.controlador,
    required this.foco,
    required this.linhasComErro,
    required this.aoMudar,
  });

  final ControladorEditorDart controlador;
  final FocusNode foco;
  final Set<int> linhasComErro;
  final ValueChanged<String> aoMudar;

  static const double _larguraGutter = 46;
  static const EdgeInsets _paddingTexto = EdgeInsets.fromLTRB(12, 14, 14, 200);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: CoresApp.fundoCodigoEscuro,
      child: LayoutBuilder(
        builder: (context, restricoes) {
          final larguraTexto =
              restricoes.maxWidth -
              _larguraGutter -
              _paddingTexto.left -
              _paddingTexto.right;

          return ListenableBuilder(
            listenable: controlador,
            builder: (context, _) {
              final linhas = controlador.text.split('\n');
              final alturas = [
                for (final linha in linhas) _alturaDaLinha(linha, larguraTexto),
              ];

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(top: _paddingTexto.top),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (final (i, altura) in alturas.indexed)
                              SizedBox(
                                height: altura,
                                child: linhasComErro.contains(i + 1)
                                    ? const ColoredBox(color: Color(0x26DC2626))
                                    : null,
                              ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Numeros(
                          alturas: alturas,
                          linhasComErro: linhasComErro,
                          paddingTopo: _paddingTexto.top,
                        ),
                        Expanded(
                          child: Padding(
                            padding: _paddingTexto,
                            child: CupertinoTextField(
                              controller: controlador,
                              focusNode: foco,
                              onChanged: aoMudar,
                              maxLines: null,
                              expands: false,
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(),
                              style: estiloCodigo,
                              cursorColor: CoresApp.azulClaroDart,
                              cursorWidth: 2,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              enableSuggestions: false,
                              smartDashesType: SmartDashesType.disabled,
                              smartQuotesType: SmartQuotesType.disabled,
                              inputFormatters: const [FormatadorDart()],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  double _alturaDaLinha(String linha, double largura) {
    if (largura <= 0) return estiloCodigo.fontSize! * estiloCodigo.height!;
    final pintor = TextPainter(
      text: TextSpan(text: linha.isEmpty ? ' ' : linha, style: estiloCodigo),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: largura);
    return pintor.height;
  }
}

class _Numeros extends StatelessWidget {
  const _Numeros({
    required this.alturas,
    required this.linhasComErro,
    required this.paddingTopo,
  });

  final List<double> alturas;
  final Set<int> linhasComErro;
  final double paddingTopo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: EditorCodigo._larguraGutter,
      padding: EdgeInsets.only(top: paddingTopo),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFF1E2A3A))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final (i, altura) in alturas.indexed)
            SizedBox(
              height: altura,
              child: Padding(
                padding: const EdgeInsets.only(right: 9),
                child: Text(
                  '${i + 1}',
                  textAlign: TextAlign.right,
                  style: estiloCodigo.copyWith(
                    color: linhasComErro.contains(i + 1)
                        ? CoresApp.erro
                        : const Color(0xFF44556B),
                    fontWeight: linhasComErro.contains(i + 1)
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
