import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao09Dart3En = Licao(
  id: 'dart-3',
  titulo: 'Dart 3: records, patterns and sealed',
  resumo: 'The additions that made Dart far more expressive.',
  nivel: NivelLicao.avancado,
  minutos: 12,
  objetivos: [
    'Return more than one value with records',
    'Destructure data with pattern matching',
    'Model state with sealed classes and exhaustive switches',
  ],
  blocos: [
    BlocoTitulo('Records: several values without writing a class'),
    BlocoTexto(
      'Before, returning two things meant writing a class or returning an '
      'untyped `List`. Now there is the **record**: a small typed bundle of '
      'values, created on the spot.',
    ),
    BlocoCodigo(
      r'''
// The return type is literally "(String, int)"
(String, int) findUser() {
  return ('Ana', 30);
}

final result = findUser();
print(result.$1); // Ana  ← position 1
print(result.$2); // 30   ← position 2

// With names it reads much better:
({String name, int age}) findNamed() {
  return (name: 'Leo', age: 25);
}

final u = findNamed();
print(u.name); // Leo
print(u.age);  // 25
''',
      saida: 'Ana\n30\nLeo\n25',
      legenda: 'Records are immutable and compared by VALUE (== works!).',
    ),
    BlocoTitulo('Destructuring'),
    BlocoCodigo(r'''
// Breaking the record straight into variables:
final (name, age) = findUser();
print('$name is $age years old');

// It works with lists and maps too:
final [first, second] = [10, 20];
final {'x': x, 'y': y} = {'x': 1, 'y': 2};

// And in for-in (remember .indexed?):
for (final (i, letter) in ['a', 'b'].indexed) {
  print('$i → $letter');
}
''', saida: 'Ana is 30 years old\n0 → a\n1 → b'),
    BlocoTitulo('Sealed classes: the CLOSED set of possibilities'),
    BlocoTexto(
      'A `sealed` class can only have subclasses in the same file. That way '
      'the compiler knows every case and **demands** that your `switch` covers '
      'each one. Add a new state tomorrow and forget to handle it, and the '
      'error shows up at compile time — not in production.',
    ),
    BlocoCodigo(
      r'''
sealed class ScreenState {}

final class Loading extends ScreenState {}

final class Loaded extends ScreenState {
  Loaded(this.items);
  final List<String> items;
}

final class Failed extends ScreenState {
  Failed(this.message);
  final String message;
}

String describe(ScreenState state) => switch (state) {
      Loading() => 'Loading...',
      Loaded(:final items) => '${items.length} items',  // destructures!
      Failed(:final message) => 'Failed: $message',
    };
''',
      legenda:
          'Note the `:final items` — the pattern pulls the field out for you. '
          'No `default`, and the compiler still guarantees nothing is missing.',
    ),
    BlocoDica(
      'This is exactly how this app\'s `Resultado<T>` type works. Open '
      '`core/utils/resultado.dart` and compare it with the example above.',
    ),
    BlocoTitulo('Patterns with a condition'),
    BlocoCodigo(
      r'''
String classify((int, int) point) => switch (point) {
      (0, 0) => 'origin',
      (final x, 0) => 'on the X axis at $x',
      (0, final y) => 'on the Y axis at $y',
      (final x, final y) when x == y => 'on the diagonal',
      _ => 'somewhere else',
    };

print(classify((0, 0)));   // origin
print(classify((5, 5)));   // on the diagonal
''',
      saida: 'origin\non the diagonal',
      legenda: '`when` adds an extra condition to the case.',
    ),
    BlocoTitulo('if-case: a pattern inside an if'),
    BlocoCodigo(
      r'''
final json = {'name': 'Ana', 'age': 30};

// Checks the shape AND extracts the values, all at once:
if (json case {'name': final String n, 'age': final int a}) {
  print('$n, $a years old');   // only reached when the types line up
} else {
  print('JSON is not in the expected shape');
}
''',
      saida: 'Ana, 30 years old',
      legenda: 'Great for validating JSON without a pile of ifs.',
    ),
    BlocoAviso(
      'Use `sealed` for **states and results**; use `enum` when the cases do '
      'not carry different data from one another.',
    ),
  ],
);
