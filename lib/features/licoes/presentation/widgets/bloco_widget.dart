import 'package:flutter/cupertino.dart';

import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/caixa_destaque.dart';
import '../../../../core/widgets/texto_rico.dart';
import '../../../../core/widgets/visualizador_codigo.dart';
import '../../../testes/presentation/pages/pagina_laboratorio.dart';
import '../../domain/entities/bloco_conteudo.dart';

class BlocoWidget extends StatelessWidget {
  const BlocoWidget(this.bloco, {super.key});

  final BlocoConteudo bloco;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return switch (bloco) {
      BlocoTexto(:final texto) => TextoRico(texto),

      BlocoTitulo(:final texto) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: CoresApp.azulDart,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                texto,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  color: paleta.texto,
                ),
              ),
            ),
          ],
        ),
      ),

      BlocoCodigo(:final codigo, :final legenda, :final saida) =>
        VisualizadorCodigo(codigo: codigo, legenda: legenda, saida: saida),

      BlocoDica(:final texto) => CaixaDestaque(
        tipo: TipoDestaque.dica,
        texto: texto,
      ),

      BlocoAviso(:final texto) => CaixaDestaque(
        tipo: TipoDestaque.aviso,
        texto: texto,
      ),

      BlocoLista(:final itens) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in itens)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, right: 10),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: CoresApp.azulDart,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(child: TextoRico(item, tamanho: 15.5)),
                ],
              ),
            ),
        ],
      ),

      BlocoTabela(:final cabecalho, :final linhas) => _Tabela(
        cabecalho: cabecalho,
        linhas: linhas,
      ),

      BlocoLaboratorio(:final titulo, :final chamada) => _CartaoLaboratorio(
        titulo: titulo,
        chamada: chamada,
      ),

      BlocoComparacao(
        :final codigoErrado,
        :final notaErrado,
        :final codigoCerto,
        :final notaCerto,
      ) =>
        Column(
          children: [
            _LadoComparacao(
              titulo: context.textos.blocoErrado,
              icone: CupertinoIcons.xmark_circle_fill,
              cor: CoresApp.erro,
              codigo: codigoErrado,
              nota: notaErrado,
            ),
            const SizedBox(height: 12),
            _LadoComparacao(
              titulo: context.textos.blocoCerto,
              icone: CupertinoIcons.checkmark_circle_fill,
              cor: CoresApp.acerto,
              codigo: codigoCerto,
              nota: notaCerto,
            ),
          ],
        ),
    };
  }
}

class _CartaoLaboratorio extends StatelessWidget {
  const _CartaoLaboratorio({required this.titulo, required this.chamada});

  final String titulo;
  final String chamada;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CoresApp.acerto.withValues(alpha: paleta.escuro ? 0.16 : 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CoresApp.acerto.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.wand_stars,
                size: 17,
                color: CoresApp.acerto,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    color: paleta.texto,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextoRico(chamada, tamanho: 14.5, cor: paleta.textoSuave),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: CoresApp.acerto,
              borderRadius: BorderRadius.circular(12),
              onPressed: () => Navigator.of(context).push(
                CupertinoPageRoute<void>(
                  builder: (_) => const PaginaLaboratorio(),
                ),
              ),
              child: Text(
                context.textos.blocoAbrirLaboratorio,
                style: const TextStyle(color: CupertinoColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LadoComparacao extends StatelessWidget {
  const _LadoComparacao({
    required this.titulo,
    required this.icone,
    required this.cor,
    required this.codigo,
    required this.nota,
  });

  final String titulo;
  final IconData icone;
  final Color cor;
  final String codigo;
  final String nota;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icone, size: 15, color: cor),
              const SizedBox(width: 6),
              Text(
                titulo.toUpperCase(),
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: cor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          VisualizadorCodigo(
            codigo: codigo,
            compacto: true,
            corBorda: cor.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 9),
          TextoRico(nota, tamanho: 14, cor: context.paleta.textoSuave),
        ],
      ),
    );
  }
}

class _Tabela extends StatelessWidget {
  const _Tabela({required this.cabecalho, required this.linhas});

  final (String, String) cabecalho;
  final List<(String, String)> linhas;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Container(
      decoration: BoxDecoration(
        color: paleta.superficie,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: paleta.borda),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            color: CoresApp.azulDart.withValues(alpha: 0.10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    cabecalho.$1,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: CoresApp.azulDart,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    cabecalho.$2,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: CoresApp.azulDart,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (final (indice, linha) in linhas.indexed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: indice == 0
                    ? null
                    : Border(top: BorderSide(color: paleta.borda)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      linha.$1,
                      style: TextStyle(
                        fontFamily: TemaApp.fonteMono,
                        fontSize: 12.5,
                        height: 1.4,
                        color: paleta.escuro
                            ? CoresApp.azulClaroDart
                            : CoresApp.azulEscuroDart,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 6,
                    child: TextoRico(
                      linha.$2,
                      tamanho: 13.5,
                      alturaLinha: 1.4,
                      cor: paleta.textoSuave,
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
