import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao04FuncoesEn = Licao(
  id: 'funcoes',
  titulo: 'Functions, end to end',
  resumo:
      'Anatomy, arrow syntax, positional, optional and named parameters, '
      'anonymous functions, closures and functions that take functions.',
  nivel: NivelLicao.iniciante,
  minutos: 18,
  objetivos: [
    'Read and write any Dart function signature',
    'Choose between positional, optional and named parameters',
    'Use arrow (=>) without confusing it with a { } block',
    'Understand anonymous functions, closures and higher order functions',
  ],
  blocos: [
    BlocoTexto(
      'A function is a **named piece of code** you can call as many times as '
      'you like. In Dart, functions are also **values**: you can store them in '
      'variables, pass them as arguments and return them from other functions.',
    ),
    BlocoTitulo('1. Anatomy of a function'),
    BlocoCodigo(
      r'''
int sum(int a, int b) {
  return a + b;
}
// ↑   ↑    ↑            ↑
// │   │    │            └─ body: what it does
// │   │    └─ parameters: what it takes (typed!)
// │   └─ name: lowerCamelCase, starting with a verb
// └─ return type: what it gives back
''',
      legenda:
          'Read it back to front: "sum takes two ints and returns an int".',
    ),
    BlocoTabela(
      cabecalho: ('Return type', 'When to use it'),
      linhas: [
        ('int, String, bool…', 'The function gives back a value of that type'),
        ('void', 'The function only DOES something, returns nothing'),
        ('String?', 'May return text OR null'),
        ('Future<T>', 'Returns later (async) — see the async lesson'),
        (
          '(nothing written)',
          'Becomes dynamic — avoid it, always write the type',
        ),
      ],
    ),
    BlocoTitulo('2. Arrow: the one-line function'),
    BlocoTexto(
      'When the body is **a single expression**, swap `{ return x; }` for '
      '`=> x`. Same thing, written short.',
    ),
    BlocoCodigo(r'''
// Long form
int double_(int n) {
  return n * 2;
}

// Arrow form — identical behaviour
int doubleShort(int n) => n * 2;

// Arrow works with void too
void log(String msg) => print('[LOG] $msg');
''', legenda: '=> literally means "return this".'),
    BlocoAviso(
      'Do not write `=> { return n * 2; }`. Braces after the arrow create an '
      '**empty map**, not a block — a classic beginner error.',
    ),
    BlocoTitulo('3. Required POSITIONAL parameters'),
    BlocoCodigo(
      r'''
void introduce(String name, int age) {
  print('$name is $age years old');
}

introduce('Ana', 30);   // ✅ the ORDER matters
// introduce(30, 'Ana'); // ❌ swapped types: compile error
// introduce('Ana');     // ❌ missing an argument
''',
      legenda: 'The default: mandatory, in exact order.',
      saida: 'Ana is 30 years old',
    ),
    BlocoTitulo('4. Optional POSITIONAL parameters  [ ]'),
    BlocoTexto(
      'Square brackets make a parameter optional. Since nothing may come in, '
      'the type has to accept null (`String?`) **or** carry a default.',
    ),
    BlocoCodigo(
      r'''
String greeting(String name, [String? title, String mark = '!']) {
  final prefix = title == null ? '' : '$title ';
  return 'Hello, $prefix$name$mark';
}

print(greeting('Ana'));                // Hello, Ana!
print(greeting('Ana', 'Dr.'));         // Hello, Dr. Ana!
print(greeting('Ana', 'Dr.', '...'));  // Hello, Dr. Ana...
''',
      legenda: 'You can only leave out arguments from the END backwards.',
      saida: 'Hello, Ana!\nHello, Dr. Ana!\nHello, Dr. Ana...',
    ),
    BlocoTitulo('5. NAMED parameters  { }  ← the Flutter favourite'),
    BlocoTexto(
      'With braces, the caller writes the parameter name. Order stops '
      'mattering and the code becomes **self-explanatory**. That is why every '
      'Flutter widget uses them.',
    ),
    BlocoCodigo(r'''
void createButton({
  required String label,     // mandatory
  Color color = Colors.blue, // optional with a default
  VoidCallback? onTap,       // optional, may be null
}) {
  print('Button "$label"');
}

// Order does not matter and every argument explains itself:
createButton(label: 'Save');
createButton(color: Colors.red, label: 'Delete');
''', legenda: '`required` makes it mandatory; without it, it is optional.'),
    BlocoComparacao(
      codigoErrado: r'''
void createButton({String label}) {}
// ❌ ERROR: "The parameter 'label' can't have
// a value of null because of its type"''',
      notaErrado:
          'A named parameter is optional by default. If the type does not '
          'accept null, Dart makes you resolve that.',
      codigoCerto: r'''
void createButton({required String label}) {}
// or
void createButton({String label = 'OK'}) {}
// or
void createButton({String? label}) {}''',
      notaCerto: 'Three valid ways out: require it, default it, or allow null.',
    ),
    BlocoTitulo('6. Mixing all three'),
    BlocoCodigo(
      r'''
// Rule: required positional parameters ALWAYS come first.
void send(
  String to, {              // required positional
  required String message,  // required named
  bool urgent = false,      // named with a default
  String? signature,        // nullable named
}) {
  final flag = urgent ? '🔴 ' : '';
  print('$flag$to: $message ${signature ?? ""}');
}

send('ana@x.com', message: 'Hi!', urgent: true);
''',
      saida: '🔴 ana@x.com: Hi! ',
      legenda: 'You CANNOT use [ ] and { } in the same function — pick one.',
    ),
    BlocoTitulo('7. Anonymous functions (lambdas)'),
    BlocoTexto(
      'A function with no name, created on the spot. You use these constantly '
      'with lists and with button callbacks.',
    ),
    BlocoCodigo(r'''
final names = ['ana', 'leo', 'bia'];

// Anonymous function with a block
names.forEach((name) {
  print(name.toUpperCase());
});

// Anonymous function with an arrow (same thing, shorter)
names.forEach((name) => print(name.toUpperCase()));

// Storing a function inside a variable
final int Function(int) triple = (n) => n * 3;
print(triple(5)); // 15

// Tear-off: pass the function by NAME, no parentheses
names.forEach(print); // same as (n) => print(n)
''', legenda: '`int Function(int)` is the TYPE of a function.'),
    BlocoTitulo('8. Higher order functions'),
    BlocoTexto(
      'These are functions that **take** or **return** other functions. It '
      'sounds fancy, but you already use them: `map`, `where` and `onPressed` '
      'all work this way.',
    ),
    BlocoCodigo(r'''
// Takes a function as a parameter
void repeat(int times, void Function(int) action) {
  for (var i = 1; i <= times; i++) {
    action(i);
  }
}

repeat(3, (i) => print('Round $i'));

// Returns a function
Function(int) multiplierOf(int factor) {
  return (int n) => n * factor;
}

final doubler = multiplierOf(2);
print(doubler(10)); // 20
''', saida: 'Round 1\nRound 2\nRound 3\n20'),
    BlocoTitulo('9. Closures: the function that remembers'),
    BlocoTexto(
      'A function created inside another one **keeps** the variables from '
      'where it was born, even after the outer function has finished. That is '
      'a closure.',
    ),
    BlocoCodigo(
      r'''
Function counter() {
  var total = 0;        // lives "inside" the closure
  return () {
    total++;            // survives between calls!
    print('Call no. $total');
  };
}

final count = counter();
count(); // Call no. 1
count(); // Call no. 2
count(); // Call no. 3
''',
      saida: 'Call no. 1\nCall no. 2\nCall no. 3',
      legenda: 'Every call to counter() creates its own independent total.',
    ),
    BlocoTitulo('10. typedef: a nickname for function types'),
    BlocoCodigo(r'''
// Without typedef — a huge signature, repeated everywhere:
void onChange(void Function(String text, bool valid) callback) {}

// With typedef — readable:
typedef TextValidator = void Function(String text, bool valid);

void onChangeClean(TextValidator callback) {}
''', legenda: 'Flutter does this: `VoidCallback` is `void Function()`.'),
    BlocoTitulo('11. Generic functions'),
    BlocoCodigo(r'''
// <T> = "works with any type, and I return the SAME type"
T first<T>(List<T> list) => list.first;

final n = first<int>([1, 2, 3]);   // n is an int
final s = first(['a', 'b']);       // s is a String (inferred!)
''', legenda: 'Generics save you from duplicating a function per type.'),
    BlocoDica(
      'Function names describe an ACTION: `calculateTotal`, `findUser`, '
      '`validateEmail`. If the name has an "and" in it (`saveAndSend`), it is '
      'probably two functions.',
    ),
    BlocoTitulo('Quick reference'),
    BlocoTabela(
      cabecalho: ('Syntax', 'Meaning'),
      linhas: [
        ('f(a, b)', 'Required positional'),
        ('f(a, [b])', 'b is optional positional'),
        ('f({a, b})', 'a and b are optional named'),
        ('f({required a})', 'a is a required named parameter'),
        ('f({a = 1})', 'a is named with a default value'),
        ('=> x', 'Single-expression body (implicit return)'),
        ('(x) => x * 2', 'Anonymous function'),
        (
          'int Function(int)',
          'Type "function taking an int, returning an int"',
        ),
      ],
    ),
  ],
);
