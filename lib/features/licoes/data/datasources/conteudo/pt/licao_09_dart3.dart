import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao09Dart3 = Licao(
  id: 'dart-3',
  titulo: 'Dart 3: records, patterns e sealed',
  resumo: 'As novidades que deixaram o Dart muito mais expressivo.',
  nivel: NivelLicao.avancado,
  minutos: 12,
  objetivos: [
    'Devolver mais de um valor com records',
    'Desestruturar dados com pattern matching',
    'Modelar estados com sealed class e switch exaustivo',
  ],
  blocos: [
    BlocoTitulo('Records: vários valores sem criar uma classe'),
    BlocoTexto(
      'Antes, para devolver duas coisas você precisava criar uma classe ou '
      'devolver uma `List` sem tipo. Agora existe o **record**: um pacotinho '
      'de valores, com tipo, criado na hora.',
    ),
    BlocoCodigo(
      r'''
// O tipo do retorno é literalmente "(String, int)"
(String, int) buscarUsuario() {
  return ('Ana', 30);
}

final resultado = buscarUsuario();
print(resultado.$1); // Ana  ← posição 1
print(resultado.$2); // 30   ← posição 2

// Com nomes fica bem melhor:
({String nome, int idade}) buscarNomeado() {
  return (nome: 'Léo', idade: 25);
}

final u = buscarNomeado();
print(u.nome);  // Léo
print(u.idade); // 25
''',
      saida: 'Ana\n30\nLéo\n25',
      legenda: 'Records são imutáveis e comparados por VALOR (== funciona!).',
    ),
    BlocoTitulo('Desestruturação'),
    BlocoCodigo(r'''
// Quebrando o record direto em variáveis:
final (nome, idade) = buscarUsuario();
print('$nome tem $idade anos');

// Funciona com listas e mapas também:
final [primeiro, segundo] = [10, 20];
final {'x': x, 'y': y} = {'x': 1, 'y': 2};

// E no for-in (lembra do .indexed?):
for (final (i, letra) in ['a', 'b'].indexed) {
  print('$i → $letra');
}
''', saida: 'Ana tem 30 anos\n0 → a\n1 → b'),
    BlocoTitulo('Sealed class: o conjunto FECHADO de possibilidades'),
    BlocoTexto(
      'Uma classe `sealed` só pode ter filhos no mesmo arquivo. Assim o '
      'compilador conhece todos os casos e **exige** que o seu `switch` trate '
      'cada um. Se amanhã você criar um novo estado e esquecer de tratar, o '
      'erro aparece na compilação — não em produção.',
    ),
    BlocoCodigo(
      r'''
sealed class EstadoDaTela {}

final class Carregando extends EstadoDaTela {}

final class Carregado extends EstadoDaTela {
  Carregado(this.itens);
  final List<String> itens;
}

final class Erro extends EstadoDaTela {
  Erro(this.mensagem);
  final String mensagem;
}

String descrever(EstadoDaTela estado) => switch (estado) {
      Carregando() => 'Carregando...',
      Carregado(:final itens) => '${itens.length} itens',  // desestrutura!
      Erro(:final mensagem) => 'Falhou: $mensagem',
    };
''',
      legenda:
          'Repare no `:final itens` — o pattern já extrai o campo para você. '
          'Sem `default`, e o compilador ainda garante que nada ficou de fora.',
    ),
    BlocoDica(
      'É exatamente assim que o tipo `Resultado<T>` deste app funciona. Abra '
      '`core/utils/resultado.dart` e compare com o exemplo acima.',
    ),
    BlocoTitulo('Patterns com condição'),
    BlocoCodigo(
      r'''
String classificar((int, int) ponto) => switch (ponto) {
      (0, 0) => 'origem',
      (final x, 0) => 'no eixo X em $x',
      (0, final y) => 'no eixo Y em $y',
      (final x, final y) when x == y => 'na diagonal',
      _ => 'qualquer lugar',
    };

print(classificar((0, 0)));   // origem
print(classificar((5, 5)));   // na diagonal
''',
      saida: 'origem\nna diagonal',
      legenda: '`when` adiciona uma condição extra ao caso.',
    ),
    BlocoTitulo('if-case: pattern em um if'),
    BlocoCodigo(
      r'''
final json = {'nome': 'Ana', 'idade': 30};

// Checa o formato E extrai os valores, tudo de uma vez:
if (json case {'nome': final String n, 'idade': final int i}) {
  print('$n, $i anos');   // só entra aqui se os tipos baterem
} else {
  print('JSON fora do formato esperado');
}
''',
      saida: 'Ana, 30 anos',
      legenda: 'Ótimo para validar JSON sem uma pilha de ifs.',
    ),
    BlocoAviso(
      'Use `sealed` para **estados e resultados**; use `enum` quando os casos '
      'não carregam dados diferentes entre si.',
    ),
  ],
);
