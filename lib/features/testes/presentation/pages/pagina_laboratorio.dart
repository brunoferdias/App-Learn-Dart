import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/idioma.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/texto_rico.dart';
import '../../../../core/widgets/visualizador_codigo.dart';
import '../controllers/controlador_laboratorio.dart';
import '../widgets/chip_codigo.dart';
import '../widgets/console_teste.dart';
import '../widgets/tela_simulada.dart';

class PaginaLaboratorio extends StatefulWidget {
  const PaginaLaboratorio({super.key});

  @override
  State<PaginaLaboratorio> createState() => _PaginaLaboratorioState();
}

class _PaginaLaboratorioState extends State<PaginaLaboratorio> {
  late final ControladorLaboratorio _controlador;
  Idioma? _idiomaCarregado;

  @override
  void initState() {
    super.initState();
    _controlador = EscopoApp.de(context).criarControladorLaboratorio();
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
      navigationBar: CupertinoNavigationBar(
        middle: Text(textos.labTitulo),
        previousPageTitle: textos.labPrevious,
      ),
      child: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: _controlador,
          builder: (context, _) {
            if (_controlador.carregando) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (_controlador.erro case final mensagem?) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    mensagem,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: paleta.textoSuave),
                  ),
                ),
              );
            }
            return _Corpo(controlador: _controlador);
          },
        ),
      ),
    );
  }
}

class _Corpo extends StatelessWidget {
  const _Corpo({required this.controlador});

  final ControladorLaboratorio controlador;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final cenario = controlador.cenario;
    final resultado = controlador.resultado;

    final alturaDaBarra = MediaQuery.paddingOf(context).top;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, alturaDaBarra + 16, 16, 40),
      children: [
        _SeletorDeCenarios(controlador: controlador),
        const SizedBox(height: 18),

        _CartaoDesafio(controlador: controlador),
        const SizedBox(height: 20),

        _Secao(
          numero: '1',
          titulo: textos.labTelaTitulo,
          descricao: textos.labTelaDescricao,
        ),
        const SizedBox(height: 10),
        TelaSimulada(
          raiz: cenario.arvoreEm(aposToque: controlador.comInteracao),
          destaques: {...?resultado?.caminhosEncontrados},
          corDestaque: resultado == null
              ? null
              : resultado.passou
              ? CoresApp.acerto
              : CoresApp.erro,
        ),
        if (cenario.temInteracao) ...[
          const SizedBox(height: 10),
          _BotaoInteracao(controlador: controlador),
        ],
        const SizedBox(height: 12),
        VisualizadorCodigo(
          codigo: cenario.codigoFonte,
          legenda: textos.labCodigoLegenda,
          compacto: true,
        ),
        const SizedBox(height: 22),

        _Secao(
          numero: '2',
          titulo: textos.labAsercaoTitulo,
          descricao: textos.labAsercaoDescricao,
        ),
        const SizedBox(height: 12),
        Text(
          textos.labFinder.toUpperCase(),
          style: _rotuloEstilo(paleta.textoSuave),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final f in cenario.finders)
              ChipCodigo(
                texto: f.codigo,
                selecionado: controlador.finder?.codigo == f.codigo,
                aoTocar: () => controlador.escolherFinder(f),
              ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: Text(
                textos.labMatcher.toUpperCase(),
                style: _rotuloEstilo(paleta.textoSuave),
              ),
            ),
            _ContadorN(controlador: controlador),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final m in controlador.matchers)
              ChipCodigo(
                texto: m.codigo,
                cor: CoresApp.dica,
                selecionado: controlador.matcher?.codigo == m.codigo,
                aoTocar: () => controlador.escolherMatcher(m),
              ),
          ],
        ),
        const SizedBox(height: 18),

        _LinhaExpect(codigo: controlador.linhaExpect),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            borderRadius: BorderRadius.circular(12),
            onPressed: controlador.podeRodar ? controlador.rodar : null,
            child: Text(textos.labRodarTeste),
          ),
        ),

        if (resultado != null) ...[
          const SizedBox(height: 20),
          _Secao(
            numero: '3',
            titulo: textos.labSaidaTitulo,
            descricao: textos.labSaidaDescricao,
          ),
          const SizedBox(height: 10),
          _Veredito(
            passou: resultado.passou,
            quantidade: resultado.quantidadeEncontrada,
          ),
          const SizedBox(height: 10),
          ConsoleTeste(linhas: resultado.saida),
        ],

        if (controlador.desafioAtualResolvido &&
            controlador.indice < controlador.cenarios.length - 1) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: CoresApp.acerto,
              borderRadius: BorderRadius.circular(12),
              onPressed: controlador.proximo,
              child: Text(
                textos.labProximoCenario,
                style: const TextStyle(color: CupertinoColors.white),
              ),
            ),
          ),
        ],
      ],
    );
  }

  static TextStyle _rotuloEstilo(Color cor) => TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.9,
    color: cor,
  );
}

class _SeletorDeCenarios extends StatelessWidget {
  const _SeletorDeCenarios({required this.controlador});

  final ControladorLaboratorio controlador;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (final (i, cenario) in controlador.cenarios.indexed) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(
                child: _ChipCenario(
                  key: Key('cenario-${i + 1}'),
                  numero: i + 1,
                  ativo: i == controlador.indice,
                  resolvido: controlador.resolveu(cenario.id),
                  aoTocar: () => controlador.irPara(i),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 14),
        Text(
          controlador.cenario.titulo,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            color: paleta.texto,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          controlador.cenario.resumo,
          style: TextStyle(
            fontSize: 14.5,
            height: 1.4,
            color: paleta.textoSuave,
          ),
        ),
      ],
    );
  }
}

