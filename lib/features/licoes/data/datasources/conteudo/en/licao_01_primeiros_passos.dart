import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao01PrimeirosPassosEn = Licao(
  id: 'primeiros-passos',
  titulo: 'How Dart works',
  resumo: 'The entry point, the basic syntax, and how code becomes an app.',
  nivel: NivelLicao.iniciante,
  minutos: 6,
  objetivos: [
    'Understand what the main() function does',
    'Read the basic syntax without getting lost',
    'Know when to use semicolons, braces and comments',
  ],
  blocos: [
    BlocoTexto(
      'Dart is the language behind **Flutter**. It is **compiled** (turned '
      'into native code before it runs) and **statically typed** — which means '
      'many errors show up while you type, not once the app is in someone '
      'else\'s hands.',
    ),
    BlocoTexto(
      'In Dart, **everything is an object**. Even the number `7` is an object '
      'of the `int` class, and even a function can be stored in a variable.',
    ),
    BlocoTitulo('The simplest program there is'),
    BlocoCodigo(
      r'''
// Every Dart program starts at the main() function.
// That is the one the system looks for to hit "start".
void main() {
  print('Hello, Dart!');
}
''',
      legenda: 'The classic "hello, world" in Dart.',
      saida: 'Hello, Dart!',
    ),
    BlocoTexto('Let us take that function apart, line by line:'),
    BlocoTabela(
      cabecalho: ('Piece', 'What it means'),
      linhas: [
        ('void', 'Return type. `void` = "gives nothing back".'),
        (
          'main',
          'Function name. This exact name is required for the entry point.',
        ),
        ('()', 'Parameter list. Empty = the function takes nothing.'),
        ('{ }', 'Function body: everything it runs goes in here.'),
        ('print(...)', 'A built-in Dart function that writes to the console.'),
        (';', 'End of statement. In Dart the semicolon is mandatory.'),
      ],
    ),
    BlocoTitulo('Comments'),
    BlocoCodigo(r'''
// Single-line comment.

/*
  Multi-line comment.
  Handy for switching a chunk off temporarily.
*/

/// DOCUMENTATION comment (three slashes).
/// This becomes the little tooltip your IDE shows when someone
/// hovers the function. Use it on your public functions.
void sum() {}
''', legenda: 'Three styles — and the three-slash one is special.'),
    BlocoDica(
      'Type `main` and press Tab in your IDE: it completes the whole function '
      'for you. Shortcuts like this save hours.',
    ),
    BlocoTitulo('Mistakes everyone makes on day one'),
    BlocoComparacao(
      codigoErrado: r'''
void Main() {
  print('Hello')
}''',
      notaErrado:
          'Two problems: `Main` with a capital M (Dart is case sensitive, so '
          'this is NOT the entry point) and a missing `;`.',
      codigoCerto: r'''
void main() {
  print('Hello');
}''',
      notaCerto: 'Named exactly `main`, and every statement ends with `;`.',
    ),
    BlocoTitulo('How your code becomes an app'),
    BlocoLista([
      'While you develop, Dart uses **JIT** — it compiles on the fly, which is '
          'what makes Hot Reload possible (you save and the screen changes in '
          'about a second).',
      'When you publish, it uses **AOT** — everything is compiled up front, '
          'producing fast native code for Android, iOS, web and desktop.',
      'The same `.dart` file you write here runs in both situations.',
    ]),
    BlocoAviso(
      'Coming from JavaScript: in Dart the `;` is **not** optional, and there '
      'is no weird `==` — comparison is always type safe.',
    ),
  ],
);
