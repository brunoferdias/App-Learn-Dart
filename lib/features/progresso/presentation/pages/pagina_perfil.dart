import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/controlador_tema.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/modo_tema.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/texto_rico.dart';
import '../../../../core/widgets/visualizador_codigo.dart';
import '../../../avaliacao/presentation/widgets/cartao_avaliacao.dart';
import '../../../onboarding/presentation/widgets/aviso_nao_oficial.dart';
import '../../../onboarding/presentation/widgets/seletor_idioma.dart';
import '../../../privacidade/presentation/widgets/secao_privacidade.dart';
import '../controllers/controlador_progresso.dart';

class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final injecao = EscopoApp.de(context);
    final ControladorProgresso progresso = injecao.controladorProgresso;
    final ControladorTema tema = injecao.controladorTema;

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(textos.perfilTitulo),
              border: null,
              backgroundColor: const Color(0x00000000),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16,
                4,
                16,
                32 + MediaQuery.paddingOf(context).bottom,
              ),
              sliver: SliverList.list(
                children: [
                  ListenableBuilder(
                    listenable: progresso,
                    builder: (context, _) {
                      final p = progresso.progresso;
                      return Row(
                        children: [
                          Expanded(
                            child: _Metrica(
                              valor: '${p.licoesConcluidas.length}',
                              rotulo: textos.perfilMetricaLicoes,
                              cor: CoresApp.azulDart,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _Metrica(
                              valor: '${p.acertos}',
                              rotulo: textos.perfilMetricaAcertos,
                              cor: CoresApp.acerto,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _Metrica(
                              valor: p.totalRespondido == 0
                                  ? '—'
                                  : '${p.percentual}%',
                              rotulo: textos.perfilMetricaAproveitamento,
                              cor: CoresApp.dica,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  _Titulo(textos.perfilIdioma),
                  const SizedBox(height: 10),
                  SeletorIdioma(controlador: injecao.controladorIdioma),
                  const SizedBox(height: 8),
                  Text(
                    textos.perfilIdiomaNota,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: paleta.textoSuave,
                    ),
                  ),
                  const SizedBox(height: 24),

                  _Titulo(textos.perfilAparencia),
                  const SizedBox(height: 10),
                  ListenableBuilder(
                    listenable: tema,
                    builder: (context, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl<ModoTema>(
                            groupValue: tema.modo,
                            onValueChanged: (novo) {
                              if (novo != null) tema.trocarPara(novo);
                            },
                            children: {
                              for (final m in ModoTema.values)
                                m: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    m.rotulo(textos),
                                    style: const TextStyle(fontSize: 13.5),
                                  ),
                                ),
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              switch (tema.modo) {
                                ModoTema.sistema => CupertinoIcons.gear_alt,
                                ModoTema.claro => CupertinoIcons.sun_max,
                                ModoTema.escuro => CupertinoIcons.moon,
                              },
                              size: 15,
                              color: paleta.textoSuave,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                tema.modo.descricao(textos),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: paleta.textoSuave,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),

                  CartaoAvaliacao(controlador: injecao.controladorAvaliacao),
                  const SizedBox(height: 26),

                  _Titulo(textos.privacidadeSecao),
                  const SizedBox(height: 10),
                  const SecaoPrivacidade(),
                  const SizedBox(height: 26),

                  _Titulo(textos.perfilSobreTitulo),
                  const SizedBox(height: 10),
                  const AvisoNaoOficial(),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      onPressed: injecao.controladorOnboarding.reabrir,
                      child: Text(
                        textos.perfilRevisarOnboarding,
                        style: const TextStyle(
                          fontSize: 14.5,
                          color: CoresApp.azulDart,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),

                  _Titulo(textos.perfilArquiteturaTitulo),
                  const SizedBox(height: 10),
                  Cartao(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextoRico(textos.perfilArquiteturaTexto, tamanho: 14.5),
                        const SizedBox(height: 14),
                        const VisualizadorCodigo(
                          compacto: true,
                          codigo: '''
lib/
├── core/          # tema, i18n, Resultado<T>, widgets comuns
├── features/
│   └── licoes/
│       ├── domain/        # entidades + contratos + casos de uso
│       ├── data/          # datasources + repositórios concretos
│       └── presentation/  # controladores + telas
├── app/           # injeção de dependências + CupertinoApp
└── main.dart''',
                        ),
                        const SizedBox(height: 14),
                        for (final (icone, titulo, texto) in [
                          (
                            CupertinoIcons.cube_box,
                            'domain',
                            textos.perfilCamadaDomain,
                          ),
                          (
                            CupertinoIcons.tray_full,
                            'data',
                            textos.perfilCamadaData,
                          ),
                          (
                            CupertinoIcons.device_phone_portrait,
                            'presentation',
                            textos.perfilCamadaPresentation,
                          ),
                        ])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(icone, size: 17, color: CoresApp.azulDart),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        titulo,
                                        style: TextStyle(
                                          fontFamily: TemaApp.fonteMono,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                          color: paleta.texto,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      TextoRico(
                                        texto,
                                        tamanho: 13.5,
                                        cor: paleta.textoSuave,
                                        alturaLinha: 1.4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  _Titulo(textos.perfilEstudarTitulo),
                  const SizedBox(height: 10),
                  Cartao(
                    padding: const EdgeInsets.all(16),
                    child: TextoRico(textos.perfilEstudarTexto, tamanho: 14),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      textos.perfilRodape,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: paleta.textoSuave.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo(this.texto);
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: context.paleta.textoSuave,
      ),
    );
  }
}

class _Metrica extends StatelessWidget {
  const _Metrica({
    required this.valor,
    required this.rotulo,
    required this.cor,
  });

  final String valor;
  final String rotulo;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Cartao(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      child: Column(
        children: [
          Text(
            valor,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              color: cor,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            rotulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.25,
              color: paleta.textoSuave,
            ),
          ),
        ],
      ),
    );
  }
}
