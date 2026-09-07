import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../i18n/escopo_textos.dart';
import '../tema/cores_app.dart';
import '../tema/tema_app.dart';
import 'destaque_dart.dart';

class VisualizadorCodigo extends StatelessWidget {
  const VisualizadorCodigo({
    super.key,
    required this.codigo,
    this.legenda,
    this.saida,
    this.corBorda,
    this.compacto = false,
  });

  final String codigo;
  final String? legenda;
  final String? saida;
  final Color? corBorda;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final codigoLimpo = codigo.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: paleta.fundoCodigo,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: corBorda ?? CoresApp.azulDart.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!compacto) _BarraSuperior(codigo: codigoLimpo),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.fromLTRB(16, compacto ? 14 : 4, 16, 14),
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: TemaApp.fonteMono,
                      fontSize: 13,
                      height: 1.55,
                      color: CoresApp.synPadrao,
                    ),
                    children: destacarDart(codigoLimpo),
                  ),
                ),
              ),
              if (saida case final s?) _Saida(texto: s),
            ],
          ),
        ),
        if (legenda case final l?)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              l,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: paleta.textoSuave,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}

class _BarraSuperior extends StatefulWidget {
  const _BarraSuperior({required this.codigo});
  final String codigo;

  @override
  State<_BarraSuperior> createState() => _BarraSuperiorState();
}

class _BarraSuperiorState extends State<_BarraSuperior> {
  bool _copiado = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 0),
      child: Row(
        children: [
          for (final cor in const [
            Color(0xFFFF5F57),
            Color(0xFFFEBC2E),
            Color(0xFF28C840),
          ])
            Container(
              width: 9,
              height: 9,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: cor.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            ),
          const SizedBox(width: 6),
          const Text(
            'dart',
            style: TextStyle(
              fontFamily: TemaApp.fonteMono,
              fontSize: 11,
              color: CoresApp.synComentario,
            ),
          ),
          const Spacer(),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            minimumSize: Size.zero,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: widget.codigo));
              if (!mounted) return;
              setState(() => _copiado = true);
              await Future<void>.delayed(const Duration(seconds: 2));
              if (!mounted) return;
              setState(() => _copiado = false);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _copiado
                      ? CupertinoIcons.checkmark_alt
                      : CupertinoIcons.doc_on_doc,
                  size: 13,
                  color: _copiado ? CoresApp.acerto : CoresApp.synComentario,
                ),
                const SizedBox(width: 4),
                Text(
                  _copiado
                      ? context.textos.blocoCopiado
                      : context.textos.blocoCopiar,
                  style: TextStyle(
                    fontSize: 11,
                    color: _copiado ? CoresApp.acerto : CoresApp.synComentario,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Saida extends StatelessWidget {
  const _Saida({required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: CoresApp.azulEscuroDart.withValues(alpha: 0.18),
        border: Border(
          top: BorderSide(color: CoresApp.azulDart.withValues(alpha: 0.3)),
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.chevron_right_2,
                size: 11,
                color: CoresApp.azulClaroDart,
              ),
              const SizedBox(width: 5),
              Text(
                context.textos.blocoSaidaConsole.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                  color: CoresApp.azulClaroDart.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            texto,
            style: const TextStyle(
              fontFamily: TemaApp.fonteMono,
              fontSize: 12.5,
              height: 1.5,
              color: Color(0xFFCBE3F7),
            ),
          ),
        ],
      ),
    );
  }
}
