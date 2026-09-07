import 'package:flutter/cupertino.dart';

import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../domain/entities/no_widget.dart';

const Map<String, IconData> _icones = {
  'star_fill': CupertinoIcons.star_fill,
  'checkmark_circle_fill': CupertinoIcons.checkmark_circle_fill,
  'xmark_circle_fill': CupertinoIcons.xmark_circle_fill,
  'lightbulb_fill': CupertinoIcons.lightbulb_fill,
};

class TelaSimulada extends StatelessWidget {
  const TelaSimulada({
    super.key,
    required this.raiz,
    this.destaques = const {},
    this.corDestaque,
  });

  final NoWidget raiz;

  final Set<String> destaques;
  final Color? corDestaque;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: paleta.superficie2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: paleta.borda),
      ),
      child: _No(
        no: raiz,
        caminho: '0',
        destaques: destaques,
        cor: corDestaque ?? CoresApp.azulDart,
      ),
    );
  }
}

class _No extends StatelessWidget {
  const _No({
    required this.no,
    required this.caminho,
    required this.destaques,
    required this.cor,
  });

  final NoWidget no;
  final String caminho;
  final Set<String> destaques;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    final filhos = [
      for (final (i, filho) in no.filhos.indexed)
        _No(no: filho, caminho: '$caminho.$i', destaques: destaques, cor: cor),
    ];

    final Widget conteudo = switch (no.tipo) {
      'Column' => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final filho in filhos)
            Padding(padding: const EdgeInsets.only(bottom: 8), child: filho),
        ],
      ),
      'Row' => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, filho) in filhos.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            Flexible(child: filho),
          ],
        ],
      ),
      'Center' => Center(child: filhos.isEmpty ? null : filhos.first),
      'Text' => Text(
        no.texto ?? '',
        style: TextStyle(fontSize: 14, height: 1.3, color: paleta.texto),
      ),
      'Icon' => Icon(
        _icones[no.icone] ?? CupertinoIcons.question_circle,
        size: 17,
        color: CoresApp.acerto,
      ),
      _ => _CaixaDeWidget(tipo: no.tipo, chave: no.chave, filhos: filhos),
    };

    if (!destaques.contains(caminho)) return conteudo;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cor, width: 1.6),
      ),
      child: conteudo,
    );
  }
}

class _CaixaDeWidget extends StatelessWidget {
  const _CaixaDeWidget({
    required this.tipo,
    required this.chave,
    required this.filhos,
  });

  final String tipo;
  final String? chave;
  final List<Widget> filhos;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 9),
      decoration: BoxDecoration(
        color: paleta.superficie,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: paleta.borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  tipo,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: TemaApp.fonteMono,
                    fontSize: 10,
                    color: paleta.textoSuave,
                  ),
                ),
              ),
              if (chave case final k?) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "key: '$k'",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: TemaApp.fonteMono,
                      fontSize: 10,
                      color: CoresApp.dica,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 5),
          ...filhos,
        ],
      ),
    );
  }
}
