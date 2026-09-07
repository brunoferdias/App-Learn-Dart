import 'idioma.dart';
import 'textos.dart';

class TextosPt extends Textos {
  const TextosPt();

  @override
  Idioma get idioma => Idioma.portugues;

  @override
  String get voltar => 'Voltar';
  @override
  String get cancelar => 'Cancelar';
  @override
  String get salvar => 'Salvar';
  @override
  String get continuar => 'Continuar';
  @override
  String get fechar => 'Fechar';
  @override
  String get pular => 'Pular';
  @override
  String get comecar => 'Começar';
  @override
  String get proximo => 'Próximo';
  @override
  String get tentarDeNovo => 'Tentar de novo';
  @override
  String get carregando => 'Carregando…';

  @override
  String get abaAprender => 'Aprender';
  @override
  String get abaPraticar => 'Praticar';
  @override
  String get abaEditor => 'Editor';
  @override
  String get abaSintaxe => 'Sintaxe';
  @override
  String get abaProgresso => 'Progresso';

  @override
  String get avisoNaoOficialTitulo => 'Projeto independente';
  @override
  String get avisoNaoOficialCurto =>
      'Projeto independente. Sem vínculo com o Google.';
  @override
  String get avisoNaoOficialCompleto =>
      'Este é um projeto de estudo independente. Ele **não é um produto '
      'oficial do Google**, e não tem vínculo, patrocínio nem aprovação do '
      'Google LLC. Dart, Flutter e seus logotipos são marcas do Google LLC, '
      'usadas aqui apenas para se referir à linguagem e ao framework. '
      'A documentação oficial fica em **dart.dev**.';

  @override
  String get splashSubtitulo => 'Dart e null safety, do começo';

  @override
  String get boasVindasSaudacao => 'Olá';
  @override
  String get boasVindasTitulo => 'Bem-vindo ao Aprenda Dart';
  @override
  String get boasVindasTexto =>
      'Onze lições, 53 exercícios corrigidos na hora e um editor Dart que roda '
      'dentro do app. Tudo offline, sem conta e sem anúncio.';
  @override
  String get boasVindasEscolhaIdioma => 'Idioma';
  @override
  String get boasVindasComecar => 'Ver como funciona';
  @override
  String get boasVindasJaConheco => 'Ir direto para as lições';

  @override
  String get onbPasso1Titulo => 'Leia, com o código do lado';
  @override
  String get onbPasso1Texto =>
      'Cada lição alterna explicação e exemplo comentado. Os exemplos mostram a '
      'saída do console, então você confere o resultado antes de rodar.';
  @override
  String get onbPasso1Rodape => 'Toque em qualquer exemplo para copiá-lo.';

  @override
  String get onbPasso2Titulo => 'Responda e entenda o porquê';
  @override
  String get onbPasso2Texto =>
      'A correção vem com explicação. Experimente: este código compila?';
  @override
  String get onbPasso2Legenda => 'Exercício de demonstração';
  @override
  String get onbPasso2Acerto => 'Correto';
  @override
  String get onbPasso2Erro => 'Não é bem isso';
  @override
  String get onbPasso2Alternativa1 => 'Compila normalmente';
  @override
  String get onbPasso2Alternativa2 => 'Não compila';
  @override
  String get onbPasso2Explicacao =>
      '`nome` é `String?`, ou seja, pode ser nulo — e `.length` não existe em '
      'nulo. O Dart recusa o código antes de rodar. Com `nome?.length` ou '
      'depois de checar `if (nome != null)`, passa.';
  @override
  String get onbPasso2Convite => 'Toque em uma alternativa';
  @override
  String get onbPasso2Codigo => "String? nome;\nprint(nome.length);";

