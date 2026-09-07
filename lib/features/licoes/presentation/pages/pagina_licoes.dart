import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/idioma.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../progresso/presentation/controllers/controlador_progresso.dart';
import '../controllers/controlador_licoes.dart';
import '../widgets/cartao_licao.dart';
import 'pagina_detalhe_licao.dart';

class PaginaLicoes extends StatefulWidget {
  const PaginaLicoes({super.key});

  @override
  State<PaginaLicoes> createState() => _PaginaLicoesState();
}

class _PaginaLicoesState extends State<PaginaLicoes> {
  late final ControladorLicoes _controlador;
  late final ControladorProgresso _progresso;

  Idioma? _idiomaCarregado;

  @override
  void initState() {
    super.initState();
    final injecao = EscopoApp.de(context);
    _controlador = injecao.criarControladorLicoes();
    _progresso = injecao.controladorProgresso;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textos = context.textos;
    if (_idiomaCarregado == textos.idioma) return;
    _idiomaCarregado = textos.idioma;
    _controlador.carregar(textos);
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(textos.licoesTitulo),
              border: null,
              backgroundColor: const Color(0x00000000),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
                child: ListenableBuilder(
                  listenable: _progresso,
                  builder: (context, _) => _Cabecalho(
                    concluidas: _progresso.progresso.licoesConcluidas.length,
                  ),
                ),
              ),
            ),
            ListenableBuilder(
              listenable: Listenable.merge([_controlador, _progresso]),
              builder: (context, _) {
                return switch (_controlador.estado) {
                  LicoesCarregando() => const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                  LicoesComErro(:final mensagem) => SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          mensagem,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: paleta.textoSuave),
                        ),
                      ),
                    ),
                  ),
                  LicoesCarregadas(:final licoes) => SliverList.separated(
                    itemCount: licoes.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final licao = licoes[i];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          i == licoes.length - 1
                              ? 28 + MediaQuery.paddingOf(context).bottom
                              : 0,
                        ),
                        child: CartaoLicao(
                          licao: licao,
                          numero: i + 1,
                          concluida: _progresso.progresso.concluiu(licao.id),
                          aoTocar: () => Navigator.of(context).push(
                            CupertinoPageRoute<void>(
                              builder: (_) => PaginaDetalheLicao(licao: licao),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Cabecalho extends StatelessWidget {
  const _Cabecalho({required this.concluidas});

  final int concluidas;

  static const int _totalLicoes = 11;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final fracao = (concluidas / _totalLicoes).clamp(0.0, 1.0);
    final comecou = concluidas > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comecou ? textos.licoesRetomarTitulo : textos.licoesComecarTitulo,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
            color: paleta.texto,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          textos.licoesSubtitulo,
          style: TextStyle(
            fontSize: 14,
            height: 1.45,
            color: paleta.textoSuave,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Stack(
                  children: [
                    Container(
                      height: 5,
                      color: paleta.textoSuave.withValues(alpha: 0.18),
                    ),
                    FractionallySizedBox(
                      widthFactor: fracao,
                      child: Container(height: 5, color: CoresApp.azulDart),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              textos.licoesConcluidasDe(concluidas, _totalLicoes),
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                fontFeatures: const [FontFeature.tabularFigures()],
                color: paleta.textoSuave,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
