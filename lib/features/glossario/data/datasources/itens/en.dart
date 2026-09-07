import '../../../domain/entities/item_glossario.dart';

const List<ItemGlossario> glossarioEn = [
  ItemGlossario(
    termo: 'var',
    sintaxe: 'var x = 10;',
    significado:
        'Declares the variable and lets Dart infer the type. After that the '
        'type is fixed — only the value can change.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'final',
    sintaxe: 'final name = \'Ana\';',
    significado:
        'A value assigned exactly once, decided when the app runs. This should '
        'be your default choice.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'const',
    sintaxe: 'const pi = 3.14;',
    significado:
        'A constant known at compile time. Const objects are created once and '
        'reused.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'Interpolation',
    sintaxe: '\'Hi \$name, \${a + b}\'',
    significado:
        'Drops values into text. Use braces whenever there is an expression '
        '(a dot, arithmetic or a method call).',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'Cascade',
    sintaxe: 'object..a()..b();',
    significado:
        'Calls several methods on the same object without repeating its name.',
    categoria: CategoriaGlossario.sintaxe,
  ),
  ItemGlossario(
    termo: 'typedef',
    sintaxe: 'typedef Callback = void Function(int);',
    significado: 'Creates a nickname for a type — usually a function type.',
    categoria: CategoriaGlossario.sintaxe,
  ),

  ItemGlossario(
    termo: 'Nullable type',
    sintaxe: 'String? name;',
    significado:
        'The `?` allows the variable to be null. Without it, Dart guarantees '
        'it never will be.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Safe access',
    sintaxe: 'name?.length',
    significado:
        'If `name` is null, the whole expression becomes null instead of '
        'throwing.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Default value',
    sintaxe: 'name ?? \'Guest\'',
    significado: 'Uses the right-hand side when the left one is null.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Assign if null',
    sintaxe: 'name ??= \'Guest\';',
    significado: 'Only assigns when the variable is null at that moment.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Bang (!)',
    sintaxe: 'name!.length',
    significado:
        'Asserts that it is not null. If you are wrong, the app crashes at run '
        'time. Use it as a last resort.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'late',
    sintaxe: 'late final String title;',
    significado:
        'Promises to fill it in before first use. It also defers expensive '
        'work.',
    categoria: CategoriaGlossario.nullSafety,
  ),
  ItemGlossario(
    termo: 'Null-aware spread',
    sintaxe: '[...?maybeList]',
    significado:
        'Pours in the items of a list that may be null, without an error.',
    categoria: CategoriaGlossario.nullSafety,
  ),

  ItemGlossario(
    termo: 'Arrow',
    sintaxe: 'int twice(int n) => n * 2;',
    significado:
        'A single-expression body. The `=>` already includes the return.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Named parameter',
    sintaxe: 'void f({required String a, int b = 0})',
    significado:
        'Passed by name, in any order. `required` makes it mandatory; without '
        'it, it is optional.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Optional positional parameter',
    sintaxe: 'void f(String a, [String? b])',
    significado:
        'Square brackets make the parameter optional while keeping the order.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Anonymous function',
    sintaxe: '(x) => x * 2',
    significado:
        'A function with no name, created on the spot to be passed on.',
    categoria: CategoriaGlossario.funcoes,
  ),
  ItemGlossario(
    termo: 'Function type',
    sintaxe: 'int Function(int)',
    significado: 'The type of a function taking an int and returning an int.',
    categoria: CategoriaGlossario.funcoes,
  ),

  ItemGlossario(
    termo: 'map',
    sintaxe: 'list.map((e) => e * 2).toList()',
    significado: 'Transforms each item, producing a new collection.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'where',
    sintaxe: 'list.where((e) => e > 2).toList()',
    significado: 'Filters, keeping only what passes the test.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'firstOrNull',
    sintaxe: 'list.where(...).firstOrNull',
    significado:
        'Returns the first item or null — the safe alternative to firstWhere.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'fold',
    sintaxe: 'list.fold<int>(0, (t, e) => t + e)',
    significado: 'Accumulates every item into a single value.',
    categoria: CategoriaGlossario.colecoes,
  ),
  ItemGlossario(
    termo: 'collection if / for',
    sintaxe: '[if (cond) a, for (final x in l) x]',
    significado:
        'Conditionals and loops inside the list itself — used constantly in '
        '`children:`.',
    categoria: CategoriaGlossario.colecoes,
  ),

  ItemGlossario(
    termo: 'Constructor with this',
    sintaxe: 'User(this.name);',
    significado: 'Takes the value and stores it in the field of the same name.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'factory',
    sintaxe: 'factory X.fromMap(Map m) => ...;',
    significado:
        'A constructor that decides what to return. Ideal for building an '
        'object from JSON.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'getter',
    sintaxe: 'double get area => w * h;',
    significado: 'A computed property, read without parentheses.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'mixin',
    sintaxe: 'class A with Swimmer {}',
    significado: 'Injects ready-made behaviour without using inheritance.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'extension',
    sintaxe: 'extension X on String { ... }',
    significado: 'Adds methods to a type that already exists.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'sealed class',
    sintaxe: 'sealed class State {}',
    significado:
        'A closed set of subclasses; enables an exhaustive switch checked by '
        'the compiler.',
    categoria: CategoriaGlossario.classes,
  ),
  ItemGlossario(
    termo: 'record',
    sintaxe: '(String, int) f() => (\'Ana\', 30);',
    significado:
        'Groups several typed values without writing a class. Compared by '
        'value.',
    categoria: CategoriaGlossario.classes,
  ),

  ItemGlossario(
    termo: 'Future',
    sintaxe: 'Future<String> fetch() async { ... }',
    significado: 'A promise of a value that arrives later.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'await',
    sintaxe: 'final x = await fetch();',
    significado:
        'Waits for the Future to finish without freezing the interface. Only '
        'inside an `async` function.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'Future.wait',
    sintaxe: 'await Future.wait([a(), b()])',
    significado: 'Runs several Futures in parallel and waits for all of them.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'Stream / yield',
    sintaxe: 'Stream<int> f() async* { yield 1; }',
    significado: 'Many values over time; `yield` releases each one.',
    categoria: CategoriaGlossario.assincrono,
  ),
  ItemGlossario(
    termo: 'try / catch / finally',
    sintaxe: 'try { } on Error catch (e) { } finally { }',
    significado:
        'Handles exceptions. `on` filters by type; `finally` always runs.',
    categoria: CategoriaGlossario.assincrono,
  ),
];
