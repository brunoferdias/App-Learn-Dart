import 'idioma.dart';
import 'textos.dart';

class TextosEn extends Textos {
  const TextosEn();

  @override
  Idioma get idioma => Idioma.ingles;

  @override
  String get voltar => 'Back';
  @override
  String get cancelar => 'Cancel';
  @override
  String get salvar => 'Save';
  @override
  String get continuar => 'Continue';
  @override
  String get fechar => 'Close';
  @override
  String get pular => 'Skip';
  @override
  String get comecar => 'Start';
  @override
  String get proximo => 'Next';
  @override
  String get tentarDeNovo => 'Try again';
  @override
  String get carregando => 'Loading…';

  @override
  String get abaAprender => 'Learn';
  @override
  String get abaPraticar => 'Practice';
  @override
  String get abaEditor => 'Editor';
  @override
  String get abaSintaxe => 'Syntax';
  @override
  String get abaProgresso => 'Progress';

  @override
  String get avisoNaoOficialTitulo => 'Independent project';
  @override
  String get avisoNaoOficialCurto =>
      'Independent project. Not affiliated with Google.';
  @override
  String get avisoNaoOficialCompleto =>
      'This is an independent study project. It is **not an official Google '
      'product**, and it is not affiliated with, sponsored by, or endorsed by '
      'Google LLC. Dart, Flutter and their logos are trademarks of Google LLC, '
      'used here only to refer to the language and the framework. '
      'The official documentation lives at **dart.dev**.';

  @override
  String get splashSubtitulo => 'Dart and null safety, from scratch';

  @override
  String get boasVindasSaudacao => 'Hello';
  @override
  String get boasVindasTitulo => 'Welcome to Aprenda Dart';
  @override
  String get boasVindasTexto =>
      'Eleven lessons, 53 exercises graded on the spot, and a Dart editor that '
      'runs inside the app. All offline — no account, no ads.';
  @override
  String get boasVindasEscolhaIdioma => 'Language';
  @override
  String get boasVindasComecar => 'See how it works';
  @override
  String get boasVindasJaConheco => 'Go straight to the lessons';

  @override
  String get onbPasso1Titulo => 'Read, with the code beside it';
  @override
  String get onbPasso1Texto =>
      'Every lesson alternates between explanation and annotated example. The '
      'examples show their console output, so you can check the result before '
      'running anything.';
  @override
  String get onbPasso1Rodape => 'Tap any example to copy it.';

  @override
  String get onbPasso2Titulo => 'Answer, then see why';
  @override
  String get onbPasso2Texto =>
      'Every answer comes with an explanation. Try it: does this code compile?';
  @override
  String get onbPasso2Legenda => 'Sample exercise';
  @override
  String get onbPasso2Acerto => 'Correct';
  @override
  String get onbPasso2Erro => 'Not quite';
  @override
  String get onbPasso2Alternativa1 => 'It compiles fine';
  @override
  String get onbPasso2Alternativa2 => 'It does not compile';
  @override
  String get onbPasso2Explicacao =>
      '`name` is a `String?`, so it may be null — and `.length` does not exist '
      'on null. Dart rejects the code before it ever runs. Write `name?.length`, '
      'or check `if (name != null)` first, and it passes.';
  @override
  String get onbPasso2Convite => 'Tap an answer';
  @override
  String get onbPasso2Codigo => "String? name;\nprint(name.length);";

  @override
  String get onbPasso3Titulo => 'Write Dart right here';
  @override
  String get onbPasso3Texto =>
      'The app ships a Dart interpreter written in Dart. It reads your code, '
      'runs it, and explains errors by pointing at the line — no internet '
      'needed.';
  @override
  String get onbPasso3Legenda => 'Built-in editor';
  @override
  String get onbPasso3Saida => 'Hi, Dart\n3 items';
  @override
  String get onbPasso3Convite => 'Run';
  @override
  String get onbPasso3Codigo => r"""void main() {
  print('Hi, Dart');
  final items = [1, 2, 3];
  print('${items.length} items');
}""";

  @override
  String get onbPasso4Titulo => 'Set it up your way';
  @override
  String get onbPasso4Texto =>
      'Language and theme can be changed any time from the Progress tab.';
  @override
  String get onbPasso4Tema => 'Theme';
  @override
  String get onbPasso4Idioma => 'Language';

  @override
  String get onbPasso5Titulo => 'One thing before you start';
  @override
  String get onbPasso5Texto =>
      'An important note about what this app is — and what it is not.';
  @override
  String get onbPasso5Entrar => 'Got it, let me in';

