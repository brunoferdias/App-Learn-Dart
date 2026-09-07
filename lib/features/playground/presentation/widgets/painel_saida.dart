import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../domain/entities/diagnostico.dart';
import '../../domain/entities/resultado_execucao.dart';

class PainelSaida extends StatelessWidget {
  const PainelSaida({
    super.key,
    required this.resultado,
    required this.diagnosticos,
    required this.aoLimpar,
  });

  final ResultadoExecucao? resultado;
  final List<Diagnostico> diagnosticos;
  final VoidCallback aoLimpar;

  @override
  Widget build(BuildContext context) {
    final r = resultado;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0A121C),
        border: Border(left: BorderSide(color: Color(0xFF1E2A3A))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Cabecalho(resultado: r, aoLimpar: aoLimpar),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 24),
              children: [
                if (r == null && diagnosticos.isNotEmpty)
                  for (final d in diagnosticos)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _CaixaErro(diagnostico: d),
                    ),

                if (r == null && diagnosticos.isEmpty) const _Vazio(),

                if (r != null) ...[
                  for (final linha in r.saida)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        linha.isEmpty ? ' ' : linha,
                        style: const TextStyle(
                          fontFamily: TemaApp.fonteMono,
                          fontSize: 12.5,
                          height: 1.5,
                          color: Color(0xFFD3E2F2),
                        ),
                      ),
                    ),
                  if (r.erro case final erro?) ...[
                    const SizedBox(height: 10),
                    _CaixaErro(diagnostico: erro),
                  ] else ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.checkmark_circle_fill,
                          size: 13,
                          color: CoresApp.acerto,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            context.textos.editorEncerrouSemErros(
                              r.duracao.inMilliseconds,
                            ),
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: CoresApp.acerto,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Cabecalho extends StatelessWidget {
  const _Cabecalho({required this.resultado, required this.aoLimpar});

  final ResultadoExecucao? resultado;
  final VoidCallback aoLimpar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1E2A3A))),
      ),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.chevron_left_slash_chevron_right,
            size: 13,
            color: Color(0xFF6B7C93),
          ),
          const SizedBox(width: 7),
          const Text(
            'CONSOLE',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Color(0xFF7C8DA5),
            ),
          ),
          const Spacer(),
          if (resultado != null)
            GestureDetector(
              onTap: aoLimpar,
              child: Text(
                context.textos.editorLimpar,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF7C8DA5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Vazio extends StatelessWidget {
  const _Vazio();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const Icon(
            CupertinoIcons.play_circle,
            size: 30,
            color: Color(0xFF3A4A61),
          ),
          const SizedBox(height: 10),
          Text(
            context.textos.editorConsoleVazio,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: Color(0xFF5B6C82),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaixaErro extends StatelessWidget {
  const _CaixaErro({required this.diagnostico});

  final Diagnostico diagnostico;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CoresApp.erro.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CoresApp.erro.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                size: 13,
                color: CoresApp.erro,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  diagnostico.tipo.rotulo(context.textos).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: CoresApp.erro,
                  ),
                ),
              ),
              Text(
                diagnostico.arquivo.isEmpty
                    ? context.textos.editorLinha(diagnostico.linha)
                    : '${diagnostico.arquivo}:${diagnostico.linha}',
                style: const TextStyle(
                  fontFamily: TemaApp.fonteMono,
                  fontSize: 10.5,
                  color: Color(0xFF9BB0C9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            diagnostico.mensagem,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFFFFD9D9),
            ),
          ),
          if (diagnostico.dica case final dica?) ...[
            const SizedBox(height: 9),
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0x33101A26),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    CupertinoIcons.lightbulb_fill,
                    size: 12,
                    color: CoresApp.atencao,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      dica,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.45,
                        color: Color(0xFFCFE0F2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
