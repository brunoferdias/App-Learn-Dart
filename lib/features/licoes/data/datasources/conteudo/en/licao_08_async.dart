import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao08AsyncEn = Licao(
  id: 'assincronia',
  titulo: 'Future, async and await',
  resumo:
      'Waiting on the network without freezing the screen — and handling errors.',
  nivel: NivelLicao.intermediario,
  minutos: 13,
  objetivos: [
    'Understand what a Future is',
    'Use async/await instead of callbacks',
    'Handle errors with try/catch/finally',
    'Meet Stream, for values that arrive a few at a time',
  ],
  blocos: [
    BlocoTexto(
      'Fetching data over the network takes time. If the app just **stopped** '
      'and waited, the screen would freeze. Dart\'s answer is the `Future`: a '
      '**promise of a future value**.',
    ),
    BlocoTitulo('Future: the value that has not arrived yet'),
    BlocoCodigo(
      r'''
// Future<String> = "one day this becomes a String"
Future<String> fetchName() async {
  await Future.delayed(Duration(seconds: 2)); // pretend network
  return 'Ana';
}

void main() async {
  print('Fetching...');
  final name = await fetchName(); // waits WITHOUT freezing the screen
  print('Got it: $name');
}
''',
      saida: 'Fetching...\n(2 seconds later)\nGot it: Ana',
      legenda: 'async marks the function; await waits inside it.',
    ),
    BlocoTabela(
      cabecalho: ('Keyword', 'Meaning'),
      linhas: [
        ('Future<T>', 'A promise of a value T that arrives later'),
        ('async', 'Marks the function as asynchronous (it returns a Future)'),
        ('await', 'Pause HERE until the Future finishes. Only inside async.'),
        ('Future<void>', 'Finishes later, but returns no value'),
        ('Stream<T>', 'Many values over time (a "pipe")'),
      ],
    ),
    BlocoComparacao(
      codigoErrado: r'''
void main() {
  final name = await fetchName();
}
// ❌ "await can only be used in async"''',
      notaErrado: 'The function was never marked `async`.',
      codigoCerto: r'''
void main() async {
  final name = await fetchName();
}''',
      notaCerto: 'Any function using `await` has to be `async`.',
    ),
    BlocoAviso(
      'Forget the `await` and the variable holds the **Future** instead of the '
      'value: `Instance of Future<String>`. That is async bug number one.',
    ),
    BlocoTitulo('Handling errors'),
    BlocoCodigo(
      r'''
Future<void> load() async {
  try {
    final data = await fetchFromApi();
    print(data);
  } on FormatException catch (e) {
    print('Response in an invalid format: $e'); // specific error
  } catch (e, stack) {
    print('Unexpected error: $e');              // anything else
    print(stack);                               // where it happened
  } finally {
    print('Always runs, success or failure');
  }
}
''',
      legenda:
          '`on Type` catches a specific error; `catch (e)` catches everything.',
    ),
    BlocoCodigo(r'''
// Writing your own exception documents what can go wrong.
class NoConnection implements Exception {
  const NoConnection(this.message);
  final String message;

  @override
  String toString() => 'NoConnection: $message';
}

void check(bool online) {
  if (!online) throw const NoConnection('You are offline');
}
''', legenda: 'This app takes another route: errors as VALUES (`Resultado`).'),
    BlocoTitulo('Several Futures at once'),
    BlocoCodigo(
      r'''
// ❌ One after the other: 2s + 2s = 4 seconds
final a = await fetchA();
final b = await fetchB();

// ✅ Together: 2 seconds in total
final results = await Future.wait([fetchA(), fetchB()]);
''',
      legenda:
          '`Future.wait` fires everything in parallel and waits for the set.',
    ),
    BlocoTitulo('Stream: many values over time'),
    BlocoTexto(
      'If a `Future` is **one** delivery, a `Stream` is a **conveyor belt**: '
      'values arriving continuously — typing, GPS, chat messages.',
    ),
    BlocoCodigo(
      r'''
// async* + yield = a function that produces a Stream
Stream<int> countdown(int from) async* {
  for (var i = from; i >= 0; i--) {
    await Future.delayed(Duration(seconds: 1));
    yield i;              // drops one more value onto the belt
  }
}

void main() async {
  await for (final n in countdown(3)) {
    print(n);             // 3, 2, 1, 0 — one per second
  }
  print('Done');
}
''',
      saida: '3\n2\n1\n0\nDone',
      legenda: '`await for` walks a Stream the way for-in walks a list.',
    ),
    BlocoDica(
      'In Flutter you rarely write `await` inside `build`. Use `FutureBuilder` '
      'or `StreamBuilder`, which rebuild the screen once the data lands.',
    ),
  ],
);