  @override
  String passoDe(int atual, int total) => 'Step $atual of $total';

  @override
  String get licoesTitulo => 'Aprenda Dart';
  @override
  String get licoesPrevious => 'Lessons';
  @override
  String get licoesRetomarTitulo => 'Pick up where you left off';
  @override
  String get licoesComecarTitulo => 'Start with lesson 1';
  @override
  String get licoesSubtitulo =>
      'Read the lesson, study the annotated examples, finish with the exercises.';
  @override
  String licoesConcluidasDe(int feitas, int total) => '$feitas of $total done';
  @override
  String licaoNumero(int numero) =>
      'Lesson ${numero.toString().padLeft(2, '0')}';
  @override
  String minutos(int n) => '$n min';
  @override
  String minutosDeLeitura(int n) => '$n min read';
  @override
  String exemplos(int n) => n == 1 ? '1 example' : '$n examples';
  @override
  String get licaoConcluida => 'Done';
  @override
  String get licaoObjetivos => 'What you will learn';
  @override
  String get licaoTerminouTitulo => 'Finished reading?';
  @override
  String get licaoTerminouTexto =>
      'Answer this lesson\'s exercises to see what actually stuck.';
  @override
  String get licaoPraticar => 'Practice this lesson';
  @override
  String get licaoMarcarConcluida => 'Mark as done';

  @override
  String get blocoErrado => 'Wrong';
  @override
  String get blocoCerto => 'Right';
  @override
  String get blocoDica => 'Tip';
  @override
  String get blocoAtencao => 'Watch out';
  @override
  String get blocoSaidaConsole => 'Console output';
  @override
  String get blocoCopiar => 'copy';
  @override
  String get blocoCopiado => 'copied';
  @override
  String get blocoAbrirLaboratorio => 'Open the lab';

  @override
  String get praticarTitulo => 'Practice';
  @override
  String get praticarChamadaTitulo => 'Is this code right or wrong?';
  @override
  String praticarChamadaTexto(int total) =>
      '$total exercises in three formats: judge the code, multiple choice, and '
      'fill in the blank. Every answer comes with an explanation.';
  @override
  String get praticarTudo => 'Practice everything, shuffled';
  @override
  String get praticarDesafioGeral => 'Mixed challenge';
  @override
  String exerciciosContagem(int n) => n == 1 ? '1 exercise' : '$n exercises';

  @override
  String get quizSemExercicios => 'No exercises for this lesson yet.';
  @override
  String get quizEscolhaAlternativa => 'Pick an answer to see the explanation.';
  @override
  String get quizVerResultado => 'See result';
  @override
  String get quizProximaPergunta => 'Next question';
  @override
  String quizEscolheu(String opcao) =>
      'You picked "$opcao" · correct code below';
  @override
  String quizPosicao(int atual, int total) => '$atual of $total';
  @override
  String get quizAcertou => 'That\'s it';
  @override
  String get quizErrou => 'Not this time — here is why';
  @override
  String quizPlacar(int acertos, int total) => '$acertos / $total';
  @override
  String quizAcertosPercentual(int percentual) => 'correct ($percentual%)';
  @override
  String get quizResultadoPerfeitoTitulo => 'Full marks';
  @override
  String get quizResultadoPerfeitoTexto =>
      'Every one right. Null safety does not catch you out.';
  @override
  String get quizResultadoBomTitulo => 'Solid ground';
  @override
  String get quizResultadoBomTexto =>
      'Review the misses and move on to the next one.';
  @override
  String get quizResultadoMedioTitulo => 'Almost there';
  @override
  String get quizResultadoMedioTexto =>
      'A second read of the lesson will close the gaps.';
  @override
  String get quizResultadoBaixoTitulo => 'No rush';
  @override
  String get quizResultadoBaixoTexto =>
      'Go back to the lesson slowly. Everyone starts here.';

  @override
  String get formatoCertoOuErrado => 'Right or wrong?';
  @override
  String get formatoMultiplaEscolha => 'Multiple choice';
  @override
  String get formatoCompletar => 'Fill in the blank';
  @override
  String get enunciadoPadraoCertoOuErrado =>
      'Does this code compile and do what it should?';
  @override
  String get enunciadoPadraoCompletar => 'Fill in the blank so the code works:';
  @override
  String get alternativaEstaCerto => 'It is right';
  @override
  String get alternativaEstaErrado => 'It is wrong';
  @override
  String get legendaLacuna => 'The three orange underscores mark the blank.';