  @override
  String get onbPasso3Titulo => 'Escreva Dart aqui dentro';
  @override
  String get onbPasso3Texto =>
      'O app traz um interpretador de Dart escrito em Dart. Ele lê seu código, '
      'executa e explica o erro apontando a linha — sem internet.';
  @override
  String get onbPasso3Legenda => 'Editor embutido';
  @override
  String get onbPasso3Saida => 'Oi, Dart\n3 itens';
  @override
  String get onbPasso3Convite => 'Rodar';
  @override
  String get onbPasso3Codigo => r"""void main() {
  print('Oi, Dart');
  final itens = [1, 2, 3];
  print('${itens.length} itens');
}""";

  @override
  String get onbPasso4Titulo => 'Do seu jeito';
  @override
  String get onbPasso4Texto =>
      'Idioma e tema mudam a qualquer momento na aba Progresso.';
  @override
  String get onbPasso4Tema => 'Tema';
  @override
  String get onbPasso4Idioma => 'Idioma';

  @override
  String get onbPasso5Titulo => 'Antes de começar';
  @override
  String get onbPasso5Texto =>
      'Uma observação importante sobre o que este app é — e o que ele não é.';
  @override
  String get onbPasso5Entrar => 'Entendi, vamos lá';

  @override
  String passoDe(int atual, int total) => 'Passo $atual de $total';

  @override
  String get licoesTitulo => 'Aprenda Dart';
  @override
  String get licoesPrevious => 'Lições';
  @override
  String get licoesRetomarTitulo => 'Continue de onde parou';
  @override
  String get licoesComecarTitulo => 'Comece pela lição 1';
  @override
  String get licoesSubtitulo =>
      'Leia a lição, estude os exemplos comentados e feche com os exercícios.';
  @override
  String licoesConcluidasDe(int feitas, int total) =>
      '$feitas de $total concluídas';
  @override
  String licaoNumero(int numero) =>
      'Lição ${numero.toString().padLeft(2, '0')}';
  @override
  String minutos(int n) => '$n min';
  @override
  String minutosDeLeitura(int n) => '$n min de leitura';
  @override
  String exemplos(int n) => n == 1 ? '1 exemplo' : '$n exemplos';
  @override
  String get licaoConcluida => 'Concluída';
  @override
  String get licaoObjetivos => 'O que você vai aprender';
  @override
  String get licaoTerminouTitulo => 'Terminou a leitura?';
  @override
  String get licaoTerminouTexto =>
      'Responda aos exercícios desta lição para ver o que ficou de pé.';
  @override
  String get licaoPraticar => 'Praticar esta lição';
  @override
  String get licaoMarcarConcluida => 'Marcar como concluída';

  @override
  String get blocoErrado => 'Errado';
  @override
  String get blocoCerto => 'Certo';
  @override
  String get blocoDica => 'Dica';
  @override
  String get blocoAtencao => 'Atenção';
  @override
  String get blocoSaidaConsole => 'Saída no console';
  @override
  String get blocoCopiar => 'copiar';
  @override
  String get blocoCopiado => 'copiado';
  @override
  String get blocoAbrirLaboratorio => 'Abrir o laboratório';

  @override
  String get praticarTitulo => 'Praticar';
  @override
  String get praticarChamadaTitulo => 'Este código está certo ou errado?';
  @override
  String praticarChamadaTexto(int total) =>
      'São $total exercícios em três formatos: julgar código, múltipla escolha '
      'e completar a lacuna. Toda resposta vem com explicação.';
  @override
  String get praticarTudo => 'Praticar tudo, misturado';
  @override
  String get praticarDesafioGeral => 'Desafio geral';
  @override
  String exerciciosContagem(int n) => n == 1 ? '1 exercício' : '$n exercícios';

