import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/idioma.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/etiqueta.dart';
import '../../../../core/widgets/texto_rico.dart';
import '../controllers/controlador_playground.dart';
import 'pagina_editor.dart';

class PaginaPlayground extends StatefulWidget {
  const PaginaPlayground({super.key});

  @override
  State<PaginaPlayground> createState() => _PaginaPlaygroundState();
}

class _PaginaPlaygroundState extends State<PaginaPlayground> {
  ControladorPlayground? _controlador;
  Idioma? _idiomaAtual;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textos = context.textos;
    if (_controlador == null) {
      _controlador = EscopoApp.de(context).criarControladorPlayground(textos);
      _idiomaAtual = textos.idioma;
      return;
    }
    if (_idiomaAtual == textos.idioma) return;
    _idiomaAtual = textos.idioma;
    _controlador!.atualizarTextos(textos);
  }

  @override
  void dispose() {
    _controlador?.dispose();
    super.dispose();
  }

  void _abrirEditor() {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => PaginaEditor(controlador: _controlador!),
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
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(textos.editorTitulo),
              border: null,
              backgroundColor: const Color(0x00000000),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16,
                4,
                16,
                28 + MediaQuery.paddingOf(context).bottom,
              ),
              sliver: SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textos.editorChamadaTitulo,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            color: paleta.texto,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextoRico(
                          textos.editorChamadaTexto,
                          tamanho: 14,
                          alturaLinha: 1.45,
                          cor: paleta.textoSuave,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton(
                            color: CoresApp.acerto,
                            borderRadius: BorderRadius.circular(12),
                            onPressed: _abrirEditor,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.play_fill,
                                  size: 15,
                                  color: CupertinoColors.white,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    textos.editorAbrir,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  _Titulo(textos.editorComecePorExemplo),
                  const SizedBox(height: 10),
                  for (final exemplo in _controlador!.exemplos)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Cartao(
                        padding: const EdgeInsets.all(14),
                        aoTocar: () {
                          _controlador!.carregarExemplo(exemplo);
                          _abrirEditor();
                        },
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.doc_text,
                              size: 17,
                              color: paleta.textoSuave,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exemplo.titulo,
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.3,
                                      color: paleta.texto,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    exemplo.descricao,
                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.35,
                                      color: paleta.textoSuave,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (exemplo.arquivos.length > 1)
                              Etiqueta(
                                textos.abasContagem(exemplo.arquivos.length),
                                cor: CoresApp.azulDart,
                              ),
                            const SizedBox(width: 8),
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 15,
                              color: paleta.textoSuave.withValues(alpha: 0.6),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 14),

                  _Titulo(textos.editorComoFunciona),
                  const SizedBox(height: 10),
                  Cartao(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextoRico(textos.editorComoFuncionaTexto, tamanho: 14),
                        const SizedBox(height: 14),
                        _Lista(
                          titulo: textos.editorFunciona,
                          cor: CoresApp.acerto,
                          icone: CupertinoIcons.checkmark_circle,
                          itens: textos.editorFuncionaItens,
                        ),
                        const SizedBox(height: 14),
                        _Lista(
                          titulo: textos.editorAindaNao,
                          cor: CoresApp.atencao,
                          icone: CupertinoIcons.clock,
                          itens: textos.editorAindaNaoItens,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: CoresApp.azulDart.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextoRico(textos.editorRodape, tamanho: 13),
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
    );
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo(this.texto);
  final String texto;

  @override
  Widget build(BuildContext context) => Text(
    texto.toUpperCase(),
    style: TextStyle(
      fontSize: 11.5,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      color: context.paleta.textoSuave,
    ),
  );
}

class _Lista extends StatelessWidget {
  const _Lista({
    required this.titulo,
    required this.cor,
    required this.icone,
    required this.itens,
  });

  final String titulo;
  final Color cor;
  final IconData icone;
  final List<String> itens;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icone, size: 13, color: cor),
            const SizedBox(width: 6),
            Text(
              titulo.toUpperCase(),
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.9,
                color: cor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        for (final item in itens)
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 19),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('· ', style: TextStyle(color: paleta.textoSuave)),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: paleta.textoSuave,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