  @override
  String get editorTitulo => 'Editor';
  @override
  String get editorChamadaTitulo => 'Write and run Dart right here';
  @override
  String get editorChamadaTexto =>
      'The editor opens in landscape, code on one side and console on the '
      'other. It starts with `void main()` already filled in, auto-indents, '
      'closes brackets and quotes for you, and explains errors with a hint on '
      'how to fix them.';
  @override
  String get editorAbrir => 'Open the editor';
  @override
  String get editorComecePorExemplo => 'Start from an example';
  @override
  String get editorComoFunciona => 'How this works';
  @override
  String get editorComoFuncionaTexto =>
      'A compiled Flutter app **cannot compile real Dart** at runtime. So this '
      'editor ships a **small interpreter written in Dart**, inside the app '
      'itself: it reads your code, builds the syntax tree and executes it — '
      'all offline.';
  @override
  String get editorFunciona => 'Supported';
  @override
  List<String> get editorFuncionaItens => const [
    'Variables, types and null safety (?, ?., ??, ??=, !, late)',
    'Functions: arrow, named, optional, anonymous, closures',
    'if, for, while, do-while, switch, break/continue',
    'List, Set, Map with map/where/fold, spread and collection if/for',
    'Classes with constructors, methods, getters and toString',
    'try / catch / finally and throw',
    'Several files talking to each other',
  ];
  @override
  String get editorAindaNao => 'Not yet';
  @override
  List<String> get editorAindaNaoItens => const [
    'async / await and Streams (they need an event loop)',
    'Inheritance, mixins and extensions',
    'Records, sealed classes and pattern matching',
    'Importing packages from pub.dev',
  ];
  @override
  String get editorRodape =>
      'For the full Dart language, use `dartpad.dev` in a browser. The '
      'interpreter source lives in `features/playground/data/interpretador/` — '
      'four stages: lexer, parser, AST and interpreter.';
  @override
  String abasContagem(int n) => n == 1 ? '1 tab' : '$n tabs';

  @override
  String get editorSair => 'Exit';
  @override
  String get editorNome => 'Dart mini-editor';
  @override
  String get editorExemplos => 'Examples';
  @override
  String get editorRodar => 'Run';
  @override
  String get editorCarregarExemplo => 'Load example';
  @override
  String get editorCarregarExemploAviso =>
      'This replaces whatever is in the editor right now.';
  @override
  String get editorRenomearArquivo => 'Rename file';
  @override
  String get editorNomePlaceholder => 'name.dart';
  @override
  String get editorLimpar => 'clear';
  @override
  String get editorConsoleVazio => 'Press Run to execute\nyour code';
  @override
  String editorEncerrouSemErros(int milissegundos) =>
      'Program finished with no errors ($milissegundos ms)';
  @override
  String editorLinha(int linha) => 'line $linha';

  @override
  String get labTitulo => 'Testing lab';
  @override
  String get labPrevious => 'Lesson';
  @override
  String get labTelaTitulo => 'The screen the test builds';
  @override
  String get labTelaDescricao =>
      'This is how `flutter_test` sees it: a tree of nodes. The grey boxes are '
      'your widgets.';
  @override
  String get labCodigoLegenda => 'The code behind that screen';
  @override
  String get labAsercaoTitulo => 'Build the assertion';
  @override
  String get labAsercaoDescricao =>
      'Choose **what to look for** (finder) and **how many you expect** '
      '(matcher). Tap again to clear.';
  @override
  String get labFinder => 'Finder — what to look for';
  @override
  String get labMatcher => 'Matcher — how many you expect';
  @override
  String get labRodarTeste => 'Run test';
  @override
  String get labSaidaTitulo => 'The test output';
  @override
  String get labSaidaDescricao =>
      'The very same lines you get in your terminal.';
  @override
  String get labProximoCenario => 'Next scenario';
  @override
  String get labDesafio => 'Challenge';
  @override
  String get labDesafioConcluido => 'Challenge solved';
  @override
  String get labVerDica => 'Show a hint';
  @override
  String get labEsconderDica => 'Hide the hint';
  @override
  String get labRodarInteracao => 'Run this interaction';
  @override
  String get labDesfazerToque => 'Undo the tap';
  @override
  String labPassou(int quantidade) => quantidade == 1
      ? 'Passed — 1 widget found'
      : 'Passed — $quantidade widgets found';
  @override
  String labFalhou(int quantidade) => quantidade == 1
      ? 'Failed — 1 widget found'
      : 'Failed — $quantidade widgets found';

