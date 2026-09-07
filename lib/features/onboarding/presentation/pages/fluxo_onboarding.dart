import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/modo_tema.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/texto_rico.dart';
import '../../../../core/widgets/visualizador_codigo.dart';
import '../widgets/aviso_nao_oficial.dart';
import '../widgets/seletor_idioma.dart';

class FluxoOnboarding extends StatefulWidget {
  const FluxoOnboarding({super.key, required this.aoConcluir});

  final VoidCallback aoConcluir;

  @override
  State<FluxoOnboarding> createState() => _FluxoOnboardingState();
}

class _FluxoOnboardingState extends State<FluxoOnboarding> {
  static const int _totalPassos = 5;

  final PageController _paginas = PageController();
  int _passo = 0;

  @override
  void dispose() {
    _paginas.dispose();
    super.dispose();
  }

  void _avancar() {
    if (_passo >= _totalPassos - 1) {
      widget.aoConcluir();
      return;
    }
    _paginas.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final ultimo = _passo == _totalPassos - 1;

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 12, 4),
              child: Row(
                children: [
                  _Pontos(atual: _passo, total: _totalPassos),
                  const Spacer(),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    onPressed: widget.aoConcluir,
                    child: Text(
                      textos.pular,
                      style: TextStyle(fontSize: 15, color: paleta.textoSuave),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _paginas,
                onPageChanged: (i) => setState(() => _passo = i),
                children: const [
                  _PassoLicoes(),
                  _PassoExercicio(),
                  _PassoEditor(),
                  _PassoPreferencias(),
                  _PassoAviso(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Column(
                children: [
                  Text(
                    textos.passoDe(_passo + 1, _totalPassos),
                    style: TextStyle(
                      fontSize: 12,
                      color: paleta.textoSuave.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      borderRadius: BorderRadius.circular(12),
                      onPressed: _avancar,
                      child: Text(
                        ultimo ? textos.onbPasso5Entrar : textos.continuar,
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

class _Passo extends StatelessWidget {
  const _Passo({
    required this.titulo,
    required this.texto,
    required this.demonstracao,
    this.rodape,
  });

  final String titulo;
  final String texto;
  final Widget demonstracao;
  final String? rodape;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      children: [
        Text(
          titulo,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.7,
            height: 1.15,
            color: paleta.texto,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          texto,
          style: TextStyle(
            fontSize: 15.5,
            height: 1.5,
            letterSpacing: -0.1,
            color: paleta.textoSuave,
          ),
        ),
        const SizedBox(height: 22),
        demonstracao,
        if (rodape case final r?) ...[
          const SizedBox(height: 14),
          Text(
            r,
            style: TextStyle(
              fontSize: 13,
              color: paleta.textoSuave.withValues(alpha: 0.85),
            ),
          ),
        ],
      ],
    );
  }
}

class _Pontos extends StatelessWidget {
  const _Pontos({required this.atual, required this.total});

  final int atual;
  final int total;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Row(
      children: [
        for (var i = 0; i < total; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOut,
            margin: const EdgeInsets.only(right: 5),
            width: i == atual ? 20 : 7,
            height: 4,
            decoration: BoxDecoration(
              color: i == atual
                  ? CoresApp.azulDart
                  : paleta.textoSuave.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}

class _PassoLicoes extends StatelessWidget {
  const _PassoLicoes();

  @override
  Widget build(BuildContext context) {
    final textos = context.textos;

    return _Passo(
      titulo: textos.onbPasso1Titulo,
      texto: textos.onbPasso1Texto,
      rodape: textos.onbPasso1Rodape,
      demonstracao: VisualizadorCodigo(
        codigo: textos.onbPasso3Codigo,
        saida: textos.onbPasso3Saida,
      ),
    );
  }
}

class _PassoExercicio extends StatefulWidget {
  const _PassoExercicio();

  @override
  State<_PassoExercicio> createState() => _PassoExercicioState();
}

class _PassoExercicioState extends State<_PassoExercicio> {
  int? _escolha;

  static const int _correta = 1;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final escolha = _escolha;
    final acertou = escolha == _correta;

    return _Passo(
      titulo: textos.onbPasso2Titulo,
      texto: textos.onbPasso2Texto,
      demonstracao: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisualizadorCodigo(
            codigo: textos.onbPasso2Codigo,
            compacto: true,
            legenda: textos.onbPasso2Legenda,
          ),
          const SizedBox(height: 14),

          for (final (i, rotulo) in [
            textos.onbPasso2Alternativa1,
            textos.onbPasso2Alternativa2,
          ].indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: _Alternativa(
                texto: rotulo,
                estado: switch ((escolha, i)) {
                  (null, _) => _EstadoAlt.neutra,
                  (_, _) when i == _correta => _EstadoAlt.certa,
                  (final e, _) when e == i => _EstadoAlt.errada,
                  _ => _EstadoAlt.neutra,
                },
                aoTocar: escolha == null
                    ? () => setState(() => _escolha = i)
                    : null,
              ),
            ),

          const SizedBox(height: 4),
          if (escolha == null)
            Text(
              textos.onbPasso2Convite,
              style: TextStyle(fontSize: 13, color: paleta.textoSuave),
            )
          else
            _Explicacao(
              acertou: acertou,
              titulo: acertou ? textos.onbPasso2Acerto : textos.onbPasso2Erro,
              texto: textos.onbPasso2Explicacao,
            ),
        ],
      ),
    );
  }
}

enum _EstadoAlt { neutra, certa, errada }

class _Alternativa extends StatelessWidget {
  const _Alternativa({
    required this.texto,
    required this.estado,
    required this.aoTocar,
  });

  final String texto;
  final _EstadoAlt estado;
  final VoidCallback? aoTocar;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    final (cor, icone) = switch (estado) {
      _EstadoAlt.neutra => (paleta.borda, null),
      _EstadoAlt.certa => (
        CoresApp.acerto,
        CupertinoIcons.checkmark_circle_fill,
      ),
      _EstadoAlt.errada => (CoresApp.erro, CupertinoIcons.xmark_circle_fill),
    };
    final destacada = estado != _EstadoAlt.neutra;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: aoTocar,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: destacada ? cor.withValues(alpha: 0.10) : paleta.superficie,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: destacada ? cor : paleta.borda,
            width: destacada ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                texto,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.35,
                  fontWeight: destacada ? FontWeight.w600 : FontWeight.w400,
                  color: paleta.texto,
                ),
              ),
            ),
            if (icone case final i?) Icon(i, size: 19, color: cor),
          ],
        ),
      ),
    );
  }
}

class _Explicacao extends StatelessWidget {
  const _Explicacao({
    required this.acertou,
    required this.titulo,
    required this.texto,
  });

  final bool acertou;
  final String titulo;
  final String texto;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final cor = acertou ? CoresApp.acerto : CoresApp.atencao;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: cor,
            ),
          ),
          const SizedBox(height: 7),
          TextoRico(texto, tamanho: 14, cor: paleta.texto),
        ],
      ),
    );
  }
}

