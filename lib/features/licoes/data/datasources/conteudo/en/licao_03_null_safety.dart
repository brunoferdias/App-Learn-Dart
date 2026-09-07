import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao03NullSafetyEn = Licao(
  id: 'null-safety',
  titulo: 'Null safety',
  resumo: 'Dart\'s superpower: the compiler stops null errors before they run.',
  nivel: NivelLicao.iniciante,
  minutos: 14,
  objetivos: [
    'Tell String apart from String?',
    'Use ?., ??, ??= and ! knowing what each one does',
    'Understand type promotion and when to reach for late',
    'Never see "Null check operator used on a null value" again',
  ],
  blocos: [
    BlocoTexto(
      'The most common bug in the history of programming is using something '
      'that **does not exist** — the famous *null pointer*. Dart fixed it at '
      'the root: by default, **no variable can be null**.',
    ),
    BlocoCodigo(r'''
String name = 'Ana';
// name = null; // ❌ COMPILE ERROR: String does not accept null

String? nickname = 'Annie';
nickname = null;  // ✅ allowed: the ? says "this may be empty"
''', legenda: 'The question mark changes EVERYTHING: it creates a new type.'),
    BlocoTexto(
      '`String` and `String?` are **two different types**. The first promises '
      'there is always text. The second warns you: "there may be text, there '
      'may be nothing — handle both".',
    ),
    BlocoTitulo('Why is this so good?'),
    BlocoTexto(
      'Because the error leaves your user\'s phone and lands on your screen, '
      'underlined in red, before you even compile.',
    ),
    BlocoCodigo(r'''
String? nickname;         // starts out null

// print(nickname.length); // ❌ Dart refuses to compile this
                           //    "The property 'length' can't be
                           //     unconditionally accessed"
''', legenda: 'The compiler protects you from yourself.'),
    BlocoTitulo('The four operators worth memorising'),
    BlocoTabela(
      cabecalho: ('Operator', 'What it does'),
      linhas: [
        ('?.', 'Safe access: if it is null, stop and return null'),
        ('??', 'Default value: "use this if the left side is null"'),
        ('??=', 'Assign only if it is currently null'),
        ('!', 'Asserts "trust me, not null" — dangerous, use it last'),
      ],
    ),
    BlocoCodigo(
      r'''
String? nickname;

// ?.  → safe call
print(nickname?.length);        // null (no crash)
print(nickname?.toUpperCase()); // null

// ??  → default value
final display = nickname ?? 'No nickname';
print(display);                 // No nickname

// ??= → fills in only if empty
nickname ??= 'Guest';
print(nickname);                // Guest
nickname ??= 'Other';
print(nickname);                // Guest (already had a value, ignored)

// Chaining: safe access + default on one line
final size = nickname?.length ?? 0;
print(size);                    // 5
''',
      legenda: 'This is the null safety survival kit.',
      saida: 'null\nnull\nNo nickname\nGuest\nGuest\n5',
    ),
    BlocoTitulo('The ! operator (bang) — use it scared'),
    BlocoTexto(
      'The `!` tells the compiler: *"I guarantee this is not null, go ahead"*. '
      'If you are lying, the app **crashes at run time**. You are literally '
      'giving up the protection.',
    ),
    BlocoComparacao(
      codigoErrado: r'''
String? name = findName();
print(name!.length);
// 💥 If findName() returns null:
// Null check operator used on a null value''',
      notaErrado: 'You traded a compile error for a crash. Terrible deal.',
      codigoCerto: r'''
String? name = findName();
if (name != null) {
  print(name.length); // no ! needed here 👇
}
// or, shorter:
print(name?.length ?? 0);''',
      notaCerto:
          'Inside the `if`, Dart already KNOWS it is not null. That is called '
          'type promotion.',
    ),
    BlocoTitulo('Type promotion'),
    BlocoTexto(
      'When you check `!= null`, Dart **promotes** the variable from `String?` '
      'to `String` inside that block. You need neither `!` nor `?.` in there — '
      'the compiler is reasoning alongside you.',
    ),
    BlocoCodigo(
      r'''
void greet(String? name) {
  if (name == null) {
    print('Hello, stranger');
    return; // early exit — below this line, name is NOT null
  }

  // Here name is a String (promoted), not a String?
  print('Hello, ${name.toUpperCase()}');
}
''',
      legenda:
          'The "early return" pattern keeps the rest of the function clean.',
    ),
    BlocoAviso(
      'Promotion does **not** work on class fields that are not `final`, '
      'because another part of the code could change the value in between. '
      'The fix: copy it to a local variable first.',
    ),
    BlocoCodigo(r'''
class Profile {
  String? bio;

  void show() {
    // ❌ if (bio != null) print(bio.length);  → no promotion!

    final b = bio;            // ✅ local copy
    if (b != null) {
      print(b.length);        // promotes just fine now
    }
  }
}
''', legenda: 'The famous "local copy" — memorise this trick.'),
    BlocoTitulo('late: I promise to fill this in later'),
    BlocoTexto(
      '`late` is how you say: *"this variable is not null, I just do not know '
      'the value yet — I will fill it in before anyone reads it"*. Break the '
      'promise and the error shows up at the moment of reading.',
    ),
    BlocoCodigo(r'''
class Screen {
  late final String title; // no value yet, but it will never be null

  void start() {
    title = 'Loaded'; // filled in here
  }
}

// Bonus: late also defers expensive work.
// The function runs only the FIRST time someone reads `data`.
late final data = slowCalculation();
''', legenda: 'late = "trust me, I fill it in before it is used".'),
    BlocoTitulo('Null safety in lists and maps'),
    BlocoCodigo(r'''
List<String>? maybeNullList; // the LIST may be null
List<String?> listWithNulls; // the list exists, the ITEMS may be null
List<String?>? both;         // both may be null 😅

// A map ALWAYS returns a nullable type: the key might not be there!
final ages = {'Ana': 30};
int? age = ages['Leo']; // null — and Dart forces you to handle it
print(age ?? 0);        // 0
''', legenda: 'Where the ? sits changes the meaning completely.'),
    BlocoDica(
      'Reading from a map **always** gives you a `?` type. That is Dart '
      'reminding you the key may not exist. Handle it with `??` and move on.',
    ),
    BlocoTitulo('required: null safety in parameters'),
    BlocoCodigo(
      r'''
// Named parameters are optional by default.
// If the type does not accept null, Dart DEMANDS `required` or a default.

void createUser({
  required String name,     // mandatory
  String? email,            // optional, may come in null
  int age = 18,             // optional with a default
}) {
  print('$name | ${email ?? "no e-mail"} | $age years old');
}

void main() {
  createUser(name: 'Ana');
  createUser(name: 'Leo', email: 'leo@x.com', age: 30);
}
''',
      saida: 'Ana | no e-mail | 18 years old\nLeo | leo@x.com | 30 years old',
      legenda: 'Null safety and parameters always travel together.',
    ),
    BlocoTitulo('The whole thing in 5 lines'),
    BlocoLista([
      '`Type` = never null. `Type?` = may be null.',
      'Use `?.` to access safely.',
      'Use `??` to supply a default.',
      'Use `if (x != null)` and let Dart promote the type.',
      'Use `!` only when you are **absolutely certain** — and prefer not to.',
    ]),
  ],
);
