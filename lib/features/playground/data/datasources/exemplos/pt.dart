import '../../../domain/entities/arquivo_dart.dart';
import '../../../domain/repositories/playground_repositorio.dart';

const List<ArquivoDart> arquivosIniciaisPt = [
  ArquivoDart(
    id: 'main',
    nome: 'main.dart',
    conteudo: r'''
// Bem-vindo ao mini-editor! Aperte ▶ Rodar para ver o resultado.
// A aba saudacao.dart tem uma função — as abas compartilham o mesmo escopo,
// então dá para chamar de uma na outra.

void main() {
  final nome = 'Ana';
  print(saudar(nome));

  // Null safety na prática:
  String? apelido;
  print(apelido ?? 'sem apelido');

  for (var i = 1; i <= 3; i++) {
    print('Volta $i');
  }
}
''',
  ),
  ArquivoDart(
    id: 'saudacao',
    nome: 'saudacao.dart',
    conteudo: r'''
// Esta função é usada lá no main.dart.

String saudar(String nome) {
  return 'Olá, $nome! Bem-vindo ao Dart.';
}
''',
  ),
];

const List<ExemploPlayground> exemplosPt = [
  ExemploPlayground(
    titulo: 'Null safety',
    descricao: 'Os operadores ?., ??, ??= e ! na prática.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  String? apelido;

  // ?. → acesso seguro (não quebra se for null)
  print(apelido?.length);

  // ?? → valor padrão
  print(apelido ?? 'Visitante');

  // ??= → só atribui se estiver null
  apelido ??= 'Aninha';
  apelido ??= 'Outro';
  print(apelido);

  // Promoção de tipo dentro do if
  final talvez = buscarEmail('ana');
  if (talvez != null) {
    print('Email tem ${talvez.length} letras');
  } else {
    print('Sem email');
  }

  // Descomente para ver o erro do operador ! :
  // String? nada;
  // print(nada!.length);
}

String? buscarEmail(String usuario) {
  final banco = {'ana': 'ana@exemplo.com'};
  return banco[usuario];
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Funções',
    descricao: 'Parâmetros nomeados, opcionais, arrow e closures.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  print(dobro(21));

  criarBotao(texto: 'Salvar');
  criarBotao(texto: 'Excluir', cor: 'vermelho');

  print(saudacao('Ana'));
  print(saudacao('Ana', 'Dra.'));

  // Função guardada numa variável
  final triplo = (int n) => n * 3;
  print(triplo(5));

  // Closure: a função lembra do total
  final contar = contador();
  contar();
  contar();
  print(contar());
}

int dobro(int n) => n * 2;

void criarBotao({required String texto, String cor = 'azul'}) {
  print('Botão "$texto" ($cor)');
}

String saudacao(String nome, [String? titulo]) {
  final prefixo = titulo == null ? '' : '$titulo ';
  return 'Olá, $prefixo$nome!';
}

Function contador() {
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
    titulo: 'Listas e mapas',
    descricao: 'map, where, fold e collection if/for.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  final numeros = [1, 2, 3, 4, 5, 6];

  print(numeros.where((n) => n % 2 == 0).toList());
  print(numeros.map((n) => n * 10).toList());
  print(numeros.fold(0, (total, n) => total + n));

  final precos = {'café': 5.0, 'bolo': 8.5};
  print(precos['café']);
  print(precos['pizza']);  // null: a chave não existe

  for (final entrada in precos.entries) {
    print('${entrada.key} custa ${entrada.value}');
  }

  // collection if e for
  final ehAdmin = true;
  final menu = [
    'Início',
    if (ehAdmin) 'Painel',
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
    descricao: 'Campos, construtor, métodos e getters.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
void main() {
  final ana = Pessoa('Ana', 30);
  ana.apresentar();
  print(ana.ehMaiorDeIdade);

  final r = Retangulo(3, 4);
  print('Área: ${r.area}');
  print(r);
}

class Pessoa {
  Pessoa(this.nome, this.idade);

  final String nome;
  final int idade;

  bool get ehMaiorDeIdade => idade >= 18;

  void apresentar() {
    print('$nome, $idade anos');
  }
}

class Retangulo {
  Retangulo(this.largura, this.altura);

  double largura;
  double altura;

  double get area => largura * altura;

  String toString() => 'Retangulo(${largura}x$altura)';
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Dois arquivos',
    descricao: 'Como as abas conversam entre si.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
// As abas compartilham o mesmo escopo global: o que você declara em uma,
// pode usar na outra.

void main() {
  final carrinho = [
    Item('Café', 12.5),
    Item('Bolo', 8.0),
    Item('Suco', 6.5),
  ];

  for (final item in carrinho) {
    print(item.etiqueta());
  }

  print('Total: ${formatarReal(somarTotal(carrinho))}');
}
''',
      ),
      ArquivoDart(
        id: 'modelo',
        nome: 'modelo.dart',
        conteudo: r'''
class Item {
  Item(this.nome, this.preco);

  final String nome;
  final double preco;

  String etiqueta() => '$nome — ${formatarReal(preco)}';
}

double somarTotal(List<Item> itens) {
  return itens.fold(0.0, (total, item) => total + item.preco);
}
''',
      ),
      ArquivoDart(
        id: 'util',
        nome: 'util.dart',
        conteudo: r'''
String formatarReal(double valor) {
  return 'R\$ ${valor.toStringAsFixed(2)}';
}
''',
      ),
    ],
  ),
  ExemploPlayground(
    titulo: 'Erros de propósito',
    descricao: 'Veja como o editor aponta cada problema.',
    arquivos: [
      ArquivoDart(
        id: 'main',
        nome: 'main.dart',
        conteudo: r'''
// Este código tem erros de propósito!
// Rode, leia a mensagem, conserte e rode de novo.

void main() {
  // 1) Falta o ponto e vírgula
  print('primeiro')

  // 2) String não aceita null
  String nome = null;

  // 3) Índice fora do intervalo
  final lista = [1, 2, 3];
  print(lista[5]);

  // 4) A condição precisa ser bool
  if ('texto') {
    print('nunca chega aqui');
  }
}
''',
      ),
    ],
  ),
];
