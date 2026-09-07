import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../domain/repositories/playground_repositorio.dart';
import '../controllers/controlador_playground.dart';
import '../widgets/abas_arquivos.dart';
import '../widgets/controlador_editor.dart';
import '../widgets/editor_codigo.dart';
import '../widgets/painel_saida.dart';

class PaginaEditor extends StatefulWidget {
  const PaginaEditor({super.key, required this.controlador});

  final ControladorPlayground controlador;

  @override
  State<PaginaEditor> createState() => _PaginaEditorState();
}

class _PaginaEditorState extends State<PaginaEditor> {
  late final ControladorEditorDart _editor;
  final FocusNode _foco = FocusNode();

  int _abaCarregada = 0;

  ControladorPlayground get _c => widget.controlador;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _editor = ControladorEditorDart(text: _c.arquivoAtivo.conteudo);
    _abaCarregada = _c.indiceAtivo;
    _c.addListener(_sincronizarAba);
  }

  void _sincronizarAba() {
    if (_c.indiceAtivo == _abaCarregada) return;
    _abaCarregada = _c.indiceAtivo;
    _editor.value = TextEditingValue(
      text: _c.arquivoAtivo.conteudo,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _c.removeListener(_sincronizarAba);
    _foco.dispose();
    _editor.dispose();

    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  Future<void> _escolherExemplo() async {
    final escolhido = await showCupertinoModalPopup<ExemploPlayground>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(context.textos.editorCarregarExemplo),
        message: Text(context.textos.editorCarregarExemploAviso),
        actions: [
          for (final exemplo in _c.exemplos)
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(exemplo),
              child: Text(exemplo.titulo),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.textos.cancelar),
        ),
      ),
    );

    if (escolhido == null) return;
    _c.carregarExemplo(escolhido);
    _abaCarregada = 0;
    _editor.value = TextEditingValue(
      text: _c.arquivoAtivo.conteudo,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void _rodar() {
    _foco.unfocus();
    _c.rodar();
    _sincronizarAba();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CoresApp.fundoCodigoEscuro,
      child: SafeArea(
        child: ListenableBuilder(
          listenable: _c,
          builder: (context, _) {
            final deitado =
                MediaQuery.sizeOf(context).width >
                MediaQuery.sizeOf(context).height;

            final editor = Column(
              children: [
                AbasArquivos(
                  arquivos: _c.arquivos,
                  ativo: _c.indiceAtivo,
                  arquivosComErro: {
                    for (final d in _c.diagnosticos) d.arquivo,
                    if (_c.resultado?.erro case final e?) e.arquivo,
                  },
                  aoSelecionar: _c.selecionar,
                  aoAdicionar: () {
                    _c.adicionarArquivo();
                    _sincronizarAba();
                  },
                  aoFechar: (i) {
                    _c.removerArquivo(i);
                    _abaCarregada = -1;
                    _sincronizarAba();
                  },
                  aoRenomear: _c.renomear,
                ),
                Expanded(
                  child: EditorCodigo(
                    controlador: _editor,
                    foco: _foco,
                    linhasComErro: _c.linhasComErroNoAtivo,
                    aoMudar: _c.atualizarConteudo,
                  ),
                ),
              ],
            );

            final saida = PainelSaida(
              resultado: _c.resultado,
              diagnosticos: _c.diagnosticos,
              aoLimpar: _c.limparSaida,
            );

            return Column(
              children: [
                _BarraSuperior(
                  aoVoltar: () => Navigator.of(context).pop(),
                  aoRodar: _rodar,
                  aoAbrirExemplos: _escolherExemplo,
                ),
                Expanded(
                  child: deitado
                      ? Row(
                          children: [
                            Expanded(flex: 62, child: editor),
                            Expanded(flex: 38, child: saida),
                          ],
                        )
                      : Column(
                          children: [
                            Expanded(flex: 60, child: editor),
                            Expanded(flex: 40, child: saida),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BarraSuperior extends StatelessWidget {
  const _BarraSuperior({
    required this.aoVoltar,
    required this.aoRodar,
    required this.aoAbrirExemplos,
  });

  final VoidCallback aoVoltar;
  final VoidCallback aoRodar;
  final VoidCallback aoAbrirExemplos;

  @override
  Widget build(BuildContext context) {
    final Textos textos = context.textos;

    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF0A121C),
        border: Border(bottom: BorderSide(color: Color(0xFF1E2A3A))),
      ),
      child: Row(
        children: [
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            onPressed: aoVoltar,
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.chevron_left,
                  size: 17,
                  color: CoresApp.azulClaroDart,
                ),
                Text(
                  textos.editorSair,
                  style: const TextStyle(
                    fontSize: 15,
                    color: CoresApp.azulClaroDart,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            textos.editorNome,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: CoresApp.synPadrao,
            ),
          ),
          const Spacer(),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            minimumSize: Size.zero,
            onPressed: aoAbrirExemplos,
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.square_stack_3d_up,
                  size: 15,
                  color: Color(0xFF9BB0C9),
                ),
                const SizedBox(width: 5),
                Text(
                  textos.editorExemplos,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9BB0C9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            minimumSize: Size.zero,
            borderRadius: BorderRadius.circular(9),
            color: CoresApp.acerto,
            onPressed: aoRodar,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.play_fill,
                  size: 13,
                  color: CupertinoColors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  textos.editorRodar,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.white,
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
