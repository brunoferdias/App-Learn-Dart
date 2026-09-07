import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/idioma.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/visualizador_codigo.dart';
import '../../domain/entities/exercicio.dart';
import '../controllers/controlador_quiz.dart';
import '../widgets/cartao_pergunta.dart';
import '../widgets/opcao_resposta.dart';
import '../widgets/painel_explicacao.dart';

class PaginaQuiz extends StatefulWidget {
  const PaginaQuiz({super.key, this.licaoId, required this.titulo});

  final String? licaoId;
  final String titulo;

  @override
  State<PaginaQuiz> createState() => _PaginaQuizState();
}

class _PaginaQuizState extends State<PaginaQuiz> {
  late final ControladorQuiz _quiz;
  Idioma? _idiomaCarregado;

  @override
  void initState() {
    super.initState();
    _quiz = EscopoApp.de(context).criarControladorQuiz();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textos = context.textos;
    if (_idiomaCarregado == textos.idioma) return;
    _idiomaCarregado = textos.idioma;
    _quiz.carregar(textos, licaoId: widget.licaoId);
  }

  @override
  void dispose() {
    _quiz.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.titulo),
        previousPageTitle: textos.voltar,
      ),
      child: SafeArea(
        child: ListenableBuilder(
          listenable: _quiz,
          builder: (context, _) {
            if (_quiz.carregando) {
              return const Center(child: CupertinoActivityIndicator());
            }

            final erro = _quiz.erro;
            if (erro != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(erro, textAlign: TextAlign.center),
                ),
              );
            }

            if (_quiz.total == 0) {
              return Center(
                child: Text(
                  textos.quizSemExercicios,
                  style: TextStyle(color: paleta.textoSuave),
                ),
              );
            }

            if (_quiz.terminou) {
              return _TelaResultado(quiz: _quiz);
            }

            return _CorpoPergunta(quiz: _quiz);
          },
        ),
      ),
    );
  }
}

class _CorpoPergunta extends StatelessWidget {
  const _CorpoPergunta({required this.quiz});

  final ControladorQuiz quiz;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final exercicio = quiz.atual;

    if (exercicio == null) return const SizedBox.shrink();

    final escolha = quiz.escolha;
    final respondeu = escolha != null;
    final acertou = respondeu && exercicio.acertou(escolha);

    return Column(
      children: [
        _BarraProgresso(quiz: quiz),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              CartaoPergunta(exercicio: exercicio),
              const SizedBox(height: 18),

              for (final (i, alternativa)
                  in exercicio.alternativas(textos).indexed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OpcaoResposta(
                    texto: alternativa,
                    letra: String.fromCharCode(65 + i),
                    estado: _estadoDa(
                      indice: i,
                      escolha: escolha,
                      correta: exercicio.indiceCorreto,
                    ),
                    aoTocar: respondeu ? null : () => quiz.responder(i),
                  ),
                ),

              if (respondeu) ...[
                const SizedBox(height: 6),

                if (exercicio case ExercicioCompletar(:final opcoes)) ...[
                  _CodigoPreenchido(
                    exercicio: exercicio,
                    escolhido: opcoes[escolha],
                  ),
                  const SizedBox(height: 12),
                ],

                PainelExplicacao(
                  acertou: acertou,
                  explicacao: exercicio.explicacao,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(12),
                    onPressed: quiz.proximo,
                    child: Text(
                      quiz.ehUltimo
                          ? textos.quizVerResultado
                          : textos.quizProximaPergunta,
                    ),
                  ),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    textos.quizEscolhaAlternativa,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: paleta.textoSuave),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  EstadoOpcao _estadoDa({
    required int indice,
    required int? escolha,
    required int correta,
  }) {
    if (escolha == null) return EstadoOpcao.neutra;
    if (indice == escolha) {
      return indice == correta
          ? EstadoOpcao.escolhidaCerta
          : EstadoOpcao.escolhidaErrada;
    }
    if (indice == correta) return EstadoOpcao.reveladaCerta;
    return EstadoOpcao.neutra;
  }
}

class _CodigoPreenchido extends StatelessWidget {
  const _CodigoPreenchido({required this.exercicio, required this.escolhido});

  final ExercicioCompletar exercicio;

  final String escolhido;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final correto = exercicio.codigoPreenchido(exercicio.resposta);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.textos.quizEscolheu(escolhido).toUpperCase(),
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: paleta.textoSuave,
          ),
        ),
        const SizedBox(height: 7),
        VisualizadorCodigo(
          codigo: correto,
          compacto: true,
          corBorda: CoresApp.acerto.withValues(alpha: 0.4),
        ),
      ],
    );
  }
}