class _PassoEditor extends StatefulWidget {
  const _PassoEditor();

  @override
  State<_PassoEditor> createState() => _PassoEditorState();
}

class _PassoEditorState extends State<_PassoEditor> {
  bool _rodou = false;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return _Passo(
      titulo: textos.onbPasso3Titulo,
      texto: textos.onbPasso3Texto,
      demonstracao: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisualizadorCodigo(
            codigo: textos.onbPasso3Codigo,
            legenda: textos.onbPasso3Legenda,
            saida: _rodou ? textos.onbPasso3Saida : null,
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: _rodou ? paleta.superficie2 : CoresApp.acerto,
              borderRadius: BorderRadius.circular(12),
              onPressed: () => setState(() => _rodou = !_rodou),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _rodou
                        ? CupertinoIcons.arrow_counterclockwise
                        : CupertinoIcons.play_fill,
                    size: 15,
                    color: _rodou ? paleta.texto : CupertinoColors.white,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    _rodou ? textos.tentarDeNovo : textos.onbPasso3Convite,
                    style: TextStyle(
                      fontSize: 15,
                      color: _rodou ? paleta.texto : CupertinoColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PassoPreferencias extends StatelessWidget {
  const _PassoPreferencias();

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final injecao = EscopoApp.de(context);

    return _Passo(
      titulo: textos.onbPasso4Titulo,
      texto: textos.onbPasso4Texto,
      demonstracao: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Rotulo(textos.onbPasso4Idioma),
          const SizedBox(height: 10),
          SeletorIdioma(controlador: injecao.controladorIdioma),
          const SizedBox(height: 24),
          _Rotulo(textos.onbPasso4Tema),
          const SizedBox(height: 10),
          ListenableBuilder(
            listenable: injecao.controladorTema,
            builder: (context, _) {
              final tema = injecao.controladorTema;
              return Column(
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
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              m.rotulo(textos),
                              style: const TextStyle(fontSize: 13.5),
                            ),
                          ),
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tema.modo.descricao(textos),
                    style: TextStyle(fontSize: 13.5, color: paleta.textoSuave),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Rotulo extends StatelessWidget {
  const _Rotulo(this.texto);
  final String texto;

  @override
  Widget build(BuildContext context) => Text(
    texto.toUpperCase(),
    style: TextStyle(
      fontSize: 10.5,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      color: context.paleta.textoSuave,
    ),
  );
}

class _PassoAviso extends StatelessWidget {
  const _PassoAviso();

  @override
  Widget build(BuildContext context) {
    final textos = context.textos;

    return _Passo(
      titulo: textos.onbPasso5Titulo,
      texto: textos.onbPasso5Texto,
      demonstracao: const AvisoNaoOficial(),
    );
  }
}