class _ChipCenario extends StatelessWidget {
  const _ChipCenario({
    super.key,
    required this.numero,
    required this.ativo,
    required this.resolvido,
    required this.aoTocar,
  });

  final int numero;
  final bool ativo;
  final bool resolvido;
  final VoidCallback aoTocar;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final cor = resolvido ? CoresApp.acerto : CoresApp.azulDart;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: aoTocar,
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ativo ? cor.withValues(alpha: 0.15) : paleta.superficie,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ativo ? cor : paleta.borda,
            width: ativo ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (resolvido) ...[
              const Icon(
                CupertinoIcons.checkmark_alt,
                size: 13,
                color: CoresApp.acerto,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              '$numero',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ativo ? cor : paleta.textoSuave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartaoDesafio extends StatelessWidget {
  const _CartaoDesafio({required this.controlador});

  final ControladorLaboratorio controlador;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final desafio = controlador.cenario.desafio;
    final resolvido = controlador.desafioAtualResolvido;
    final cor = resolvido ? CoresApp.acerto : CoresApp.atencao;

    return Cartao(
      corFundo: cor.withValues(alpha: paleta.escuro ? 0.14 : 0.07),
      corBorda: cor.withValues(alpha: 0.28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                resolvido
                    ? CupertinoIcons.checkmark_seal_fill
                    : CupertinoIcons.flag_fill,
                size: 14,
                color: cor,
              ),
              const SizedBox(width: 6),
              Text(
                (resolvido
                        ? context.textos.labDesafioConcluido
                        : context.textos.labDesafio)
                    .toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.9,
                  color: cor,
                ),
              ),
              const Spacer(),
              Text(
                '${controlador.desafiosResolvidos}/'
                '${controlador.cenarios.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: paleta.textoSuave,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextoRico(desafio.enunciado, tamanho: 15),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              onPressed: controlador.alternarDica,
              child: Text(
                controlador.mostrandoDica
                    ? context.textos.labEsconderDica
                    : context.textos.labVerDica,
                style: const TextStyle(fontSize: 13.5, color: CoresApp.dica),
              ),
            ),
          ),
          if (controlador.mostrandoDica)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: TextoRico(
                desafio.dica,
                tamanho: 14,
                cor: paleta.textoSuave,
              ),
            ),
        ],
      ),
    );
  }
}

class _BotaoInteracao extends StatelessWidget {
  const _BotaoInteracao({required this.controlador});

  final ControladorLaboratorio controlador;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final tocado = controlador.comInteracao;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: paleta.superficie,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tocado ? CoresApp.acerto : paleta.borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controlador.cenario.acaoDeToque ?? '',
            style: TextStyle(
              fontFamily: TemaApp.fonteMono,
              fontSize: 11.5,
              height: 1.4,
              color: tocado ? CoresApp.acerto : paleta.textoSuave,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: tocado ? paleta.superficie2 : CoresApp.azulDart,
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: controlador.alternarInteracao,
              child: Text(
                tocado
                    ? context.textos.labDesfazerToque
                    : context.textos.labRodarInteracao,
                style: TextStyle(
                  fontSize: 14,
                  color: tocado ? paleta.texto : CupertinoColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContadorN extends StatelessWidget {
  const _ContadorN({required this.controlador});

  final ControladorLaboratorio controlador;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('n =', style: TextStyle(fontSize: 12, color: paleta.textoSuave)),
        const SizedBox(width: 6),
        _BotaoPasso(
          rotulo: '−',
          aoTocar: () => controlador.ajustarQuantidade(-1),
        ),
        SizedBox(
          width: 22,
          child: Text(
            '${controlador.quantidadeN}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: TemaApp.fonteMono,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: paleta.texto,
            ),
          ),
        ),
        _BotaoPasso(
          rotulo: '+',
          aoTocar: () => controlador.ajustarQuantidade(1),
        ),
      ],
    );
  }
}

class _BotaoPasso extends StatelessWidget {
  const _BotaoPasso({required this.rotulo, required this.aoTocar});

  final String rotulo;
  final VoidCallback aoTocar;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: aoTocar,
      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: paleta.superficie2,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: paleta.borda),
        ),
        child: Text(
          rotulo,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: paleta.texto,
          ),
        ),
      ),
    );
  }
}

class _LinhaExpect extends StatelessWidget {
  const _LinhaExpect({required this.codigo});

  final String codigo;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: paleta.fundoCodigo,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CoresApp.azulDart.withValues(alpha: 0.35)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Text(
          codigo,
          style: const TextStyle(
            fontFamily: TemaApp.fonteMono,
            fontSize: 13,
            color: CoresApp.synPadrao,
          ),
        ),
      ),
    );
  }
}

class _Veredito extends StatelessWidget {
  const _Veredito({required this.passou, required this.quantidade});

  final bool passou;
  final int quantidade;

  @override
  Widget build(BuildContext context) {
    final cor = passou ? CoresApp.acerto : CoresApp.erro;
    final textos = context.textos;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(
            passou
                ? CupertinoIcons.checkmark_circle_fill
                : CupertinoIcons.xmark_circle_fill,
            size: 18,
            color: cor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              passou
                  ? textos.labPassou(quantidade)
                  : textos.labFalhou(quantidade),
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: cor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  const _Secao({
    required this.numero,
    required this.titulo,
    required this.descricao,
  });

  final String numero;
  final String titulo;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CoresApp.azulDart.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                numero,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: CoresApp.azulDart,
                ),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                titulo,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  color: paleta.texto,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextoRico(descricao, tamanho: 14, cor: paleta.textoSuave),
      ],
    );
  }
}
