import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao10Arquitetura = Licao(
  id: 'clean-architecture',
  titulo: 'Clean Architecture na prática',
  resumo: 'Como ESTE app está organizado — e por quê.',
  nivel: NivelLicao.avancado,
  minutos: 14,
  objetivos: [
    'Entender as camadas domain, data e presentation',
    'Saber por que a seta de dependência aponta sempre para dentro',
    'Localizar qualquer arquivo deste projeto sem procurar',
  ],
  blocos: [
    BlocoTexto(
      'Clean Architecture é uma forma de organizar o código em **camadas**, '
      'onde as regras de negócio ficam no centro e não conhecem nem a tela nem '
      'o banco de dados. O ganho é simples: **trocar a tela ou a fonte de '
      'dados não quebra o resto**.',
    ),
    BlocoTitulo('As três camadas'),
    BlocoTabela(
      cabecalho: ('Camada', 'Responsabilidade'),
      linhas: [
        ('domain', 'O QUE o app faz: entidades, contratos e casos de uso'),
        ('data', 'DE ONDE vêm os dados: datasources e repositórios concretos'),
        ('presentation', 'COMO aparece: telas, widgets e controladores'),
      ],
    ),
    BlocoCodigo(r'''
lib/
├── core/                    # coisas usadas por todo o app
│   ├── tema/                # cores, tema claro/escuro
│   ├── utils/               # Resultado<T> (sucesso ou falha)
│   └── widgets/             # componentes visuais reutilizáveis
│
├── features/                # uma pasta por funcionalidade
│   └── licoes/
│       ├── domain/
│       │   ├── entities/        # Licao, BlocoConteudo  (Dart puro)
│       │   ├── repositories/    # CONTRATO (abstract interface class)
│       │   └── usecases/        # ListarLicoes, ObterLicao
│       ├── data/
│       │   ├── datasources/     # conteúdo em memória
│       │   └── repositories/    # IMPLEMENTAÇÃO do contrato
│       └── presentation/
│           ├── controllers/     # ChangeNotifier (estado da tela)
│           ├── pages/           # telas
│           └── widgets/         # peças visuais da feature
│
├── app/                     # injeção de dependências + CupertinoApp
└── main.dart                # runApp()
''', legenda: 'Abra o projeto e confira: é exatamente esta estrutura.'),
    BlocoTitulo('A regra de ouro: a seta aponta para dentro'),
    BlocoCodigo(
      r'''
presentation  ───▶  domain  ◀───  data

• presentation conhece domain      ✅
• data        conhece domain       ✅
• domain      NÃO conhece ninguém  ✅ (nem importa Flutter!)
''',
      legenda:
          'Se `domain` importasse Flutter, você não conseguiria testar a regra '
          'de negócio sem subir uma tela.',
    ),
    BlocoTexto(
      'Repare que os arquivos de `domain/entities` deste app **não têm nenhum '
      '`import package:flutter`**. Isso não é detalhe: é o teste prático de '
      'que a camada está limpa.',
    ),
    BlocoTitulo('Como um toque na tela vira dado'),
    BlocoCodigo(r'''
1. Usuário toca em uma lição
        ↓
2. PaginaLicoes chama o CONTROLADOR
        ↓
3. Controlador chama o CASO DE USO      (ObterLicao)
        ↓
4. Caso de uso chama o CONTRATO         (LicaoRepositorio)
        ↓
5. A IMPLEMENTAÇÃO busca no DATASOURCE  (memória, API, SQLite…)
        ↓
6. Volta um Resultado<Licao> (Sucesso ou Falha)
        ↓
7. O controlador chama notifyListeners() e a tela se redesenha
''', legenda: 'Cada passo tem uma única responsabilidade.'),
    BlocoTitulo('Por que tanta cerimônia para um app pequeno?'),
    BlocoLista([
      '**Testável**: dá para testar o caso de uso com um repositório falso, '
          'sem tela e sem internet.',
      '**Substituível**: hoje o conteúdo está em memória; trocar por uma API é '
          'mexer em UM arquivo (`licao_repositorio_impl.dart`).',
      '**Previsível**: qualquer pessoa nova no time sabe onde procurar.',
      '**Escalável**: cada feature nova é uma pasta nova, sem bagunçar as '
          'existentes.',
    ]),
    BlocoTitulo('Injeção de dependência sem pacote nenhum'),
    BlocoTexto(
      'Este app monta tudo à mão em `app/injecao.dart`. Sem mágica, sem '
      '`get_it`: é só um objeto criando os outros na ordem certa. Assim dá '
      'para ver a árvore de dependências inteira em 20 linhas.',
    ),
    BlocoCodigo(
      r'''
// De dentro para fora: datasource → repositório → caso de uso → controlador
final datasource = LicoesEmMemoria();
final repositorio = LicaoRepositorioImpl(datasource);
final listarLicoes = ListarLicoes(repositorio);
final controlador = ControladorLicoes(listarLicoes: listarLicoes);
''',
      legenda:
          'Cada peça recebe de quem depende pelo construtor. Isso é injeção '
          'de dependência.',
    ),
    BlocoDica(
      'Comece simples. Em um app de duas telas, uma camada só já basta. Clean '
      'Architecture paga o próprio custo quando o projeto cresce ou quando '
      'mais gente mexe nele.',
    ),
    BlocoAviso(
      'Camada não é pasta bonita: é **direção de dependência**. Se o seu '
      '`domain` importa um widget, a arquitetura já foi quebrada, mesmo que as '
      'pastas estejam impecáveis.',
    ),
  ],
);
