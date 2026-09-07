import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao05ControleFluxoEn = Licao(
  id: 'controle-de-fluxo',
  titulo: 'Decisions and loops',
  resumo: 'if, ternary, for, while, classic switch and switch expressions.',
  nivel: NivelLicao.iniciante,
  minutos: 10,
  objetivos: [
    'Write readable conditions',
    'Pick the right loop for each situation',
    'Use switch as an expression (Dart 3)',
  ],
  blocos: [
    BlocoTitulo('if / else'),
    BlocoCodigo(
      r'''
final score = 7.5;

if (score >= 9) {
  print('Excellent');
} else if (score >= 6) {
  print('Pass');
} else {
  print('Resit');
}
''',
      saida: 'Pass',
      legenda: 'The condition must be a bool — there is no "if (1)" in Dart.',
    ),
    BlocoAviso(
      'In Dart, `if (someString)` **does not compile**. The condition has to '
      'be a real `bool`. Write `if (text.isNotEmpty)`.',
    ),
    BlocoTitulo('Ternary: an if on one line'),
    BlocoCodigo(
      r'''
final age = 20;

// condition ? ifTrue : ifFalse
final status = age >= 18 ? 'adult' : 'minor';

// Used constantly inside a Flutter build:
// child: loading ? CircularProgressIndicator() : ItemList()
''',
      legenda:
          'Great for choosing between two values. Do not nest them deeply.',
    ),
    BlocoTitulo('Logical operators'),
    BlocoTabela(
      cabecalho: ('Operator', 'Meaning'),
      linhas: [
        ('&&', 'AND — both sides must be true'),
        ('||', 'OR — one side being true is enough'),
        ('!', 'NOT — flips the value'),
        ('==  !=', 'Equal / not equal'),
        ('>  <  >=  <=', 'Numeric comparisons'),
      ],
    ),
    BlocoTitulo('The classic for'),
    BlocoCodigo(
      r'''
// for (setup; condition; step)
for (var i = 0; i < 3; i++) {
  print('Round $i');
}
''',
      saida: 'Round 0\nRound 1\nRound 2',
      legenda: 'Use it when the INDEX matters.',
    ),
    BlocoTitulo('for-in: the everyday one'),
    BlocoCodigo(
      r'''
final fruits = ['apple', 'grape', 'pear'];

for (final fruit in fruits) {
  print(fruit);
}

// Need the index too? Use asMap() or indexed (Dart 3):
for (final (index, fruit) in fruits.indexed) {
  print('$index: $fruit');
}
''',
      saida: 'apple\ngrape\npear\n0: apple\n1: grape\n2: pear',
      legenda: 'Use `final` for the loop variable: it never needs to change.',
    ),
    BlocoTitulo('while and do-while'),
    BlocoCodigo(
      r'''
var attempts = 0;

while (attempts < 3) {   // tests BEFORE
  attempts++;
}

do {                      // runs at least ONCE
  print('ran');
} while (false);
''',
      saida: 'ran',
      legenda: 'Use while when you do not know how many rounds there will be.',
    ),
    BlocoTitulo('break and continue'),
    BlocoCodigo(r'''
for (final n in [1, 2, 3, 4, 5]) {
  if (n == 2) continue; // skip THIS round
  if (n == 4) break;    // leave the loop entirely
  print(n);
}
''', saida: '1\n3'),
    BlocoTitulo('The classic switch'),
    BlocoCodigo(
      r'''
final day = 'saturday';

switch (day) {
  case 'saturday':
  case 'sunday':
    print('Weekend!');
  case 'monday':
    print('Hang in there.');
  default:
    print('Working day');
}
''',
      saida: 'Weekend!',
      legenda:
          'Since Dart 3 you no longer write `break` in every case — it does '
          'not fall through to the next one.',
    ),
    BlocoTitulo('switch as an EXPRESSION (Dart 3) 💎'),
    BlocoTexto(
      'Here the switch **returns a value** instead of running statements. It '
      'is shorter, and the compiler **forces** you to cover every case when '
      'the type is an enum or a sealed class.',
    ),
    BlocoCodigo(r'''
enum Status { loading, success, error }

String message(Status s) => switch (s) {
      Status.loading => 'Loading...',
      Status.success => 'All good',
      Status.error => 'Something broke.',
    };

// If you add Status.empty and forget to handle it here,
// Dart tells you: "The type 'Status' is not exhaustively matched".
''', legenda: 'Note the `=>` between case and value, and the trailing comma.'),
    BlocoCodigo(r'''
// It works with conditions (guards) too, using `when`:
String bracket(int age) => switch (age) {
      < 13 => 'child',
      < 18 => 'teenager',
      _ when age >= 60 => 'senior',
      _ => 'adult',
    };
''', legenda: 'The `_` is the "anything else" wildcard.'),
    BlocoDica(
      'Prefer `switch` over a ladder of `if/else` when you compare **the same '
      'variable** against several values. It reads better and the compiler '
      'helps you.',
    ),
  ],
);