  @override
  String get quizSemExercicios => 'Ainda não há exercícios para esta lição.';
  @override
  String get quizEscolhaAlternativa =>
      'Escolha uma alternativa para ver a explicação.';
  @override
  String get quizVerResultado => 'Ver resultado';
  @override
  String get quizProximaPergunta => 'Próxima pergunta';
  @override
  String quizEscolheu(String opcao) =>
      'Você escolheu "$opcao" · código correto abaixo';
  @override
  String quizPosicao(int atual, int total) => '$atual de $total';
  @override
  String get quizAcertou => 'Isso mesmo';
  @override
  String get quizErrou => 'Não foi dessa vez — veja o porquê';
  @override
  String quizPlacar(int acertos, int total) => '$acertos / $total';
  @override
  String quizAcertosPercentual(int percentual) => 'acertos ($percentual%)';
  @override
  String get quizResultadoPerfeitoTitulo => 'Gabaritou';
  @override
  String get quizResultadoPerfeitoTexto =>
      'Todas certas. Null safety não te pega.';
  @override
  String get quizResultadoBomTitulo => 'Boa base';
  @override
  String get quizResultadoBomTexto => 'Revise os erros e siga para a próxima.';
  @override
  String get quizResultadoMedioTitulo => 'Quase lá';
  @override
  String get quizResultadoMedioTexto =>
      'Uma segunda leitura da lição fecha as lacunas.';
  @override
  String get quizResultadoBaixoTitulo => 'Sem pressa';
  @override
  String get quizResultadoBaixoTexto =>
      'Volte à lição com calma. Todo mundo começa aqui.';

  @override
  String get formatoCertoOuErrado => 'Certo ou errado?';
  @override
  String get formatoMultiplaEscolha => 'Múltipla escolha';
  @override
  String get formatoCompletar => 'Complete a lacuna';
  @override
  String get enunciadoPadraoCertoOuErrado =>
      'Este código compila e faz o esperado?';
  @override
  String get enunciadoPadraoCompletar =>
      'Complete a lacuna para o código funcionar:';
  @override
  String get alternativaEstaCerto => 'Está certo';
  @override
  String get alternativaEstaErrado => 'Está errado';
  @override
  String get legendaLacuna => 'Os três sublinhados em laranja marcam a lacuna.';

  @override
  String get editorTitulo => 'Editor';
  @override
  String get editorChamadaTitulo => 'Escreva e rode Dart aqui dentro';
  @override
  String get editorChamadaTexto =>
      'O editor abre em tela deitada, com o código de um lado e o console do '
      'outro. Já vem com `void main()` preenchido, indentação automática, '
      'fechamento de parênteses e aspas, e erros explicados com dica de como '
      'corrigir.';
  @override
  String get editorAbrir => 'Abrir o editor';
  @override
  String get editorComecePorExemplo => 'Comece por um exemplo';
  @override
  String get editorComoFunciona => 'Como isto funciona';
  @override
  String get editorComoFuncionaTexto =>
      'Um app Flutter já compilado **não consegue compilar Dart de verdade** '
      'em tempo de execução. Então este editor traz um **mini-interpretador '
      'escrito em Dart**, dentro do próprio app: ele lê seu código, monta a '
      'árvore sintática e executa — tudo offline.';
  @override
  String get editorFunciona => 'Funciona';
  @override
  List<String> get editorFuncionaItens => const [
    'Variáveis, tipos e null safety (?, ?., ??, ??=, !, late)',
    'Funções: arrow, nomeadas, opcionais, anônimas, closures',
    'if, for, while, do-while, switch, break/continue',
    'List, Set, Map com map/where/fold, spread e collection if/for',
    'Classes com construtor, métodos, getters e toString',
    'try / catch / finally e throw',
    'Vários arquivos conversando entre si',
  ];
  @override
  String get editorAindaNao => 'Ainda não';
  @override
  List<String> get editorAindaNaoItens => const [
    'async / await e Streams (precisam de event loop)',
    'Herança, mixins e extensions',
    'Records, sealed classes e pattern matching',
    'Importar pacotes do pub.dev',
  ];
  @override
  String get editorRodape =>
      'Para o Dart completo, use o `dartpad.dev` no navegador. O código do '
      'interpretador está em `features/playground/data/interpretador/` — são '
      'quatro etapas: lexer, parser, AST e interpretador.';
  @override
  String abasContagem(int n) => n == 1 ? '1 aba' : '$n abas';

