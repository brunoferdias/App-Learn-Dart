import '../../../domain/entities/arquivo_dart.dart';
import '../../../domain/repositories/playground_repositorio.dart';

const List<ArquivoDart> arquivosIniciaisEn = [
  ArquivoDart(
    id: 'main',
    nome: 'main.dart',
    conteudo: r'''
// Welcome to the mini-editor. Press ▶ Run to see the result.
// The greeting.dart tab holds a function — tabs share one scope,
// so you can call across them.

void main() {
  final name = 'Ana';
  print(greet(name));

  // Null safety in practice:
  String? nickname;
  print(nickname ?? 'no nickname');

  for (var i = 1; i <= 3; i++) {
    print('Round $i');
  }
}
''',
  ),
  ArquivoDart(
    id: 'saudacao',
    nome: 'greeting.dart',
    conteudo: r'''
// This function is used over in main.dart.

String greet(String name) {
  return 'Hello, $name! Welcome to Dart.';
}
''',
  ),
];

const List<ExemploPlayground> exemplosEn = [
  ExemploPlayground(
    titulo: 'Null safety',
    descricao: 'The ?., ??, ??= and ! operators in practice.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  String? nickname;

  // ?. → safe access (does not break when null)
  print(nickname?.length);

  // ?? → default value
  print(nickname ?? 'Guest');

  // ??= → only assigns when null
  nickname ??= 'Annie';
  nickname ??= 'Other';
  print(nickname);

  // Type promotion inside the if
  final maybe = findEmail('ana');
  if (maybe != null) {
    print('Email has ${maybe.length} letters');
  } else {
    print('No email');
  }

  // Uncomment to see the ! operator fail:
  // String? nothing;
  // print(nothing!.length);
}

String? findEmail(String user) {
  final db = {'ana': 'ana@example.com'};
  return db[user];
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Functions',
    descricao: 'Named and optional parameters, arrows and closures.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  print(twice(21));

  createButton(label: 'Save');
  createButton(label: 'Delete', color: 'red');

  print(greeting('Ana'));
  print(greeting('Ana', 'Dr.'));

  // A function stored in a variable
  final triple = (int n) => n * 3;
  print(triple(5));

  // Closure: the function remembers the total
  final count = counter();
  count();
  count();
  print(count());
}

int twice(int n) => n * 2;

void createButton({required String label, String color = 'blue'}) {
  print('Button "$label" ($color)');
}

String greeting(String name, [String? title]) {
  final prefix = title == null ? '' : '$title ';
  return 'Hello, $prefix$name!';
}

Function counter() {
  var total = 0;
  return () {
    total++;
    return total;
  };
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Lists and maps',
    descricao: 'map, where, fold and collection if/for.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  final numbers = [1, 2, 3, 4, 5, 6];

  print(numbers.where((n) => n % 2 == 0).toList());
  print(numbers.map((n) => n * 10).toList());
  print(numbers.fold(0, (total, n) => total + n));

  final prices = {'coffee': 5.0, 'cake': 8.5};
  print(prices['coffee']);
  print(prices['pizza']);  // null: the key is not there

  for (final entry in prices.entries) {
    print('${entry.key} costs ${entry.value}');
  }

  // collection if and for
  final isAdmin = true;
  final menu = [
    'Home',
    if (isAdmin) 'Panel',
    for (final n in [1, 2]) 'Item $n',
  ];
  print(menu);
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Classes',
    descricao: 'Fields, constructors, methods and getters.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  final ana = Person('Ana', 30);
  ana.introduce();
  print(ana.isAdult);

  final r = Rectangle(3, 4);
  print('Area: ${r.area}');
  print(r);
}

class Person {
  Person(this.name, this.age);

  final String name;
  final int age;

  bool get isAdult => age >= 18;

  void introduce() {
    print('$name, $age years old');
  }
}

class Rectangle {
  Rectangle(this.width, this.height);

  double width;
  double height;

  double get area => width * height;

  String toString() => 'Rectangle(${width}x$height)';
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Two files',
    descricao: 'How the tabs talk to each other.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
// The tabs share one global scope: whatever you declare in one,
// you can use in the other.

void main() {
  final cart = [
    Item('Coffee', 12.5),
    Item('Cake', 8.0),
    Item('Juice', 6.5),
  ];

  for (final item in cart) {
    print(item.label());
  }

  print('Total: ${formatMoney(sumTotal(cart))}');
}
''',
      ),
      ArquivoDart(
        id: 'modelo',
        nome: 'model.dart',
        conteudo: r'''
class Item {
  Item(this.name, this.price);

  final String name;
  final double price;

  String label() => '$name — ${formatMoney(price)}';
}

double sumTotal(List<Item> items) {
  return items.fold(0.0, (total, item) => total + item.price);
}
''',
      ),
      ArquivoDart(
        id: 'util',
        nome: 'util.dart',
        conteudo: r'''
String formatMoney(double value) {
  return '\$ ${value.toStringAsFixed(2)}';
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Broken on purpose',
    descricao: 'See how the editor points at each problem.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
// This code is broken on purpose.
// Run it, read the message, fix it and run again.

void main() {
  // 1) The semicolon is missing
  print('first')

  // 2) String does not accept null
  String name = null;

  // 3) Index out of range
  final list = [1, 2, 3];
  print(list[5]);

  // 4) The condition has to be a bool
  if ('text') {
    print('never gets here');
  }
}
''',
      ),
    ],
  ),
];
