import 'idioma.dart';
import 'textos_en.dart';
import 'textos_pt.dart';

abstract class Textos {
  const Textos();

  static Textos de(Idioma idioma) => switch (idioma) {
    Idioma.portugues => const TextosPt(),
    Idioma.ingles => const TextosEn(),
  };

  Idioma get idioma;

  String get nomeApp;

  String get voltar;
  String get cancelar;
  String get salvar;
  String get continuar;
  String get fechar;
  String get pular;
  String get comecar;
  String get proximo;
  String get tentarDeNovo;
  String get carregando;

  String get abaAprender;
  String get abaPraticar;
  String get abaEditor;
  String get abaSintaxe;
  String get abaProgresso;

  String get avisoNaoOficialTitulo;
  String get avisoNaoOficialCurto;
  String get avisoNaoOficialCompleto;

  String get splashSubtitulo;

  String get boasVindasSaudacao;
  String get boasVindasTitulo;
  String get boasVindasTexto;
  String get boasVindasEscolhaIdioma;
  String get boasVindasComecar;
  String get boasVindasJaConheco;

  String get onbPasso1Titulo;
  String get onbPasso1Texto;
  String get onbPasso1Rodape;

  String get onbPasso2Titulo;
  String get onbPasso2Texto;
  String get onbPasso2Legenda;
  String get onbPasso2Acerto;
  String get onbPasso2Erro;
  String get onbPasso2Alternativa1;
  String get onbPasso2Alternativa2;
  String get onbPasso2Explicacao;
  String get onbPasso2Convite;
  String get onbPasso2Codigo;

  String get onbPasso3Titulo;
  String get onbPasso3Texto;
  String get onbPasso3Legenda;
  String get onbPasso3Saida;
  String get onbPasso3Convite;
  String get onbPasso3Codigo;

  String get onbPasso4Titulo;
  String get onbPasso4Texto;
  String get onbPasso4Tema;
  String get onbPasso4Idioma;

  String get onbPasso5Titulo;
  String get onbPasso5Texto;
  String get onbPasso5Entrar;

  String passoDe(int atual, int total);

  String get licoesTitulo;
  String get licoesPrevious;
  String get licoesRetomarTitulo;
  String get licoesComecarTitulo;
  String get licoesSubtitulo;
  String licoesConcluidasDe(int feitas, int total);
  String licaoNumero(int numero);
  String minutos(int n);
  String minutosDeLeitura(int n);
  String exemplos(int n);
  String get licaoConcluida;
  String get licaoObjetivos;
  String get licaoTerminouTitulo;
  String get licaoTerminouTexto;
  String get licaoPraticar;
  String get licaoMarcarConcluida;

  String get blocoErrado;
  String get blocoCerto;
  String get blocoDica;
  String get blocoAtencao;
  String get blocoSaidaConsole;
  String get blocoCopiar;
  String get blocoCopiado;
  String get blocoAbrirLaboratorio;

  String get praticarTitulo;
  String get praticarChamadaTitulo;
  String praticarChamadaTexto(int total);
  String get praticarTudo;
  String get praticarDesafioGeral;
  String exerciciosContagem(int n);

  String get quizSemExercicios;
  String get quizEscolhaAlternativa;
  String get quizVerResultado;
  String get quizProximaPergunta;
  String quizEscolheu(String opcao);
  String quizPosicao(int atual, int total);
  String get quizAcertou;
  String get quizErrou;
  String quizPlacar(int acertos, int total);
  String quizAcertosPercentual(int percentual);
  String get quizResultadoPerfeitoTitulo;
  String get quizResultadoPerfeitoTexto;
  String get quizResultadoBomTitulo;
  String get quizResultadoBomTexto;
  String get quizResultadoMedioTitulo;
  String get quizResultadoMedioTexto;
  String get quizResultadoBaixoTitulo;
  String get quizResultadoBaixoTexto;