  @override
  String get editorSair => 'Sair';
  @override
  String get editorNome => 'Mini-editor Dart';
  @override
  String get editorExemplos => 'Exemplos';
  @override
  String get editorRodar => 'Rodar';
  @override
  String get editorCarregarExemplo => 'Carregar exemplo';
  @override
  String get editorCarregarExemploAviso =>
      'Isso substitui o que está no editor agora.';
  @override
  String get editorRenomearArquivo => 'Renomear arquivo';
  @override
  String get editorNomePlaceholder => 'nome.dart';
  @override
  String get editorLimpar => 'limpar';
  @override
  String get editorConsoleVazio => 'Aperte Rodar para executar\nseu código';
  @override
  String editorEncerrouSemErros(int milissegundos) =>
      'Programa encerrado sem erros ($milissegundos ms)';
  @override
  String editorLinha(int linha) => 'linha $linha';

  @override
  String get labTitulo => 'Laboratório de testes';
  @override
  String get labPrevious => 'Lição';
  @override
  String get labTelaTitulo => 'A tela montada pelo teste';
  @override
  String get labTelaDescricao =>
      'É assim que o `flutter_test` enxerga: uma árvore de nós. As caixinhas '
      'cinzas são os seus widgets.';
  @override
  String get labCodigoLegenda => 'O código que produz essa tela';
  @override
  String get labAsercaoTitulo => 'Monte a asserção';
  @override
  String get labAsercaoDescricao =>
      'Escolha **o que procurar** (finder) e **quantos você espera** (matcher). '
      'Tocar de novo desmarca.';
  @override
  String get labFinder => 'Finder — o que procurar';
  @override
  String get labMatcher => 'Matcher — quantos você espera';
  @override
  String get labRodarTeste => 'Rodar teste';
  @override
  String get labSaidaTitulo => 'A saída do teste';
  @override
  String get labSaidaDescricao =>
      'As mesmas frases que aparecem no seu terminal.';
  @override
  String get labProximoCenario => 'Próximo cenário';
  @override
  String get labDesafio => 'Desafio';
  @override
  String get labDesafioConcluido => 'Desafio concluído';
  @override
  String get labVerDica => 'Ver uma dica';
  @override
  String get labEsconderDica => 'Esconder a dica';
  @override
  String get labRodarInteracao => 'Rodar essa interação';
  @override
  String get labDesfazerToque => 'Desfazer o toque';
  @override
  String labPassou(int quantidade) => quantidade == 1
      ? 'Passou — 1 widget encontrado'
      : 'Passou — $quantidade widgets encontrados';
  @override
  String labFalhou(int quantidade) => quantidade == 1
      ? 'Falhou — 1 widget encontrado'
      : 'Falhou — $quantidade widgets encontrados';

  @override
  String get glossarioTitulo => 'Sintaxe';
  @override
  String get glossarioBuscaPlaceholder => 'Buscar: late, ??, mixin, await…';
  @override
  String get glossarioTudo => 'Tudo';
  @override
  String glossarioNadaEncontrado(String busca) =>
      'Nada encontrado para "$busca".';

