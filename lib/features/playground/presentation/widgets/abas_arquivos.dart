import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../domain/entities/arquivo_dart.dart';

class AbasArquivos extends StatelessWidget {
  const AbasArquivos({
    super.key,
    required this.arquivos,
    required this.ativo,
    required this.arquivosComErro,
    required this.aoSelecionar,
    required this.aoAdicionar,
    required this.aoFechar,
    required this.aoRenomear,
  });

  final List<ArquivoDart> arquivos;
  final int ativo;
  final Set<String> arquivosComErro;
  final ValueChanged<int> aoSelecionar;
  final VoidCallback aoAdicionar;
  final ValueChanged<int> aoFechar;
  final void Function(int indice, String nome) aoRenomear;

  Future<void> _pedirNome(BuildContext context, int indice) async {
    final controlador = TextEditingController(text: arquivos[indice].nome);

    final novo = await showCupertinoDialog<String>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(context.textos.editorRenomearArquivo),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CupertinoTextField(
            controller: controlador,
            autofocus: true,
            placeholder: context.textos.editorNomePlaceholder,
            autocorrect: false,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.textos.cancelar),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(controlador.text),
            child: Text(context.textos.salvar),
          ),
        ],
      ),
    );

    controlador.dispose();
    if (novo != null && novo.trim().isNotEmpty) aoRenomear(indice, novo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: const BoxDecoration(
        color: Color(0xFF0A121C),
        border: Border(bottom: BorderSide(color: Color(0xFF1E2A3A))),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: arquivos.length,
              itemBuilder: (context, i) {
                final arquivo = arquivos[i];
                final selecionada = i == ativo;
                final comErro = arquivosComErro.contains(arquivo.nome);

                return GestureDetector(
                  onTap: () => aoSelecionar(i),
                  onLongPress: () => _pedirNome(context, i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: selecionada
                          ? CoresApp.fundoCodigoEscuro
                          : const Color(0x00000000),
                      border: Border(
                        top: BorderSide(
                          color: selecionada
                              ? CoresApp.azulClaroDart
                              : const Color(0x00000000),
                          width: 2,
                        ),
                        right: const BorderSide(color: Color(0xFF1E2A3A)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          comErro
                              ? CupertinoIcons.exclamationmark_circle_fill
                              : CupertinoIcons.doc_text,
                          size: 12,
                          color: comErro
                              ? CoresApp.erro
                              : (selecionada
                                    ? CoresApp.azulClaroDart
                                    : const Color(0xFF6B7C93)),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          arquivo.nome,
                          style: TextStyle(
                            fontFamily: TemaApp.fonteMono,
                            fontSize: 12,
                            fontWeight: selecionada
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: selecionada
                                ? CoresApp.synPadrao
                                : const Color(0xFF7C8DA5),
                          ),
                        ),
                        if (selecionada && arquivos.length > 1) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => aoFechar(i),
                            child: const Icon(
                              CupertinoIcons.xmark,
                              size: 11,
                              color: Color(0xFF7C8DA5),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: aoAdicionar,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.add,
                size: 16,
                color: Color(0xFF7C8DA5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
