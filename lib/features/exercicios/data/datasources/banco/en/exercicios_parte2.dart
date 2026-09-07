import '../../../../domain/entities/exercicio.dart';

const List<Exercicio> exerciciosParte2En = [
  ExercicioCertoOuErrado(
    id: 'e6-1',
    licaoId: 'colecoes',
    codigo: '''final list = [10, 20, 30];
print(list[3]);''',
    estaCorreto: false,
    explicacao:
        'Indexes start at 0. In a list of 3 items the valid ones are 0, 1 and '
        '2 — `list[3]` throws a RangeError. The last item is `list.last`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e6-2',
    licaoId: 'colecoes',
    enunciado: 'What is the type of `price` here?',
    codigo: '''final prices = <String, double>{'coffee': 5.0};
final price = prices['pizza'];''',
    opcoes: ['double?', 'double', 'null', 'dynamic'],
    resposta: 0,
    explicacao:
        'Reading from a Map always gives a nullable type, because the key may '
        'not exist. Here `price` is a `double?` holding null. Handle it with '
        '`?? 0`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e6-3',
    licaoId: 'colecoes',
    enunciado: 'What does this code print?',
    codigo: '''final n = [1, 2, 3, 4];
print(n.where((x) => x.isEven).map((x) => x * 10).toList());''',
    opcoes: ['[20, 40]', '[10, 20, 30, 40]', '[2, 4]', '[10, 30]'],
    resposta: 0,
    explicacao:
        'First `where` keeps the even numbers (2 and 4), then `map` multiplies '
        'each by 10. The order of the calls matters!',
  ),
  ExercicioCompletar(
    id: 'e6-4',
    licaoId: 'colecoes',
    enunciado: 'Fill in so the item is included only when `isAdmin` is true:',
    codigoComLacuna: '''final menu = [
  'Home',
  ___ (isAdmin) 'Panel',
];''',
    opcoes: ['if', 'when', 'case', 'for'],
    resposta: 0,
    explicacao:
        'The "collection if" lets you make an item conditional inside the list '
        'itself — it is what you use in `children:` in Flutter to show or hide '
        'a widget.',
  ),
  ExercicioCertoOuErrado(
    id: 'e6-5',
    licaoId: 'colecoes',
    codigo: '''final users = <String>[];
final found = users.firstWhere((u) => u == 'ana');''',
    estaCorreto: false,
    explicacao:
        '`firstWhere` without an `orElse` throws a StateError when nothing '
        'matches. Use `.where(...).firstOrNull` and handle the `null`.',
  ),

  ExercicioCertoOuErrado(
    id: 'e7-1',
    licaoId: 'classes-e-objetos',
    codigo: '''class Product {
  const Product(this.name);
  String name;
}''',
    estaCorreto: false,
    explicacao:
        'A `const` constructor requires ALL fields to be `final`. Change it to '
        '`final String name;`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e7-2',
    licaoId: 'classes-e-objetos',
    enunciado: 'Which keyword adds ready-made behaviour without inheritance?',
    opcoes: ['with (mixin)', 'implements', 'extends', 'abstract'],
    resposta: 0,
    explicacao:
        '`with` applies a mixin: reusable code you "mix into" the class. '
        '`extends` is inheritance (only one), and `implements` copies only the '
        'contract — you rewrite everything.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e7-3',
    licaoId: 'classes-e-objetos',
    enunciado: 'What does this code print?',
    codigo: '''class R {
  R(this.w, this.h);
  double w, h;
  double get area => w * h;
}

print(R(3, 4).area);''',
    opcoes: ['12.0', '12', 'Instance of R', 'Error: missing ()'],
    resposta: 0,
    explicacao:
        'A getter is read WITHOUT parentheses. Since the fields are `double`, '
        'the result comes out as `12.0`.',
  ),
  ExercicioCompletar(
    id: 'e7-4',
    licaoId: 'classes-e-objetos',
    enunciado: 'Fill in to call the parent class constructor:',
    codigoComLacuna: '''class Dog extends Animal {
  Dog(___ name);
}''',
    opcoes: ['super.', 'this.', 'parent.', 'base.'],
    resposta: 0,
    explicacao:
        '`super.name` forwards the parameter straight to the parent '
        'constructor — the modern shorthand replacing '
        '`Dog(String name) : super(name);`.',
  ),
  ExercicioCompletar(
    id: 'e7-5',
    licaoId: 'classes-e-objetos',
    enunciado: 'Fill in to add a method to the String type:',
    codigoComLacuna: '''___ TextUtil on String {
  bool get isEmail => contains('@');
}''',
    opcoes: ['extension', 'mixin', 'class', 'abstract class'],
    resposta: 0,
    explicacao:
        '`extension X on Type` adds methods and getters to a type you did not '
        'write, without inheriting from it or wrapping it.',
  ),

  ExercicioCertoOuErrado(
    id: 'e8-1',
    licaoId: 'assincronia',
    codigo: '''void main() {
  final name = await fetchName();
  print(name);
}''',
    estaCorreto: false,
    explicacao:
        '`await` can only be used inside a function marked `async`. The '
        'correct form is `void main() async { ... }`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e8-2',
    licaoId: 'assincronia',
    enunciado: 'What gets printed if you FORGET the `await`?',
    codigo: '''Future<String> fetch() async => 'Ana';

void main() async {
  final name = fetch();
  print(name);
}''',
    opcoes: ["Instance of 'Future<String>'", 'Ana', 'null', 'A compile error'],
    resposta: 0,
    explicacao:
        'Without `await` you store the PROMISE, not the value. This is the '
        'single most common async bug there is.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e8-3',
    licaoId: 'assincronia',
    enunciado:
        'Two fetches take 2 seconds each and are independent. Which form '
        'finishes in about 2s in total?',
    opcoes: [
      'await Future.wait([fetchA(), fetchB()])',
      'await fetchA(); await fetchB();',
      'fetchA(); fetchB();',
      'await fetchA().then(fetchB)',
    ],
    resposta: 0,
    explicacao:
        '`Future.wait` fires both at once and waits for both. Two `await`s in '
        'a row run in sequence: 4 seconds.',
  ),
  ExercicioCompletar(
    id: 'e8-4',
    licaoId: 'assincronia',
    enunciado: 'Fill in the block that ALWAYS runs, error or no error:',
    codigoComLacuna: '''try {
  await load();
} catch (e) {
  print(e);
} ___ {
  hideLoading();
}''',
    opcoes: ['finally', 'always', 'else', 'on'],
    resposta: 0,
    explicacao:
        '`finally` runs in every scenario — ideal for hiding a loading '
        'indicator or closing connections.',
  ),
  ExercicioCompletar(
    id: 'e8-5',
    licaoId: 'assincronia',
    enunciado: 'Complete the function that returns a Stream:',
    codigoComLacuna: '''Stream<int> count() async* {
  for (var i = 0; i < 3; i++) {
    ___ i;
  }
}''',
    opcoes: ['yield', 'return', 'await', 'emit'],
    resposta: 0,
    explicacao:
        'In an `async*` function, `yield` drops one more value onto the Stream '
        'without ending the function. `return` would end it for good.',
  ),

  ExercicioMultiplaEscolha(
    id: 'e9-1',
    licaoId: 'dart-3',
    enunciado: 'What does this code print?',
    codigo: '''(String, int) data() => ('Ana', 30);

void main() {
  final (name, age) = data();
  print('\$name-\$age');
}''',
    opcoes: ['Ana-30', '(Ana, 30)', 'name-age', 'An error'],
    resposta: 0,
    explicacao:
        'This is record destructuring: `name` takes the first field and `age` '
        'the second, each already correctly typed.',
  ),
  ExercicioCertoOuErrado(
    id: 'e9-2',
    licaoId: 'dart-3',
    codigo: '''sealed class State {}
final class Ok extends State {}
final class Failed extends State {}

String txt(State e) => switch (e) {
      Ok() => 'ok',
    };''',
    estaCorreto: false,
    explicacao:
        'The switch is not exhaustive: the `Failed()` case is missing. Because '
        'the class is `sealed`, the compiler knows every subclass and holds '
        'you to it — exactly the behaviour we want.',
  ),
  ExercicioCompletar(
    id: 'e9-3',
    licaoId: 'dart-3',
    enunciado: 'Fill in to extract the field inside the pattern:',
    codigoComLacuna: '''String txt(State e) => switch (e) {
      Ok() => 'ok',
      Failed(___ msg) => 'error: \$msg',
    };''',
    opcoes: [':final', 'final', 'var', 'this.'],
    resposta: 0,
    explicacao:
        '`Failed(:final msg)` is the shorthand that pulls the `msg` field out '
        'of the object into a variable of the same name.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e9-4',
    licaoId: 'dart-3',
    enunciado: 'When should you prefer a `sealed class` over an `enum`?',
    opcoes: [
      'When each case carries different data',
      'Always, enum is obsolete',
      'When there are more than 5 cases',
      'When the cases are just text labels',
    ],
    resposta: 0,
    explicacao:
        'Enums are ideal for fixed labels with no data of their own. Sealed '
        'classes shine when each case has distinct fields — like '
        'Loaded(items) and Failed(message).',
  ),

  ExercicioMultiplaEscolha(
    id: 'e10-1',
    licaoId: 'clean-architecture',
    enunciado: 'Which import should NOT exist in the domain layer?',
    opcoes: [
      "import 'package:flutter/cupertino.dart';",
      "import '../entities/licao.dart';",
      "import '../../../core/utils/resultado.dart';",
      "import 'dart:async';",
    ],
    resposta: 0,
    explicacao:
        'The domain is pure Dart: no Flutter. If it knew about widgets, the '
        'business rules would be tied to the interface and hard to test.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e10-2',
    licaoId: 'clean-architecture',
    enunciado: 'Where does "the data comes from memory or from an API" live?',
    opcoes: [
      'In the data source, inside the data layer',
      'In the use case',
      'In the page (presentation)',
      'In the entity',
    ],
    resposta: 0,
    explicacao:
        'The data source is the only piece that knows the real origin. That is '
        'why swapping memory for an API affects no other layer.',
  ),
  ExercicioCertoOuErrado(
    id: 'e10-3',
    licaoId: 'clean-architecture',
    codigo: '''// domain/usecases/listar_licoes.dart
class ListarLicoes {
  const ListarLicoes(this._repo);
  final LicaoRepositorioImpl _repo; // concrete implementation
}''',
    estaCorreto: false,
    explicacao:
        'The use case must depend on the ABSTRACTION (`LicaoRepositorio`), not '
        'the implementation. That way the domain never knows the data layer — '
        'and in tests you can inject a fake repository.',
  ),
  ExercicioCompletar(
    id: 'e10-4',
    licaoId: 'clean-architecture',
    enunciado: 'Complete the repository contract declaration:',
    codigoComLacuna: '''___ LicaoRepositorio {
  Future<Resultado<List<Licao>>> listarTodas();
}''',
    opcoes: [
      'abstract interface class',
      'final class',
      'sealed class',
      'mixin',
    ],
    resposta: 0,
    explicacao:
        '`abstract interface class` (Dart 3) declares something built purely '
        'to be implemented: it cannot become an object and cannot be extended, '
        'only `implements`.',
  ),
];
