import '../../../domain/entities/item_glossario.dart';

const List<ItemGlossario> glossarioPt = [
  ItemGlossario(
    termo: 'var',
    sintaxe: 'var x = 10;',
    significado:
        'Declara a variável deixando o Dart inferir o tipo. Depois disso o '
        'tipo é fixo — só o valor pode mudar.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'final',
    sintaxe: 'final nome = \'Ana\';',
    significado:
        'Valor atribuído uma única vez, definido quando o app roda. Deve ser '
        'sua escolha padrão.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'const',
    sintaxe: 'const pi = 3.14;',
    significado:
        'Constante conhecida em tempo de compilação. Objetos const são '
        'criados uma vez e reaproveitados.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'Interpolação',
    sintaxe: '\'Oi \$nome, \${a + b}\'',
    significado:
        'Insere valores dentro de textos. Use chaves quando houver expressão '
        '(ponto, cálculo ou chamada de método).',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'Cascata',
    sintaxe: 'objeto..a()..b();',
    significado:
        'Chama vários métodos no mesmo objeto sem repetir o nome dele.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'typedef',
    sintaxe: 'typedef Callback = void Function(int);',
    significado: 'Cria um apelido para um tipo — geralmente de função.',
    categoria: CategoriaGlossario.sintaxe,
  ),

  ItemGlossario(
    termo: 'Tipo anulável',
    sintaxe: 'String? nome;',
    significado:
        'O `?` permite que a variável seja null. Sem ele, o Dart garante que '
        'nunca será.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Acesso seguro',
    sintaxe: 'nome?.length',
    significado:
        'Se `nome` for null, a expressão inteira vira null em vez de quebrar.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Valor padrão',
    sintaxe: 'nome ?? \'Visitante\'',
    significado: 'Usa o lado direito quando o esquerdo é null.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Atribuição se nulo',
    sintaxe: 'nome ??= \'Visitante\';',
    significado: 'Só atribui se a variável estiver null no momento.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Bang (!)',
    sintaxe: 'nome!.length',
    significado:
        'Afirma que não é null. Se você estiver errado, o app quebra em '
        'execução. Use como último recurso.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'late',
    sintaxe: 'late final String titulo;',
    significado:
        'Promete preencher antes do primeiro uso. Também adia cálculos caros.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Spread anulável',
    sintaxe: '[...?talvezLista]',
    significado: 'Despeja os itens de uma lista que pode ser null, sem erro.',
    categoria: CategoriaGlossario.nullSafety,
  ),

  ItemGlossario(
    termo: 'Arrow',
    sintaxe: 'int dobro(int n) => n * 2;',
    significado: 'Corpo de uma expressão só. O `=>` já inclui o return.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Parâmetro nomeado',
    sintaxe: 'void f({required String a, int b = 0})',
    significado:
        'Passado pelo nome, em qualquer ordem. `required` obriga; sem ele é '
        'opcional.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Parâmetro opcional posicional',
    sintaxe: 'void f(String a, [String? b])',
    significado: 'Colchetes tornam o parâmetro opcional, mantendo a ordem.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Função anônima',
    sintaxe: '(x) => x * 2',
    significado: 'Função sem nome, criada na hora para passar adiante.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Tipo função',
    sintaxe: 'int Function(int)',
    significado: 'O tipo de uma função que recebe int e devolve int.',
    categoria: CategoriaGlossario.funcoes,
  ),

  ItemGlossario(
    termo: 'map',
    sintaxe: 'lista.map((e) => e * 2).toList()',
    significado: 'Transforma cada item, gerando uma nova coleção.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'where',
    sintaxe: 'lista.where((e) => e > 2).toList()',
    significado: 'Filtra, mantendo só quem passa no teste.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'firstOrNull',
    sintaxe: 'lista.where(...).firstOrNull',
    significado:
        'Devolve o primeiro item ou null — alternativa segura ao firstWhere.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'fold',
    sintaxe: 'lista.fold<int>(0, (t, e) => t + e)',
    significado: 'Acumula todos os itens em um único valor.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'collection if / for',
    sintaxe: '[if (cond) a, for (final x in l) x]',
    significado:
        'Condicionais e laços dentro da própria lista — muito usado em '
        '`children:`.',
    categoria: CategoriaGlossario.colecoes,
  ),

  ItemGlossario(
    termo: 'Construtor com this',
    sintaxe: 'Usuario(this.nome);',
    significado: 'Recebe o valor e já guarda no campo de mesmo nome.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'factory',
    sintaxe: 'factory X.deMapa(Map m) => ...;',
    significado:
        'Construtor que decide o que devolver. Ideal para criar objeto a '
        'partir de JSON.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'getter',
    sintaxe: 'double get area => l * a;',
    significado: 'Propriedade calculada, lida sem parênteses.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'mixin',
    sintaxe: 'class A with Nadador {}',
    significado: 'Injeta comportamento pronto sem usar herança.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'extension',
    sintaxe: 'extension X on String { ... }',
    significado: 'Adiciona métodos a um tipo já existente.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'sealed class',
    sintaxe: 'sealed class Estado {}',
    significado:
        'Conjunto fechado de subclasses; permite switch exaustivo verificado '
        'pelo compilador.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'record',
    sintaxe: '(String, int) f() => (\'Ana\', 30);',
    significado:
        'Agrupa vários valores tipados sem criar uma classe. Comparado por '
        'valor.',
    categoria: CategoriaGlossario.classes,
  ),

  ItemGlossario(
    termo: 'Future',
    sintaxe: 'Future<String> buscar() async { ... }',
    significado: 'Promessa de um valor que chega depois.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'await',
    sintaxe: 'final x = await buscar();',
    significado:
        'Espera o Future terminar sem travar a interface. Só dentro de '
        'função `async`.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'Future.wait',
    sintaxe: 'await Future.wait([a(), b()])',
    significado: 'Executa vários Futures em paralelo e espera todos.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'Stream / yield',
    sintaxe: 'Stream<int> f() async* { yield 1; }',
    significado: 'Vários valores ao longo do tempo; `yield` solta cada um.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'try / catch / finally',
    sintaxe: 'try { } on Erro catch (e) { } finally { }',
    significado:
        'Trata exceções. `on` filtra por tipo; `finally` sempre executa.',
    categoria: CategoriaGlossario.assincrono,
  ),
];
