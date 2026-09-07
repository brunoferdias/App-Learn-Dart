import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao06Colecoes = Licao(
  id: 'colecoes',
  titulo: 'Listas, Sets e Maps',
  resumo: 'Guardar vários valores e transformá-los com map, where e fold.',
  nivel: NivelLicao.intermediario,
  minutos: 12,
  objetivos: [
    'Criar e percorrer List, Set e Map',
    'Transformar listas com map/where/fold em vez de laços manuais',
    'Lidar com o null safety que aparece nas coleções',
  ],
  blocos: [
    BlocoTitulo('List — lista ordenada'),
    BlocoCodigo(r'''
final numeros = <int>[1, 2, 3];
final vazia = <String>[];

numeros.add(4);            // [1, 2, 3, 4]
numeros.remove(1);         // [2, 3, 4]
print(numeros.length);     // 3
print(numeros.first);      // 2
print(numeros.contains(3)); // true
print(numeros[0]);         // 2  (índice começa em ZERO)

// Lista que não pode mudar:
const fixa = [1, 2, 3];    // tentar .add() quebra em execução
''', legenda: '`<int>[]` diz o tipo dos itens. Sempre faça isso.'),
    BlocoAviso(
      'Índice começa em 0. Numa lista de 3 itens os índices válidos são 0, 1 e '
      '2 — pedir `lista[3]` gera *RangeError*.',
    ),
    BlocoTitulo('Set — sem repetição'),
    BlocoCodigo(r'''
final tags = <String>{'dart', 'flutter', 'dart'};
print(tags);        // {dart, flutter}  ← o repetido sumiu
print(tags.length); // 2
''', legenda: 'Use quando "cada item só pode aparecer uma vez".'),
    BlocoTitulo('Map — pares chave → valor'),
    BlocoCodigo(r'''
final precos = <String, double>{
  'café': 5.0,
  'bolo': 8.5,
};

precos['suco'] = 7.0;              // adiciona
print(precos['café']);             // 5.0
print(precos['pizza']);            // null ← chave inexistente!
print(precos.containsKey('bolo')); // true

for (final entrada in precos.entries) {
  print('${entrada.key} custa R\$ ${entrada.value}');
}
''', legenda: 'Acessar um Map SEMPRE devolve tipo anulável.'),
    BlocoCodigo(r'''
final precos = {'café': 5.0};

// ❌ double preco = precos['pizza'];  → erro: é double?, não double
final preco = precos['pizza'] ?? 0.0;  // ✅ 0.0
''', legenda: 'Null safety aparecendo naturalmente aqui.'),
    BlocoTitulo('Os métodos que substituem laços'),
    BlocoCodigo(
      r'''
final numeros = [1, 2, 3, 4, 5, 6];

// map → transforma cada item
final dobros = numeros.map((n) => n * 2).toList();
print(dobros);   // [2, 4, 6, 8, 10, 12]

// where → filtra
final pares = numeros.where((n) => n % 2 == 0).toList();
print(pares);    // [2, 4, 6]

// fold → acumula num único valor
final soma = numeros.fold<int>(0, (total, n) => total + n);
print(soma);     // 21

// Encadeando tudo:
final resultado = numeros
    .where((n) => n > 2)
    .map((n) => n * 10)
    .toList();
print(resultado); // [30, 40, 50, 60]
''',
      saida: '[2, 4, 6, 8, 10, 12]\n[2, 4, 6]\n21\n[30, 40, 50, 60]',
      legenda: 'map e where são PREGUIÇOSOS: só rodam no .toList().',
    ),
    BlocoTabela(
      cabecalho: ('Método', 'O que faz'),
      linhas: [
        ('map', 'Transforma cada item em outro'),
        ('where', 'Mantém só os itens que passam no teste'),
        ('firstWhere', 'Acha o primeiro — use `orElse` para não quebrar!'),
        ('any / every', 'Devolve bool: "algum?" / "todos?"'),
        ('fold / reduce', 'Junta tudo num valor só (soma, maior…)'),
        ('sort', 'Ordena a lista NO LUGAR (altera a original)'),
        ('expand', 'Achata listas de listas'),
        ('take / skip', 'Pega os N primeiros / pula os N primeiros'),
      ],
    ),
    BlocoComparacao(
      codigoErrado: r'''
final u = usuarios.firstWhere((u) => u.id == 99);
// 💥 StateError: No element
// se ninguém tiver id 99''',
      notaErrado: '`firstWhere` sem saída de emergência quebra o app.',
      codigoCerto: r'''
final u = usuarios
    .where((u) => u.id == 99)
    .firstOrNull;   // devolve null em vez de quebrar

if (u != null) { /* ... */ }''',
      notaCerto: '`firstOrNull` devolve `Usuario?` e o null safety te guia.',
    ),
    BlocoTitulo('Spread e collection-if/for'),
    BlocoTexto(
      'Estes três truques deixam a construção de listas (e de widgets!) muito '
      'mais limpa — você vai usar direto dentro de `children:` no Flutter.',
    ),
    BlocoCodigo(r'''
final base = [1, 2];
final extra = [3, 4];

// spread: despeja os itens de outra lista
final juntas = [...base, ...extra];      // [1, 2, 3, 4]

// spread anulável: ignora se for null
List<int>? talvez;
final segura = [...base, ...?talvez];    // [1, 2]

// if dentro da lista
final ehAdmin = true;
final menu = [
  'Início',
  'Perfil',
  if (ehAdmin) 'Painel admin',
];                                       // 3 itens

// for dentro da lista
final ids = [1, 2, 3];
final rotulos = [
  for (final id in ids) 'Item $id',
];                                       // [Item 1, Item 2, Item 3]
''', legenda: 'O `...?` é null safety até na hora de montar listas.'),
    BlocoDica(
      'Sempre que você escrever um `for` só para preencher uma lista nova, '
      'provavelmente existe um `map` ou um collection-for mais curto.',
    ),
  ],
);
