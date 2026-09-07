import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao10ArquiteturaEn = Licao(
  id: 'clean-architecture',
  titulo: 'Clean Architecture in practice',
  resumo: 'How THIS app is laid out — and why.',
  nivel: NivelLicao.avancado,
  minutos: 14,
  objetivos: [
    'Understand the domain, data and presentation layers',
    'Know why the dependency arrow always points inwards',
    'Find any file in this project without searching',
  ],
  blocos: [
    BlocoTexto(
      'Clean Architecture is a way of organising code into **layers**, with '
      'the business rules at the centre, knowing nothing about the screen or '
      'the database. The payoff is simple: **swapping the screen or the data '
      'source does not break the rest**.',
    ),
    BlocoTitulo('The three layers'),
    BlocoTabela(
      cabecalho: ('Layer', 'Responsibility'),
      linhas: [
        ('domain', 'WHAT the app does: entities, contracts and use cases'),
        (
          'data',
          'WHERE the data comes from: data sources and real repositories',
        ),
        ('presentation', 'HOW it looks: screens, widgets and controllers'),
      ],
    ),
    BlocoCodigo(r'''
lib/
├── core/                    # things used across the whole app
│   ├── tema/                # colours, light/dark theme
│   ├── i18n/                # the translation contract
│   ├── utils/               # Resultado<T> (success or failure)
│   └── widgets/             # reusable visual components
│
├── features/                # one folder per feature
│   └── licoes/
│       ├── domain/
│       │   ├── entities/        # Licao, BlocoConteudo  (pure Dart)
│       │   ├── repositories/    # the CONTRACT (abstract interface class)
│       │   └── usecases/        # ListarLicoes, ObterLicao
│       ├── data/
│       │   ├── datasources/     # content held in memory
│       │   └── repositories/    # the IMPLEMENTATION of the contract
│       └── presentation/
│           ├── controllers/     # ChangeNotifier (screen state)
│           ├── pages/           # screens
│           └── widgets/         # the feature's visual pieces
│
├── app/                     # dependency injection + CupertinoApp
└── main.dart                # runApp()
''', legenda: 'Open the project and check: this is exactly the structure.'),
    BlocoTitulo('The golden rule: the arrow points inwards'),
    BlocoCodigo(
      r'''
presentation  ───▶  domain  ◀───  data

• presentation knows domain      ✅
• data         knows domain      ✅
• domain       knows nobody      ✅ (it does not even import Flutter)
''',
      legenda:
          'If `domain` imported Flutter, you could not test a business rule '
          'without booting a screen.',
    ),
    BlocoTexto(
      'Notice that the files in this app\'s `domain/entities` carry **no '
      '`import package:flutter`** at all. That is not a detail: it is the '
      'practical test that the layer is clean.',
    ),
    BlocoTitulo('How a tap on the screen becomes data'),
    BlocoCodigo(r'''
1. Someone taps a lesson
        ↓
2. PaginaLicoes calls the CONTROLLER
        ↓
3. The controller calls the USE CASE      (ObterLicao)
        ↓
4. The use case calls the CONTRACT        (LicaoRepositorio)
        ↓
5. The IMPLEMENTATION reads the DATA SOURCE (memory, API, SQLite…)
        ↓
6. Back comes a Resultado<Licao> (Success or Failure)
        ↓
7. The controller calls notifyListeners() and the screen repaints
''', legenda: 'Every step has a single responsibility.'),
    BlocoTitulo('Why all this ceremony for a small app?'),
    BlocoLista([
      '**Testable**: you can test a use case with a fake repository, with no '
          'screen and no internet.',
      '**Replaceable**: today the content lives in memory; moving to an API '
          'touches ONE file (`licao_repositorio_impl.dart`).',
      '**Predictable**: anyone new to the team knows where to look.',
      '**Scalable**: each new feature is a new folder, without disturbing the '
          'existing ones.',
    ]),
    BlocoTitulo('Dependency injection with no package at all'),
    BlocoTexto(
      'This app wires everything by hand in `app/injecao.dart`. No magic, no '
      '`get_it`: just one object building the others in the right order. That '
      'way you can read the whole dependency tree in 20 lines.',
    ),
    BlocoCodigo(
      r'''
// Inside out: data source → repository → use case → controller
final datasource = LicoesEmMemoria();
final repository = LicaoRepositorioImpl(datasource);
final listLessons = ListarLicoes(repository);
final controller = ControladorLicoes(listarLicoes: listLessons);
''',
      legenda:
          'Each piece receives what it depends on through its constructor. '
          'That is dependency injection.',
    ),
    BlocoDica(
      'Start simple. In a two-screen app, one layer is plenty. Clean '
      'Architecture pays for itself once the project grows, or once more '
      'people start touching it.',
    ),
    BlocoAviso(
      'A layer is not a pretty folder: it is a **direction of dependency**. If '
      'your `domain` imports a widget, the architecture is already broken, '
      'however immaculate the folders look.',
    ),
  ],
);
