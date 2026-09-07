import '../../../../domain/entities/exercicio.dart';

const List<Exercicio> exerciciosParte1En = [
  ExercicioCertoOuErrado(
    id: 'e1-1',
    licaoId: 'primeiros-passos',
    codigo: '''void main() {
  print('Hello, Dart!')
}''',
    estaCorreto: false,
    explicacao:
        'The semicolon at the end of the print line is missing. In Dart the '
        '`;` is mandatory at the end of every statement.',
  ),
  ExercicioCertoOuErrado(
    id: 'e1-2',
    licaoId: 'primeiros-passos',
    codigo: '''void Main() {
  print('Hi');
}''',
    estaCorreto: false,
    explicacao:
        'Dart is case sensitive. The entry point has to be called exactly '
        '`main` — with a capital M it is just an ordinary function, and the '
        'program has nowhere to start.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e1-3',
    licaoId: 'primeiros-passos',
    enunciado: 'What is the three-slash comment `///` for?',
    opcoes: [
      'Writing documentation the IDE shows on hover',
      'Commenting out several lines at once',
      'Making Dart ignore the whole file',
      'Nothing, it is the same as `//`',
    ],
    resposta: 0,
    explicacao:
        '`///` is the documentation comment (DartDoc). It becomes the help '
        'text your IDE shows, and it can generate a documentation site.',
  ),
  ExercicioCompletar(
    id: 'e1-4',
    licaoId: 'primeiros-passos',
    codigoComLacuna: '''___ main() {
  print('Started');
}''',
    opcoes: ['void', 'String', 'int', 'var'],
    resposta: 0,
    explicacao:
        '`void` means "gives nothing back". The main function normally returns '
        'no value at all, so `void main()` is the standard signature.',
  ),

  ExercicioCertoOuErrado(
    id: 'e2-1',
    licaoId: 'variaveis-e-tipos',
    codigo: '''final name = 'Ana';
name = 'Bia';''',
    estaCorreto: false,
    explicacao:
        'A `final` variable takes a value ONCE. The second assignment is a '
        'compile error. If it needs to change, use `var`.',
  ),
  ExercicioCertoOuErrado(
    id: 'e2-2',
    licaoId: 'variaveis-e-tipos',
    codigo: '''const now = DateTime.now();''',
    estaCorreto: false,
    explicacao:
        '`const` demands a value known at COMPILE time, and the current time '
        'only exists once the app runs. `final` is the right choice here.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e2-3',
    licaoId: 'variaveis-e-tipos',
    enunciado: 'What does this code print?',
    codigo: '''final name = 'Ana';
print('Hi, \${name.toUpperCase()}!');''',
    opcoes: [
      r'Hi, ANA!',
      r'Hi, ${name.toUpperCase()}!',
      r'Hi, Ana!',
      'An error',
    ],
    resposta: 0,
    explicacao:
        'The braces `\${...}` let you drop an EXPRESSION into the text. '
        '`toUpperCase()` returns the text in capitals.',
  ),
  ExercicioCompletar(
    id: 'e2-4',
    licaoId: 'variaveis-e-tipos',
    enunciado: 'Fill in the blank so it prints "Total: 30":',
    codigoComLacuna: '''final price = 10;
final qty = 3;
print('Total: ___');''',
    opcoes: [
      r'${price * qty}',
      r'$price * qty',
      r'price * qty',
      r'$(price*qty)',
    ],
    resposta: 0,
    explicacao:
        'Calculations inside a String need the braces: `\${price * qty}`. With '
        'just `\$price * qty` Dart substitutes only the variable and leaves '
        '" * qty" as literal text.',
  ),

  ExercicioCertoOuErrado(
    id: 'e3-1',
    licaoId: 'null-safety',
    codigo: '''String name = null;''',
    estaCorreto: false,
    explicacao:
        'With null safety, `String` NEVER accepts null. To allow empty, write '
        '`String? name = null;`.',
  ),
  ExercicioCertoOuErrado(
    id: 'e3-2',
    licaoId: 'null-safety',
    codigo: '''String? nickname;
print(nickname?.length ?? 0);''',
    estaCorreto: true,
    explicacao:
        'Exactly right: `?.` skips the access when it is null (returning '
        'null) and `??` supplies the default 0. No risk of a crash.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e3-3',
    licaoId: 'null-safety',
    enunciado: 'What does this code print?',
    codigo: '''String? name;
name ??= 'Guest';
name ??= 'Other';
print(name);''',
    opcoes: ['Guest', 'Other', 'null', 'A compile error'],
    resposta: 0,
    explicacao:
        '`??=` only assigns when the variable is null. On the first line it '
        'was, so it became "Guest". On the second it already had a value, so '
        'the statement was skipped.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e3-4',
    licaoId: 'null-safety',
    enunciado: 'What is wrong with this code?',
    codigo: '''String? find() => null;

void main() {
  print(find()!.length);
}''',
    opcoes: [
      'The `!` promises it is not null, but it is — the app crashes at run time',
      'Nothing, it works fine',
      'main is missing the async keyword',
      '`length` does not exist on String',
    ],
    resposta: 0,
    explicacao:
        'The `!` switches the protection off. Since the function really does '
        'return null, the app throws "Null check operator used on a null '
        'value". Use `?.` with `??`, or check with an `if`.',
  ),
  ExercicioCompletar(
    id: 'e3-5',
    licaoId: 'null-safety',
    enunciado: 'Fill in the blank to use the e-mail with a fallback:',
    codigoComLacuna: '''String? email;
final display = email ___ 'no e-mail';''',
    opcoes: ['??', '?.', '!', '||'],
    resposta: 0,
    explicacao:
        '`??` means "if the left side is null, use the right one". `?.` is for '
        'ACCESSING members safely, not for supplying a default.',
  ),
  ExercicioCompletar(
    id: 'e3-6',
    licaoId: 'null-safety',
    enunciado: 'Fill in so the field is non-nullable, but filled in later:',
    codigoComLacuna: '''class Screen {
  ___ final String title;

  void start() {
    title = 'Ready';
  }
}''',
    opcoes: ['late', 'const', 'static', 'dynamic'],
    resposta: 0,
    explicacao:
        '`late final` means "I swear I will fill it in before anyone reads '
        'it". The field stays a `String` (never null) without needing a value '
        'in the constructor.',
  ),

  ExercicioCertoOuErrado(
    id: 'e4-1',
    licaoId: 'funcoes',
    codigo: '''int twice(int n) => { return n * 2; };''',
    estaCorreto: false,
    explicacao:
        'After `=>` comes a SINGLE expression, with no braces and no '
        '`return`. The braces there create a map. The correct form is '
        '`int twice(int n) => n * 2;`.',
  ),
  ExercicioCertoOuErrado(
    id: 'e4-2',
    licaoId: 'funcoes',
    codigo: '''void create({String name}) {
  print(name);
}''',
    estaCorreto: false,
    explicacao:
        'A named parameter is optional by default, so it could arrive null — '
        'and `String` does not accept null. Use `required String name`, or '
        '`String? name`, or a default value.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e4-3',
    licaoId: 'funcoes',
    enunciado: 'Which call is VALID for this function?',
    codigo:
        '''void send(String to, {required String text, bool urgent = false}) {}''',
    opcoes: [
      "send('ana@x.com', text: 'Hi')",
      "send(text: 'Hi', 'ana@x.com')",
      "send('ana@x.com', 'Hi')",
      "send(to: 'ana@x.com', text: 'Hi')",
    ],
    resposta: 0,
    explicacao:
        '`to` is positional (it comes first, without a name) and `text` is a '
        'required named parameter. `urgent` has a default, so it can be left '
        'out.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e4-4',
    licaoId: 'funcoes',
    enunciado: 'What does this code print?',
    codigo: '''Function counter() {
  var n = 0;
  return () => ++n;
}

void main() {
  final c = counter();
  c();
  c();
  print(c());
}''',
    opcoes: ['3', '1', '0', 'null'],
    resposta: 0,
    explicacao:
        'This is a CLOSURE: the returned function keeps the variable `n` from '
        'where it was born. Each call increments the same `n`: 1, 2 and '
        'finally 3.',
  ),
  ExercicioCompletar(
    id: 'e4-5',
    licaoId: 'funcoes',
    enunciado: 'Fill in to make the named parameter MANDATORY:',
    codigoComLacuna: '''void createButton({___ String label}) {
  print(label);
}''',
    opcoes: ['required', 'final', 'late', 'const'],
    resposta: 0,
    explicacao:
        '`required` forces the caller to pass the argument. It is what every '
        'Flutter widget does with its essential parameters.',
  ),
  ExercicioCompletar(
    id: 'e4-6',
    licaoId: 'funcoes',
    enunciado: 'Fill in the type of this variable that holds a function:',
    codigoComLacuna: '''___ triple = (n) => n * 3;
print(triple(5)); // 15''',
    opcoes: ['int Function(int)', 'Function<int>', 'int(int)', 'var Function'],
    resposta: 0,
    explicacao:
        'A function type is written `Return Function(Parameters)`. Here: takes '
        'an int and returns an int.',
  ),

  ExercicioCertoOuErrado(
    id: 'e5-1',
    licaoId: 'controle-de-fluxo',
    codigo: '''final name = 'Ana';
if (name) {
  print('has a name');
}''',
    estaCorreto: false,
    explicacao:
        'In Dart the `if` condition has to be a `bool`. There is no "truthy '
        'value" as in JavaScript. The correct form: `if (name.isNotEmpty)`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e5-2',
    licaoId: 'controle-de-fluxo',
    enunciado: 'What does this loop print?',
    codigo: '''for (final n in [1, 2, 3, 4]) {
  if (n == 2) continue;
  if (n == 4) break;
  print(n);
}''',
    opcoes: ['1 and 3', '1, 2 and 3', '1, 3 and 4', 'Only 1'],
    resposta: 0,
    explicacao:
        '`continue` skips just that round (2 is never printed) and `break` '
        'ends the whole loop before 4 can be printed.',
  ),
  ExercicioCompletar(
    id: 'e5-3',
    licaoId: 'controle-de-fluxo',
    enunciado: 'Complete the switch expression:',
    codigoComLacuna: '''enum Status { ok, error }

String msg(Status s) ___ switch (s) {
      Status.ok => 'All good',
      Status.error => 'Failed',
    };''',
    opcoes: ['=>', '=', '{', ':'],
    resposta: 0,
    explicacao:
        'The function returns the result of the switch as a single '
        'expression, so we use the arrow `=>`. Note the `;` at the end and the '
        'commas between cases — this is expression syntax, not block syntax.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e5-4',
    licaoId: 'controle-de-fluxo',
    enunciado:
        'You add `Status.loading` to the enum and forget to handle it in the '
        'switch expression. What happens?',
    opcoes: [
      'The compiler reports that the switch is not exhaustive',
      'The app runs and returns null for that case',
      'Nothing, Dart uses the first case',
      'It throws an exception only in production',
    ],
    resposta: 0,
    explicacao:
        'That is the great advantage of a switch expression over an enum or a '
        'sealed class: the error shows up at compile time, not in your user\'s '
        'hands.',
  ),
];