  @override
  String get glossarioTitulo => 'Syntax';
  @override
  String get glossarioBuscaPlaceholder => 'Search: late, ??, mixin, await…';
  @override
  String get glossarioTudo => 'All';
  @override
  String glossarioNadaEncontrado(String busca) => 'Nothing found for "$busca".';

  @override
  String get perfilTitulo => 'Your progress';
  @override
  String get perfilMetricaLicoes => 'lessons\ncompleted';
  @override
  String get perfilMetricaAcertos => 'correct\nanswers';
  @override
  String get perfilMetricaAproveitamento => 'accuracy\nrate';
  @override
  String get perfilAparencia => 'Appearance';
  @override
  String get perfilIdioma => 'Language';
  @override
  String get perfilIdiomaNota =>
      'Changes the interface and the content of lessons, exercises and glossary.';
  @override
  String get perfilArquiteturaTitulo => 'How this app is built';
  @override
  String get perfilArquiteturaTexto =>
      'The source code is study material too: every file carries comments '
      'explaining the Dart feature it uses. The layout follows **Clean '
      'Architecture**, three layers per feature.';
  @override
  String get perfilCamadaDomain =>
      'Pure Dart, **no Flutter imports**. Business rules that outlive any '
      'change of interface.';
  @override
  String get perfilCamadaData =>
      'Knows WHERE the data comes from. Swapping memory for an API only '
      'touches here.';
  @override
  String get perfilCamadaPresentation =>
      'Screens and controllers. Knows only the domain — never the database.';
  @override
  String get perfilEstudarTitulo => 'To keep studying';
  @override
  String get perfilEstudarTexto =>
      '• `dart.dev/language` — the official language docs, short and direct.\n'
      '• `dartpad.dev` — online editor: paste the examples from this app and '
      'try changing things.\n'
      '• `dart.dev/null-safety` — the complete null safety guide.';
  @override
  String get perfilSobreTitulo => 'About this app';
  @override
  String get perfilRevisarOnboarding => 'Replay the intro';
  @override
  String get perfilRodape => 'Built with Flutter and Dart';

  @override
  String get temaSistema => 'System';
  @override
  String get temaSistemaDescricao => 'Follows your device setting';
  @override
  String get temaClaro => 'Light';
  @override
  String get temaClaroDescricao => 'Always the light theme';
  @override
  String get temaEscuro => 'Dark';
  @override
  String get temaEscuroDescricao => 'Always the dark theme';

  @override
  String get nivelIniciante => 'Beginner';
  @override
  String get nivelIntermediario => 'Intermediate';
  @override
  String get nivelAvancado => 'Advanced';

  @override
  String get categoriaSintaxe => 'Syntax';
  @override
  String get categoriaNullSafety => 'Null safety';
  @override
  String get categoriaFuncoes => 'Functions';
  @override
  String get categoriaColecoes => 'Collections';
  @override
  String get categoriaClasses => 'Classes';
  @override
  String get categoriaAssincrono => 'Async';

  @override
  String get diagErroSintaxe => 'Syntax error';
  @override
  String get diagErroExecucao => 'Runtime error';
  @override
  String get diagSemMain => 'No file has a main() function.';
  @override
  String get diagSemMainDica =>
      'Every Dart program starts at: void main() { ... }';
  @override
  String diagAbaInexistente(String nome) => 'There is no tab called "$nome".';
  @override
  String diagAbasDisponiveis(String nomes) => 'Available tabs: $nomes.';
  @override
  String diagExcecaoNaoTratada(String valor) => 'Uncaught exception: $valor';
  @override
  String get diagExcecaoDica =>
      'Wrap the call in try { ... } catch (e) { ... }.';
  @override
  String get diagRecursaoInfinita =>
      'Infinite recursion: the function calls itself without stopping.';
  @override
  String get diagRecursaoDica =>
      'Every recursive function needs a stopping case.';

  @override
  String erroLicaoNaoEncontrada(String id) => 'Lesson "$id" not found.';

  @override
  String erroCarregarLicoes(Object e) => 'Could not load the lessons: $e';
  @override
  String erroAbrirLicao(Object e) => 'Could not open the lesson: $e';
  @override
  String erroCarregarExercicios(Object e) => 'Could not load the exercises: $e';
  @override
  String erroCarregarGlossario(Object e) => 'Could not load the glossary: $e';
  @override
  String erroCarregarCenarios(Object e) => 'Could not load the scenarios: $e';
  @override
  String erroLerProgresso(Object e) => 'Could not read your progress: $e';
  @override
  String erroSalvarProgresso(Object e) => 'Could not save your progress: $e';
}
