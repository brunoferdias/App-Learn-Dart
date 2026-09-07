import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/idioma.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/etiqueta.dart';
import '../../../licoes/presentation/widgets/cartao_licao.dart' show corDoNivel;
import '../controllers/controlador_praticar.dart';
import 'pagina_quiz.dart';

class PaginaPraticar extends StatefulWidget {
  const PaginaPraticar({super.key});

  @override
  State<PaginaPraticar> createState() => _PaginaPraticarState();
}

class _PaginaPraticarState extends State<PaginaPraticar> {
  late final ControladorPraticar _controlador;
  Idioma? _idiomaCarregado;

  @override
  void initState() {
    super.initState();
    final injecao = EscopoApp.de(context);
    _controlador = ControladorPraticar(
      listarLicoes: injecao.listarLicoes,
      listarExercicios: injecao.listarExercicios,
    );
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

  void _abrirQuiz({String? licaoId, required String titulo}) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (_) => PaginaQuiz(licaoId: licaoId, titulo: titulo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      child: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _controlador,
          builder: (context, _) {
            if (_controlador.carregando) {
              return const Center(child: CupertinoActivityIndicator());
            }

            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text(textos.praticarTitulo),
                  border: null,
                  backgroundColor: const Color(0x00000000),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textos.praticarChamadaTitulo,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            color: paleta.texto,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          textos.praticarChamadaTexto(
                            _controlador.totalExercicios,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.45,
                            color: paleta.textoSuave,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton.filled(
                            borderRadius: BorderRadius.circular(12),
                            onPressed: () =>
                                _abrirQuiz(titulo: textos.praticarDesafioGeral),
                            child: Text(textos.praticarTudo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList.separated(
                  itemCount: _controlador.itens.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final (licao, quantidade) = _controlador.itens[i];
                    final cor = corDoNivel(licao.nivel);

                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        i == _controlador.itens.length - 1
                            ? 28 + MediaQuery.paddingOf(context).bottom
                            : 0,
                      ),
                      child: Cartao(
                        padding: const EdgeInsets.all(14),
                        aoTocar: quantidade == 0
                            ? null
                            : () => _abrirQuiz(
                                licaoId: licao.id,
                                titulo: licao.titulo,
                              ),
                        child: Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: cor.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                  color: cor.withValues(alpha: 0.24),
                                ),
                              ),
                              child: Text(
                                (i + 1).toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontFamily: TemaApp.fonteMono,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: cor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    licao.titulo,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.3,
                                      color: paleta.texto,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Etiqueta(
                                    textos.exerciciosContagem(quantidade),
                                    cor: cor,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 15,
                              color: paleta.textoSuave.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
