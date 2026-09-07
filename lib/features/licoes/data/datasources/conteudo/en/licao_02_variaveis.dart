import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao02VariaveisEn = Licao(
  id: 'variaveis-e-tipos',
  titulo: 'Variables and types',
  resumo: 'var, final, const, the basic types and string interpolation.',
  nivel: NivelLicao.iniciante,
  minutos: 8,
  objetivos: [
    'Choose between var, final and const without hesitating',
    'Know int, double, String, bool, List and Map',
    'Build text with interpolation instead of adding Strings',
  ],
  blocos: [
    BlocoTexto(
      'A variable is a **named box** that holds a value. In Dart you can '
      'either state the type of the box or let Dart work it out.',
    ),
    BlocoCodigo(r'''
// 1) Explicit type — you write the type.
String name = 'Ana';

// 2) Inference — Dart figures out on its own that it is a String.
var city = 'Recife';

// 3) final — the value is set ONCE and never changes again.
final int age = 25;

// 4) const — on top of never changing, it is known at COMPILE time.
const double pi = 3.14;
''', legenda: 'Four ways to declare. All of them correct.'),
    BlocoTitulo('final vs const: the classic doubt'),
    BlocoTexto(
      'Both stop the variable from being reassigned. The difference is **when** '
      'the value is known: `const` has to be known at compile time; `final` may '
      'only be discovered once the app runs.',
    ),
    BlocoCodigo(r'''
final now = DateTime.now(); // ✅ can only be known at run time
// const now = DateTime.now(); // ❌ ERROR: not a compile-time constant

const rate = 0.15;          // ✅ the value is right there
''', legenda: 'Rule of thumb: always use final; use const when you can.'),
    BlocoDica(
      'Start everything as `final`. Only switch to `var` when the compiler '
      'tells you that you really do need to reassign. Code with fewer mutable '
      'variables has fewer bugs.',
    ),
    BlocoTitulo('The basic types'),
    BlocoTabela(
      cabecalho: ('Type', 'What it is for'),
      linhas: [
        ('int', 'Whole number: 1, 42, -7'),
        ('double', 'Number with decimals: 3.14, 0.5'),
        ('num', 'Parent of the two above: accepts int OR double'),
        ('String', 'Text: \'hi\' or "hi"'),
        ('bool', 'Only true or false'),
        ('List<T>', 'Ordered list: [1, 2, 3]'),
        ('Set<T>', 'Set with no repeats: {1, 2}'),
        ('Map<K,V>', 'Key→value pairs: {\'a\': 1}'),
        ('dynamic', 'Turns type checking off — avoid it'),
      ],
    ),
    BlocoCodigo(r'''
int likes = 120;
double score = 9.5;
bool active = true;
String title = 'Learn Dart';
List<String> tags = ['dart', 'flutter'];
Map<String, int> board = {'Ana': 10, 'Leo': 8};

// Conversions
int whole = int.parse('42');          // text → int
double decimal = double.parse('3.5'); // text → double
String text = 42.toString();          // int → text
int rounded = 9.7.round();            // 10
''', legenda: 'The types you will use 95% of the time.'),
    BlocoTitulo('Interpolation: building text'),
    BlocoCodigo(
      r'''
final name = 'Ana';
final items = 3;

// ❌ The laborious way
print('Hello ' + name + ', you have ' + items.toString() + ' items');

// ✅ Interpolation with $
print('Hello $name, you have $items items');

// For expressions (a dot, some maths, a call), use ${...}
print('Uppercase: ${name.toUpperCase()}');
print('Double: ${items * 2}');
''',
      legenda: 'The dollar sign pulls the value straight into the text.',
      saida: 'Hello Ana, you have 3 items\nUppercase: ANA\nDouble: 6',
    ),
    BlocoAviso(
      'Use `\$variable` only for plain names. If there is a dot, parentheses '
      'or arithmetic, you need the braces: `\${object.field}`.',
    ),
    BlocoTitulo('Careful with dynamic'),
    BlocoComparacao(
      codigoErrado: r'''
dynamic value = 'text';
value = 10;
print(value.length); // 💥 blows up only at RUN time''',
      notaErrado:
          '`dynamic` switches the compiler\'s protection off. The error only '
          'shows up once the app is in someone else\'s hands.',
      codigoCerto: r'''
String value = 'text';
print(value.length); // 4 — safe''',
      notaCerto:
          'With a declared type, the IDE warns you before you even hit save.',
    ),
    BlocoTexto(
      'There is also `Object?`, which accepts anything **without** switching '
      'checking off: to use the value you are forced to check its type first. '
      'It is the safe alternative to `dynamic`.',
    ),
  ],
);