  String get formatoCertoOuErrado;
  String get formatoMultiplaEscolha;
  String get formatoCompletar;
  String get enunciadoPadraoCertoOuErrado;
  String get enunciadoPadraoCompletar;
  String get alternativaEstaCerto;
  String get alternativaEstaErrado;
  String get legendaLacuna;

  String get editorTitulo;
  String get editorChamadaTitulo;
  String get editorChamadaTexto;
  String get editorAbrir;
  String get editorComecePorExemplo;
  String get editorComoFunciona;
  String get editorComoFuncionaTexto;
  String get editorFunciona;
  List<String> get editorFuncionaItens;
  String get editorAindaNao;
  List<String> get editorAindaNaoItens;
  String get editorRodape;
  String abasContagem(int n);

  String get editorSair;
  String get editorNome;
  String get editorExemplos;
  String get editorRodar;
  String get editorCarregarExemplo;
  String get editorCarregarExemploAviso;
  String get editorRenomearArquivo;
  String get editorNomePlaceholder;
  String get editorLimpar;
  String get editorConsoleVazio;
  String editorEncerrouSemErros(int milissegundos);
  String editorLinha(int linha);

  String get labTitulo;
  String get labPrevious;
  String get labTelaTitulo;
  String get labTelaDescricao;
  String get labCodigoLegenda;
  String get labAsercaoTitulo;
  String get labAsercaoDescricao;
  String get labFinder;
  String get labMatcher;
  String get labRodarTeste;
  String get labSaidaTitulo;
  String get labSaidaDescricao;
  String get labProximoCenario;
  String get labDesafio;
  String get labDesafioConcluido;
  String get labVerDica;
  String get labEsconderDica;
  String get labRodarInteracao;
  String get labDesfazerToque;
  String labPassou(int quantidade);
  String labFalhou(int quantidade);

  String get glossarioTitulo;
  String get glossarioBuscaPlaceholder;
  String get glossarioTudo;
  String glossarioNadaEncontrado(String busca);

  String get perfilTitulo;
  String get perfilMetricaLicoes;
  String get perfilMetricaAcertos;
  String get perfilMetricaAproveitamento;
  String get perfilAparencia;
  String get perfilIdioma;
  String get perfilIdiomaNota;
  String get perfilArquiteturaTitulo;
  String get perfilArquiteturaTexto;
  String get perfilCamadaDomain;
  String get perfilCamadaData;
  String get perfilCamadaPresentation;
  String get perfilEstudarTitulo;
  String get perfilEstudarTexto;
  String get perfilSobreTitulo;
  String get perfilRevisarOnboarding;
  String get perfilRodape;

  String get avaliarTitulo;
  String get avaliarTexto;
  String get avaliarBotao;
  String get avaliarObrigadoTitulo;
  String get avaliarObrigadoTexto;
  String get avaliarBotaoDeNovo;

  String get temaSistema;
  String get temaSistemaDescricao;
  String get temaClaro;
  String get temaClaroDescricao;
  String get temaEscuro;
  String get temaEscuroDescricao;

  String get nivelIniciante;
  String get nivelIntermediario;
  String get nivelAvancado;

  String get categoriaSintaxe;
  String get categoriaNullSafety;
  String get categoriaFuncoes;
  String get categoriaColecoes;
  String get categoriaClasses;
  String get categoriaAssincrono;

  String get diagErroSintaxe;
  String get diagErroExecucao;
  String get diagSemMain;
  String get diagSemMainDica;
  String diagAbaInexistente(String nome);
  String diagAbasDisponiveis(String nomes);
  String diagExcecaoNaoTratada(String valor);
  String get diagExcecaoDica;
  String get diagRecursaoInfinita;
  String get diagRecursaoDica;

  String erroLicaoNaoEncontrada(String id);

  String erroCarregarLicoes(Object e);
  String erroAbrirLicao(Object e);
  String erroCarregarExercicios(Object e);
  String erroCarregarGlossario(Object e);
  String erroCarregarCenarios(Object e);
  String erroLerProgresso(Object e);
  String erroSalvarProgresso(Object e);
}