class _BarraProgresso extends StatelessWidget {
  const _BarraProgresso({required this.quiz});

  final ControladorQuiz quiz;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: paleta.superficie,
        border: Border(bottom: BorderSide(color: paleta.borda)),
      ),
      child: Row(
        children: [
          Text(
            context.textos.quizPosicao(quiz.indice + 1, quiz.total),
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
              color: paleta.textoSuave,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(height: 6, color: paleta.superficie2),
                  AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOut,
                    widthFactor:
                        ((quiz.indice + (quiz.respondeu ? 1 : 0)) / quiz.total)
                            .clamp(0.0, 1.0),
                    child: Container(height: 6, color: CoresApp.azulDart),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              const Icon(
                CupertinoIcons.checkmark_seal_fill,
                size: 13,
                color: CoresApp.acerto,
              ),
              const SizedBox(width: 4),
              Text(
                '${quiz.acertos}',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: CoresApp.acerto,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TelaResultado extends StatelessWidget {
  const _TelaResultado({required this.quiz});

  final ControladorQuiz quiz;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final percentual = ((quiz.acertos / quiz.total) * 100).round();

    final (String titulo, String frase) = switch (percentual) {
      100 => (
        textos.quizResultadoPerfeitoTitulo,
        textos.quizResultadoPerfeitoTexto,
      ),
      >= 70 => (textos.quizResultadoBomTitulo, textos.quizResultadoBomTexto),
      >= 40 => (
        textos.quizResultadoMedioTitulo,
        textos.quizResultadoMedioTexto,
      ),
      _ => (textos.quizResultadoBaixoTitulo, textos.quizResultadoBaixoTexto),
    };

    final cor = switch (percentual) {
      100 || >= 70 => CoresApp.acerto,
      >= 40 => CoresApp.atencao,
      _ => CoresApp.erro,
    };

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Cartao(
          padding: const EdgeInsets.all(26),
          child: Column(
            children: [
              _Anel(percentual: percentual, cor: cor),
              const SizedBox(height: 20),
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  color: paleta.texto,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                frase,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: paleta.textoSuave,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                textos.quizPlacar(quiz.acertos, quiz.total),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  color: paleta.texto,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                textos.quizAcertosPercentual(percentual),
                style: TextStyle(fontSize: 13, color: paleta.textoSuave),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(12),
                  onPressed: quiz.reiniciar,
                  child: Text(textos.tentarDeNovo),
                ),
              ),
              CupertinoButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(textos.voltar),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Anel extends StatelessWidget {
  const _Anel({required this.percentual, required this.cor});

  final int percentual;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return SizedBox(
      width: 96,
      height: 96,
      child: CustomPaint(
        painter: _PintorAnel(
          fracao: percentual / 100,
          cor: cor,
          trilho: paleta.textoSuave.withValues(alpha: 0.16),
        ),
        child: Center(
          child: Text(
            '$percentual%',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: paleta.texto,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ),
    );
  }
}

class _PintorAnel extends CustomPainter {
  const _PintorAnel({
    required this.fracao,
    required this.cor,
    required this.trilho,
  });

  final double fracao;
  final Color cor;
  final Color trilho;

  @override
  void paint(Canvas canvas, Size size) {
    const espessura = 7.0;
    final centro = Offset(size.width / 2, size.height / 2);
    final raio = (size.shortestSide - espessura) / 2;
    final caixa = Rect.fromCircle(center: centro, radius: raio);

    final pincel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = espessura
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(centro, raio, pincel..color = trilho);

    canvas.drawArc(
      caixa,
      -1.5707963,
      6.2831853 * fracao.clamp(0.0, 1.0),
      false,
      pincel..color = cor,
    );
  }

  @override
  bool shouldRepaint(_PintorAnel anterior) =>
      anterior.fracao != fracao || anterior.cor != cor;
}
