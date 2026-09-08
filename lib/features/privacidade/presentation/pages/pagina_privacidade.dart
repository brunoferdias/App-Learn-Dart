import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/texto_rico.dart';
import '../../domain/entities/documento_legal.dart';

/// A política de privacidade e os termos, lidos de dentro do app.
///
/// O documento é `const`, então não há carregamento nem estado: a tela é um
/// [StatelessWidget] que desenha o que já está compilado.
class PaginaPrivacidade extends StatelessWidget {
  const PaginaPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final documento = EscopoApp.de(context).obterDocumentoLegal(textos.idioma);

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      navigationBar: CupertinoNavigationBar(
        middle: Text(textos.privacidadePaginaTitulo),
        previousPageTitle: textos.perfilTitulo,
        backgroundColor: paleta.superficie.withValues(alpha: 0.94),
        border: Border(bottom: BorderSide(color: paleta.borda)),
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            32 + MediaQuery.paddingOf(context).bottom,
          ),
          children: [
            _Resumo(documento: documento),
            const SizedBox(height: 14),
            _Ficha(documento: documento),
            for (final (indice, parte) in documento.partes.indexed) ...[
              const SizedBox(height: 30),
              _CabecalhoParte(numero: indice + 1, titulo: parte.titulo),
              for (final clausula in parte.clausulas) ...[
                const SizedBox(height: 14),
                _Clausula(clausula: clausula),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _Resumo extends StatelessWidget {
  const _Resumo({required this.documento});
  final DocumentoLegal documento;

  @override
  Widget build(BuildContext context) {
    final textos = context.textos;

    return Cartao(
      corFundo: CoresApp.azulDart.withValues(alpha: 0.08),
      corBorda: CoresApp.azulDart.withValues(alpha: 0.24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.lock_shield,
                size: 15,
                color: CoresApp.azulDart,
              ),
              const SizedBox(width: 7),
              Text(
                textos.privacidadeResumoRotulo.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.9,
                  color: CoresApp.azulDart,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          TextoRico(documento.resumo, tamanho: 15, alturaLinha: 1.5),
        ],
      ),
    );
  }
}

/// Versão, data e contato — os três dados que a App Store pede que estejam
/// visíveis no documento.
class _Ficha extends StatelessWidget {
  const _Ficha({required this.documento});
  final DocumentoLegal documento;

  @override
  Widget build(BuildContext context) {
    final textos = context.textos;

    return Cartao(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          for (final (rotulo, valor) in [
            (textos.privacidadeAtualizado, documento.atualizadoEm),
            (textos.privacidadeContato, documento.contato),
          ])
            _LinhaFicha(rotulo: rotulo, valor: valor),
        ],
      ),
    );
  }
}

class _LinhaFicha extends StatelessWidget {
  const _LinhaFicha({required this.rotulo, required this.valor});

  final String rotulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rotulo,
            style: TextStyle(fontSize: 13.5, color: paleta.textoSuave),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              valor,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: TemaApp.fonteMono,
                fontSize: 12.5,
                color: paleta.texto,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CabecalhoParte extends StatelessWidget {
  const _CabecalhoParte({required this.numero, required this.titulo});

  final int numero;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.textos.privacidadeParte(numero).toUpperCase(),
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: paleta.textoSuave,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          titulo,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
            color: paleta.texto,
          ),
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: paleta.borda),
      ],
    );
  }
}

class _Clausula extends StatelessWidget {
  const _Clausula({required this.clausula});
  final ClausulaLegal clausula;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            SizedBox(
              width: 26,
              child: Text(
                '${clausula.numero}',
                style: const TextStyle(
                  fontFamily: TemaApp.fonteMono,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: CoresApp.azulDart,
                ),
              ),
            ),
            Expanded(
              child: Text(
                clausula.titulo,
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: paleta.texto,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final paragrafo in clausula.paragrafos) ...[
                TextoRico(
                  paragrafo,
                  tamanho: 14,
                  alturaLinha: 1.5,
                  cor: paleta.textoSuave,
                ),
                const SizedBox(height: 9),
              ],
              for (final item in clausula.itens)
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: CoresApp.azulDart,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: TextoRico(
                          item,
                          tamanho: 14,
                          alturaLinha: 1.5,
                          cor: paleta.textoSuave,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