  @override
  String get perfilTitulo => 'Seu progresso';
  @override
  String get perfilMetricaLicoes => 'lições\nconcluídas';
  @override
  String get perfilMetricaAcertos => 'respostas\ncertas';
  @override
  String get perfilMetricaAproveitamento => 'aproveita-\nmento';
  @override
  String get perfilAparencia => 'Aparência';
  @override
  String get perfilIdioma => 'Idioma';
  @override
  String get perfilIdiomaNota =>
      'Muda a interface e o conteúdo das lições, dos exercícios e do glossário.';
  @override
  String get perfilArquiteturaTitulo => 'Como este app foi construído';
  @override
  String get perfilArquiteturaTexto =>
      'O código-fonte também é material de estudo: cada arquivo tem comentários '
      'explicando o recurso de Dart que ele usa. A organização segue **Clean '
      'Architecture**, com três camadas por funcionalidade.';
  @override
  String get perfilCamadaDomain =>
      'Dart puro, **sem importar Flutter**. Regras de negócio que sobrevivem a '
      'qualquer mudança de interface.';
  @override
  String get perfilCamadaData =>
      'Sabe DE ONDE vêm os dados. Trocar memória por API mexe só aqui.';
  @override
  String get perfilCamadaPresentation =>
      'Telas e controladores. Só conhece o domain — nunca o banco.';
  @override
  String get perfilEstudarTitulo => 'Para continuar estudando';
  @override
  String get perfilEstudarTexto =>
      '• `dart.dev/language` — a documentação oficial da linguagem, curta e '
      'direta.\n'
      '• `dartpad.dev` — editor online: cole os exemplos deste app e '
      'experimente mudar as coisas.\n'
      '• `dart.dev/null-safety` — o guia completo de null safety.';
  @override
  String get perfilSobreTitulo => 'Sobre este app';
  @override
  String get perfilRevisarOnboarding => 'Rever a apresentação';
  @override
  String get perfilRodape => 'Feito com Flutter e Dart';

  @override
  String get temaSistema => 'Sistema';
  @override
  String get temaSistemaDescricao => 'Segue o ajuste do seu aparelho';
  @override
  String get temaClaro => 'Claro';
  @override
  String get temaClaroDescricao => 'Sempre no tema claro';
  @override
  String get temaEscuro => 'Escuro';
  @override
  String get temaEscuroDescricao => 'Sempre no tema escuro';

  @override
  String get nivelIniciante => 'Iniciante';
  @override
  String get nivelIntermediario => 'Intermediário';
  @override
  String get nivelAvancado => 'Avançado';

  @override
  String get categoriaSintaxe => 'Sintaxe';
  @override
  String get categoriaNullSafety => 'Null Safety';
  @override
  String get categoriaFuncoes => 'Funções';
  @override
  String get categoriaColecoes => 'Coleções';
  @override
  String get categoriaClasses => 'Classes';
  @override
  String get categoriaAssincrono => 'Assíncrono';

  @override
  String get diagErroSintaxe => 'Erro de sintaxe';
  @override
  String get diagErroExecucao => 'Erro de execução';
  @override
  String get diagSemMain => 'Nenhum arquivo tem a função main().';
  @override
  String get diagSemMainDica =>
      'Todo programa Dart começa por: void main() { ... }';
  @override
  String diagAbaInexistente(String nome) =>
      'Não existe nenhuma aba chamada "$nome".';
  @override
  String diagAbasDisponiveis(String nomes) => 'Abas disponíveis: $nomes.';
  @override
  String diagExcecaoNaoTratada(String valor) => 'Exceção não tratada: $valor';
  @override
  String get diagExcecaoDica =>
      'Envolva a chamada em try { ... } catch (e) { ... }.';
  @override
  String get diagRecursaoInfinita =>
      'Recursão infinita: a função chama a si mesma sem parar.';
  @override
  String get diagRecursaoDica =>
      'Toda função recursiva precisa de um caso de parada.';

  @override
  String erroLicaoNaoEncontrada(String id) => 'Lição "$id" não encontrada.';

  @override
  String erroCarregarLicoes(Object e) =>
      'Não foi possível carregar as lições: $e';
  @override
  String erroAbrirLicao(Object e) => 'Erro ao abrir a lição: $e';
  @override
  String erroCarregarExercicios(Object e) =>
      'Não foi possível carregar os exercícios: $e';
  @override
  String erroCarregarGlossario(Object e) => 'Erro ao carregar o glossário: $e';
  @override
  String erroCarregarCenarios(Object e) =>
      'Não foi possível carregar os cenários: $e';
  @override
  String erroLerProgresso(Object e) => 'Erro ao ler o progresso: $e';
  @override
  String erroSalvarProgresso(Object e) => 'Erro ao salvar o progresso: $e';
}
