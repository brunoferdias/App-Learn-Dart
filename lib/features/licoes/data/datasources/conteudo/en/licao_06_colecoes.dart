import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao06ColecoesEn = Licao(
  id: 'colecoes',
  titulo: 'Lists, Sets and Maps',
  resumo: 'Holding many values and reshaping them with map, where and fold.',
  nivel: NivelLicao.intermediario,
  minutos: 12,
  objetivos: [
    'Create and walk through List, Set and Map',
    'Reshape lists with map/where/fold instead of hand-written loops',
    'Handle the null safety that shows up inside collections',
  ],
  blocos: [
    BlocoTitulo('List — an ordered list'),
    BlocoCodigo(r'''
final numbers = <int>[1, 2, 3];
final empty = <String>[];

numbers.add(4);             // [1, 2, 3, 4]
numbers.remove(1);          // [2, 3, 4]
print(numbers.length);      // 3
print(numbers.first);       // 2
print(numbers.contains(3)); // true
print(numbers[0]);          // 2  (indexes start at ZERO)

// A list that cannot change:
const fixed = [1, 2, 3];    // calling .add() throws at run time
''', legenda: '`<int>[]` states the item type. Always do this.'),
    BlocoAviso(
      'Indexes start at 0. In a list of 3 items the valid indexes are 0, 1 and '
      '2 — asking for `list[3]` throws a *RangeError*.',
    ),
    BlocoTitulo('Set — no repeats'),
    BlocoCodigo(r'''
final tags = <String>{'dart', 'flutter', 'dart'};
print(tags);        // {dart, flutter}  ← the duplicate is gone
print(tags.length); // 2
''', legenda: 'Use it when "each item may only appear once".'),
    BlocoTitulo('Map — key → value pairs'),
    BlocoCodigo(r'''
final prices = <String, double>{
  'coffee': 5.0,
  'cake': 8.5,
};

prices['juice'] = 7.0;             // adds
print(prices['coffee']);           // 5.0
print(prices['pizza']);            // null ← the key is not there!
print(prices.containsKey('cake')); // true

for (final entry in prices.entries) {
  print('${entry.key} costs ${entry.value}');
}
''', legenda: 'Reading from a Map ALWAYS gives you a nullable type.'),
    BlocoCodigo(r'''
final prices = {'coffee': 5.0};

// ❌ double price = prices['pizza'];  → error: it is double?, not double
final price = prices['pizza'] ?? 0.0;  // ✅ 0.0
''', legenda: 'Null safety showing up here quite naturally.'),
    BlocoTitulo('The methods that replace loops'),
    BlocoCodigo(
      r'''
final numbers = [1, 2, 3, 4, 5, 6];

// map → transforms every item
final doubles = numbers.map((n) => n * 2).toList();
print(doubles);  // [2, 4, 6, 8, 10, 12]

// where → filters
final evens = numbers.where((n) => n % 2 == 0).toList();
print(evens);    // [2, 4, 6]

// fold → accumulates into a single value
final total = numbers.fold<int>(0, (sum, n) => sum + n);
print(total);    // 21

// Chaining it all together:
final result = numbers
    .where((n) => n > 2)
    .map((n) => n * 10)
    .toList();
print(result);   // [30, 40, 50, 60]
''',
      saida: '[2, 4, 6, 8, 10, 12]\n[2, 4, 6]\n21\n[30, 40, 50, 60]',
      legenda: 'map and where are LAZY: they only run at .toList().',
    ),
    BlocoTabela(
      cabecalho: ('Method', 'What it does'),
      linhas: [
        ('map', 'Turns each item into something else'),
        ('where', 'Keeps only the items that pass the test'),
        ('firstWhere', 'Finds the first — pass `orElse` so it does not throw!'),
        ('any / every', 'Returns a bool: "any?" / "all?"'),
        ('fold / reduce', 'Squashes everything into one value (sum, max…)'),
        ('sort', 'Sorts the list IN PLACE (mutates the original)'),
        ('expand', 'Flattens lists of lists'),
        ('take / skip', 'Takes the first N / skips the first N'),
      ],
    ),
    BlocoComparacao(
      codigoErrado: r'''
final u = users.firstWhere((u) => u.id == 99);
// 💥 StateError: No element
// if nobody has id 99''',
      notaErrado: '`firstWhere` with no escape hatch crashes the app.',
      codigoCerto: r'''
final u = users
    .where((u) => u.id == 99)
    .firstOrNull;   // returns null instead of throwing

if (u != null) { /* ... */ }''',
      notaCerto: '`firstOrNull` returns a `User?` and null safety guides you.',
    ),
    BlocoTitulo('Spread and collection-if/for'),
    BlocoTexto(
      'These three tricks make building lists (and widgets!) far cleaner — you '
      'will use them constantly inside `children:` in Flutter.',
    ),
    BlocoCodigo(r'''
final base = [1, 2];
final extra = [3, 4];

// spread: pours another list's items in
final joined = [...base, ...extra];      // [1, 2, 3, 4]

// null-aware spread: skipped when null
List<int>? maybe;
final safe = [...base, ...?maybe];       // [1, 2]

// if inside the list
final isAdmin = true;
final menu = [
  'Home',
  'Profile',
  if (isAdmin) 'Admin panel',
];                                       // 3 items

// for inside the list
final ids = [1, 2, 3];
final labels = [
  for (final id in ids) 'Item $id',
];                                       // [Item 1, Item 2, Item 3]
''', legenda: 'The `...?` is null safety even while building a list.'),
    BlocoDica(
      'Whenever you write a `for` purely to fill a new list, there is probably '
      'a shorter `map` or collection-for waiting for you.',
    ),
  ],
);
