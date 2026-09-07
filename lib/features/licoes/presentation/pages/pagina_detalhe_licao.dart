import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/etiqueta.dart';
import '../../../avaliacao/domain/entities/momento_avaliacao.dart';
import '../../../avaliacao/presentation/controllers/controlador_avaliacao.dart';
import '../../../exercicios/presentation/pages/pagina_quiz.dart';
import '../../../progresso/presentation/controllers/controlador_progresso.dart';
import '../../domain/entities/licao.dart';
import '../widgets/bloco_widget.dart';
import '../widgets/cartao_licao.dart' show corDoNivel;

class PaginaDetalheLicao extends StatelessWidget {
  const PaginaDetalheLicao({super.key, required this.licao});

  final Licao licao;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final injecao = EscopoApp.de(context);
    final progresso = injecao.controladorProgresso;
    final avaliacao = injecao.controladorAvaliacao;
    final cor = corDoNivel(licao.nivel);

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      navigationBar: CupertinoNavigationBar(
        middle: Text(licao.titulo),
        previousPageTitle: textos.licoesPrevious,
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          children: [
            Text(
              licao.titulo,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
                height: 1.12,
                color: paleta.texto,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                Etiqueta(licao.nivel.rotulo(textos), cor: cor),
                Etiqueta(
                  textos.minutosDeLeitura(licao.minutos),
                  cor: paleta.textoSuave,
                  icone: CupertinoIcons.clock,
                ),
              ],
            ),
            const SizedBox(height: 20),

            Cartao(
              corFundo: CoresApp.azulDart.withValues(alpha: 0.05),
              corBorda: CoresApp.azulDart.withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.checkmark_circle,
                        size: 15,
                        color: CoresApp.azulDart,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        textos.licaoObjetivos.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.9,
                          color: paleta.escuro
                              ? CoresApp.azulClaroDart
                              : CoresApp.azulEscuroDart,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  for (final objetivo in licao.objetivos)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '•  ',
                            style: TextStyle(color: paleta.textoSuave),
                          ),
                          Expanded(
                            child: Text(
                              objetivo,
                              style: TextStyle(
                                fontSize: 14.5,
                                height: 1.4,
                                color: paleta.texto,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            for (final bloco in licao.blocos) ...[
              BlocoWidget(bloco),
              const SizedBox(height: 18),
            ],

            const SizedBox(height: 6),
            _AcoesFinais(
              licao: licao,
              progresso: progresso,
              avaliacao: avaliacao,
            ),
          ],
        ),
      ),
    );
  }
}

class _AcoesFinais extends StatelessWidget {
  const _AcoesFinais({
    required this.licao,
    required this.progresso,
    required this.avaliacao,
  });

  final Licao licao;
  final ControladorProgresso progresso;
  final ControladorAvaliacao avaliacao;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return Cartao(
      child: Column(
        children: [
          Text(
            textos.licaoTerminouTitulo,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: paleta.texto,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            textos.licaoTerminouTexto,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: paleta.textoSuave,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.circular(12),
              onPressed: () {
                progresso.marcarLicaoConcluida(licao.id);
                Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (_) =>
                        PaginaQuiz(licaoId: licao.id, titulo: licao.titulo),
                  ),
                );
              },
              child: Text(textos.licaoPraticar),
            ),
          ),
          const SizedBox(height: 6),
          CupertinoButton(
            onPressed: () {
              // Só é um momento bom se a lição estiver sendo concluída agora:
              // remarcar uma lição velha não conta.
              final concluindoAgora = !progresso.progresso.concluiu(licao.id);

              progresso.marcarLicaoConcluida(licao.id);

              if (concluindoAgora) {
                avaliacao.registrarMomento(MomentoAvaliacao.licaoConcluida);
              }

              Navigator.of(context).pop();
            },
            child: Text(textos.licaoMarcarConcluida),
          ),
        ],
      ),
    );
  }
}
