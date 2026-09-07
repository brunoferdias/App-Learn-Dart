import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao07ClassesEn = Licao(
  id: 'classes-e-objetos',
  titulo: 'Classes and objects',
  resumo: 'Constructors, getters, inheritance, abstract, mixin and extension.',
  nivel: NivelLicao.intermediario,
  minutos: 16,
  objetivos: [
    'Write classes with clear, immutable constructors',
    'Tell extends, implements, with and abstract apart',
    'Use getters, static, factory and extension',
  ],
  blocos: [
    BlocoTexto(
      'A class is the **blueprint** of an object: it says what data the object '
      'holds and what it knows how to do. An object is the house built from '
      'that blueprint.',
    ),
    BlocoTitulo('1. Class and constructor'),
    BlocoCodigo(
      r'''
class User {
  // Fields (what the object holds)
  final String name;
  final int age;

  // Constructor. `this.name` is shorthand for "take it and store it".
  User(this.name, this.age);

  // Method (what the object does)
  void introduce() => print('$name, $age years old');
}

void main() {
  final ana = User('Ana', 30); // `new` has been optional since Dart 2
  ana.introduce();             // Ana, 30 years old
}
''',
      saida: 'Ana, 30 years old',
      legenda: '`final` fields = immutable object, the recommended default.',
    ),
    BlocoTitulo('2. Constructor with named parameters (Flutter style)'),
    BlocoCodigo(
      r'''
class Product {
  const Product({
    required this.name,
    required this.price,
    this.description,     // String? → optional
    this.inStock = true,  // default value
  });

  final String name;
  final double price;
  final String? description;
  final bool inStock;
}

const p = Product(name: 'Coffee', price: 12.9);
''',
      legenda:
          'A `const` constructor is only possible when ALL fields are `final`.',
    ),
    BlocoTitulo('3. Named constructors and factories'),
    BlocoCodigo(r'''
class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  // NAMED constructor: a shortcut with a name of its own.
  Point.origin() : x = 0, y = 0;

  // FACTORY: it gets to decide what to return (even an existing object,
  // or a subclass). Very common for building an object from JSON.
  factory Point.fromMap(Map<String, dynamic> json) {
    return Point(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );
  }
}

final a = Point(1, 2);
final b = Point.origin();
final c = Point.fromMap({'x': 3, 'y': 4});
''', legenda: 'The part after the `:` is the "initialiser list".'),
    BlocoTitulo('4. Getters and setters'),
    BlocoCodigo(
      r'''
class Rectangle {
  Rectangle(this.width, this.height);

  double width;
  double height;

  // GETTER: looks like a field, but is computed on the spot.
  double get area => width * height;
  bool get isSquare => width == height;

  // SETTER: intercepts the write (so you can validate).
  set safeWidth(double value) {
    if (value > 0) width = value;
  }
}

final r = Rectangle(3, 4);
print(r.area);      // 12.0  ← no parentheses!
r.safeWidth = 10;
print(r.area);      // 40.0
''',
      saida: '12.0\n40.0',
      legenda: 'A getter reads like a field — never put heavy work in one.',
    ),
    BlocoTitulo('5. static: belongs to the CLASS, not the object'),
    BlocoCodigo(r'''
class Config {
  static const String version = '1.0.0';
  static int hits = 0;

  static void track() => hits++;
}

print(Config.version);  // 1.0.0  ← no object needed
Config.track();
''', legenda: 'Use it for shared constants and utilities.'),
    BlocoTitulo('6. Inheritance: extends'),
    BlocoCodigo(
      r'''
class Animal {
  Animal(this.name);
  final String name;

  void speak() => print('...');
}

class Dog extends Animal {
  // `super` calls the parent constructor.
  Dog(super.name);

  @override                    // says we are replacing the parent's method
  void speak() => print('$name says: Woof!');
}

Dog('Rex').speak(); // Rex says: Woof!
''',
      saida: 'Rex says: Woof!',
      legenda:
          '`@override` is optional, but always write it: it catches typos.',
    ),
    BlocoTitulo('7. abstract: the incomplete blueprint'),
    BlocoCodigo(r'''
abstract class Shape {
  double area();               // no body: subclasses MUST write it

  void describe() => print('Area: ${area()}'); // comes ready made
}

class Circle extends Shape {
  Circle(this.radius);
  final double radius;

  @override
  double area() => 3.14 * radius * radius;
}

// Shape();  // ❌ you cannot instantiate an abstract class
Circle(2).describe(); // Area: 12.56
''', saida: 'Area: 12.56'),
    BlocoTitulo('8. extends vs implements vs with'),
    BlocoTabela(
      cabecalho: ('Keyword', 'What it does'),
      linhas: [
        ('extends', 'Inherits code and behaviour. Only ONE parent.'),
        (
          'implements',
          'Copies the CONTRACT only — you rewrite everything. Many.',
        ),
        ('with', 'Mixin: injects ready-made behaviour. Many.'),
        ('abstract', 'A class that cannot become an object directly.'),
      ],
    ),
    BlocoCodigo(
      r'''
mixin Swimmer {
  void swim() => print('Swimming 🏊');
}

mixin Runner {
  void run() => print('Running 🏃');
}

// A class can combine several mixins:
class Triathlete with Swimmer, Runner {}

Triathlete()
  ..swim()    // ← `..` is the cascade operator: call several methods
  ..run();    //   on the SAME object without repeating its name
''',
      saida: 'Swimming 🏊\nRunning 🏃',
      legenda: 'A mixin is reusable behaviour without inheritance.',
    ),
    BlocoTitulo('9. extension: adding methods to types you do not own'),
    BlocoCodigo(
      r'''
extension TextUtil on String {
  String get capitalised =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);

  bool get isEmail => contains('@') && contains('.');
}

print('dart'.capitalised); // Dart
print('a@b.com'.isEmail);  // true
''',
      saida: 'Dart\ntrue',
      legenda: 'You can "grow" String, int, List… without inheriting anything.',
    ),
    BlocoDica(
      'This whole app uses an extension to reach the theme colours: '
      '`context.paleta`. Have a look at `core/tema/tema_app.dart`.',
    ),
    BlocoAviso(
      'In Dart, `==` compares **identity** by default: two objects holding the '
      'same data count as different. To compare by value, override `==` and '
      '`hashCode` — or use a `record`.',
    ),
  ],
);
