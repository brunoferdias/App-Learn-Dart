import '../core/i18n/controlador_idioma.dart';
import '../core/i18n/textos.dart';
import '../core/preferencias/preferencias.dart';
import '../core/tema/controlador_tema.dart';
import '../features/avaliacao/data/datasources/avaliacao_local_datasource.dart';
import '../features/avaliacao/data/repositories/avaliacao_repositorio_impl.dart';
import '../features/avaliacao/data/servicos/loja_nativa.dart';
import '../features/avaliacao/domain/repositories/avaliacao_repositorio.dart';
import '../features/avaliacao/domain/usecases/gerenciar_avaliacao.dart';
import '../features/avaliacao/presentation/controllers/controlador_avaliacao.dart';
import '../features/exercicios/data/datasources/exercicios_locais_datasource.dart';
import '../features/exercicios/data/repositories/exercicio_repositorio_impl.dart';
import '../features/exercicios/domain/repositories/exercicio_repositorio.dart';
import '../features/exercicios/domain/usecases/corrigir_exercicio.dart';
import '../features/exercicios/domain/usecases/listar_exercicios.dart';
import '../features/exercicios/presentation/controllers/controlador_quiz.dart';
import '../features/glossario/data/datasources/glossario_local_datasource.dart';
import '../features/glossario/data/repositories/glossario_repositorio_impl.dart';
import '../features/glossario/domain/repositories/glossario_repositorio.dart';
import '../features/glossario/domain/usecases/buscar_no_glossario.dart';
import '../features/licoes/data/datasources/licoes_locais_datasource.dart';
import '../features/licoes/data/repositories/licao_repositorio_impl.dart';
import '../features/licoes/domain/repositories/licao_repositorio.dart';
import '../features/licoes/domain/usecases/listar_licoes.dart';
import '../features/licoes/domain/usecases/obter_licao.dart';
import '../features/licoes/presentation/controllers/controlador_licoes.dart';
import '../features/playground/data/datasources/exemplos_locais_datasource.dart';
import '../features/playground/data/repositories/playground_repositorio_impl.dart';
import '../features/playground/domain/repositories/playground_repositorio.dart';
import '../features/playground/domain/usecases/analisar_codigo.dart';
import '../features/playground/domain/usecases/executar_codigo.dart';
import '../features/playground/presentation/controllers/controlador_playground.dart';
import '../features/progresso/data/datasources/progresso_local_datasource.dart';
import '../features/progresso/data/repositories/progresso_repositorio_impl.dart';
import '../features/progresso/domain/repositories/progresso_repositorio.dart';
import '../features/progresso/domain/usecases/gerenciar_progresso.dart';
import '../features/onboarding/presentation/controllers/controlador_onboarding.dart';
import '../features/progresso/presentation/controllers/controlador_progresso.dart';
import '../features/testes/data/datasources/cenarios_locais_datasource.dart';
import '../features/testes/data/repositories/cenario_repositorio_impl.dart';
import '../features/testes/domain/repositories/cenario_repositorio.dart';
import '../features/testes/domain/usecases/listar_cenarios.dart';
import '../features/testes/presentation/controllers/controlador_laboratorio.dart';

class Injecao {
  Injecao({required this.preferencias, required this.localeDoSistema});

  final Preferencias preferencias;

  final String localeDoSistema;

  late final LicoesLocaisDatasource _licoesDatasource = const LicoesEmMemoria();

  late final LicaoRepositorio _licaoRepositorio = LicaoRepositorioImpl(
    _licoesDatasource,
  );

  late final ListarLicoes listarLicoes = ListarLicoes(_licaoRepositorio);
  late final ObterLicao obterLicao = ObterLicao(_licaoRepositorio);

  late final ExerciciosLocaisDatasource _exerciciosDatasource =
      const ExerciciosEmMemoria();

  late final ExercicioRepositorio _exercicioRepositorio =
      ExercicioRepositorioImpl(_exerciciosDatasource);

  late final ListarExercicios listarExercicios = ListarExercicios(
    _exercicioRepositorio,
  );
  late final CorrigirExercicio corrigirExercicio = const CorrigirExercicio();

  late final GlossarioLocalDatasource _glossarioDatasource =
      const GlossarioEmMemoria();

  late final GlossarioRepositorio _glossarioRepositorio =
      GlossarioRepositorioImpl(_glossarioDatasource);

  late final BuscarNoGlossario buscarNoGlossario = BuscarNoGlossario(
    _glossarioRepositorio,
  );

  late final ExemplosLocaisDatasource _exemplosDatasource =
      const ExemplosEmMemoria();

  late final PlaygroundRepositorio _playgroundRepositorio =
      PlaygroundRepositorioImpl(_exemplosDatasource);

  late final ExecutarCodigo executarCodigo = ExecutarCodigo(
    _playgroundRepositorio,
  );
  late final AnalisarCodigo analisarCodigo = AnalisarCodigo(
    _playgroundRepositorio,
  );

  late final CenariosLocaisDatasource _cenariosDatasource =
      const CenariosEmMemoria();

  late final CenarioRepositorio _cenarioRepositorio = CenarioRepositorioImpl(
    _cenariosDatasource,
  );

  late final ListarCenarios listarCenarios = ListarCenarios(
    _cenarioRepositorio,
  );

  late final ProgressoLocalDatasource _progressoDatasource =
      ProgressoEmPreferencias(preferencias);

  late final ProgressoRepositorio _progressoRepositorio =
      ProgressoRepositorioImpl(_progressoDatasource);

  late final AvaliacaoLocalDatasource _avaliacaoDatasource =
      AvaliacaoEmPreferencias(preferencias);

  late final AvaliacaoRepositorio _avaliacaoRepositorio =
      AvaliacaoRepositorioImpl(_avaliacaoDatasource);

  late final ControladorAvaliacao controladorAvaliacao = ControladorAvaliacao(
    carregar: CarregarAvaliacao(_avaliacaoRepositorio),
    registrar: RegistrarMomento(_avaliacaoRepositorio),
    registrarPedido: RegistrarPedido(_avaliacaoRepositorio),
    encerrar: EncerrarPedidos(_avaliacaoRepositorio),
    loja: const LojaNativa(),
  );

  late final ControladorTema controladorTema = ControladorTema(
    preferencias: preferencias,
  );

  late final ControladorIdioma controladorIdioma = ControladorIdioma(
    preferencias: preferencias,
    localeDoSistema: localeDoSistema,
  );

  late final ControladorOnboarding controladorOnboarding =
      ControladorOnboarding(preferencias: preferencias);

  late final ControladorProgresso controladorProgresso = ControladorProgresso(
    carregar: CarregarProgresso(_progressoRepositorio),
    concluir: ConcluirLicao(_progressoRepositorio),
    registrar: RegistrarResposta(_progressoRepositorio),
    textos: controladorIdioma.textos,
  );

  ControladorLicoes criarControladorLicoes() =>
      ControladorLicoes(listarLicoes: listarLicoes);

  ControladorPlayground criarControladorPlayground(Textos textos) =>
      ControladorPlayground(
        executarCodigo: executarCodigo,
        analisarCodigo: analisarCodigo,
        repositorio: _playgroundRepositorio,
        textos: textos,
      );

  ControladorLaboratorio criarControladorLaboratorio() =>
      ControladorLaboratorio(listarCenarios: listarCenarios);

  ControladorQuiz criarControladorQuiz() => ControladorQuiz(
    listarExercicios: listarExercicios,
    corrigirExercicio: corrigirExercicio,
    aoResponder: controladorProgresso.registrarResposta,
  );
}
