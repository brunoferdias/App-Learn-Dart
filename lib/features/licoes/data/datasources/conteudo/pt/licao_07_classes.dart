import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao07Classes = Licao(
  id: 'classes-e-objetos',
  titulo: 'Classes e objetos',
  resumo: 'Construtores, getters, herança, abstract, mixin e extension.',
  nivel: NivelLicao.intermediario,
  minutos: 16,
  objetivos: [
    'Criar classes com construtores claros e imutáveis',
    'Diferenciar extends, implements, with e abstract',
    'Usar getters, static, factory e extension',
  ],
  blocos: [
    BlocoTexto(
      'Classe é a **planta** de um objeto: diz quais dados ele guarda e o que '
      'ele sabe fazer. Objeto é a casa construída a partir dessa planta.',
    ),
    BlocoTitulo('1. Classe e construtor'),
    BlocoCodigo(
      r'''
class Usuario {
  // Campos (o que o objeto guarda)
  final String nome;
  final int idade;

  // Construtor. `this.nome` é atalho para "recebe e já guarda no campo".
  Usuario(this.nome, this.idade);

  // Método (o que o objeto faz)
  void apresentar() => print('$nome, $idade anos');
}

void main() {
  final ana = Usuario('Ana', 30); // `new` é opcional desde o Dart 2
  ana.apresentar();               // Ana, 30 anos
}
''',
      saida: 'Ana, 30 anos',
      legenda: 'Campos `final` = objeto imutável, o padrão recomendado.',
    ),
    BlocoTitulo('2. Construtor com parâmetros nomeados (estilo Flutter)'),
    BlocoCodigo(
      r'''
class Produto {
  const Produto({
    required this.nome,
    required this.preco,
    this.descricao,          // String? → opcional
    this.emEstoque = true,   // valor padrão
  });

  final String nome;
  final double preco;
  final String? descricao;
  final bool emEstoque;
}

const p = Produto(nome: 'Café', preco: 12.9);
''',
      legenda:
          'Construtor `const` só é possível se TODOS os campos forem `final`.',
    ),
    BlocoTitulo('3. Construtores nomeados e factory'),
    BlocoCodigo(r'''
class Ponto {
  final double x;
  final double y;

  Ponto(this.x, this.y);

  // Construtor NOMEADO: um atalho com nome próprio.
  Ponto.origem() : x = 0, y = 0;

  // FACTORY: pode decidir o que devolver (até um objeto já existente,
  // ou uma subclasse). Muito usado para criar objeto a partir de JSON.
  factory Ponto.deMapa(Map<String, dynamic> json) {
    return Ponto(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );
  }
}

final a = Ponto(1, 2);
final b = Ponto.origem();
final c = Ponto.deMapa({'x': 3, 'y': 4});
''', legenda: 'A parte depois dos `:` é a "lista de inicialização".'),
    BlocoTitulo('4. Getters e setters'),
    BlocoCodigo(
      r'''
class Retangulo {
  Retangulo(this.largura, this.altura);

  double largura;
  double altura;

  // GETTER: parece campo, mas é calculado na hora.
  double get area => largura * altura;
  bool get ehQuadrado => largura == altura;

  // SETTER: intercepta a escrita (dá para validar).
  set larguraSegura(double valor) {
    if (valor > 0) largura = valor;
  }
}

final r = Retangulo(3, 4);
print(r.area);        // 12.0  ← sem parênteses!
r.larguraSegura = 10;
print(r.area);        // 40.0
''',
      saida: '12.0\n40.0',
      legenda: 'Getter é lido como campo — nunca coloque cálculo pesado nele.',
    ),
    BlocoTitulo('5. static: pertence à CLASSE, não ao objeto'),
    BlocoCodigo(r'''
class Config {
  static const String versao = '1.0.0';
  static int acessos = 0;

  static void registrar() => acessos++;
}

print(Config.versao);   // 1.0.0  ← não precisa criar objeto
Config.registrar();
''', legenda: 'Use para constantes e utilitários compartilhados.'),
    BlocoTitulo('6. Herança: extends'),
    BlocoCodigo(
      r'''
class Animal {
  Animal(this.nome);
  final String nome;

  void falar() => print('...');
}

class Cachorro extends Animal {
  // `super` chama o construtor do pai.
  Cachorro(super.nome);

  @override                       // avisa que estamos trocando o método do pai
  void falar() => print('$nome diz: Au au!');
}

Cachorro('Rex').falar(); // Rex diz: Au au!
''',
      saida: 'Rex diz: Au au!',
      legenda:
          '`@override` é opcional, mas escreva sempre: evita erro de digitação.',
    ),
    BlocoTitulo('7. abstract: o molde incompleto'),
    BlocoCodigo(r'''
abstract class Forma {
  double area();              // sem corpo: quem herdar É OBRIGADO a escrever

  void descrever() => print('Área: ${area()}'); // já vem pronto
}

class Circulo extends Forma {
  Circulo(this.raio);
  final double raio;

  @override
  double area() => 3.14 * raio * raio;
}

// Forma();  // ❌ não dá para instanciar uma classe abstrata
Circulo(2).descrever(); // Área: 12.56
''', saida: 'Área: 12.56'),
    BlocoTitulo('8. extends × implements × with'),
    BlocoTabela(
      cabecalho: ('Palavra', 'O que faz'),
      linhas: [
        ('extends', 'Herda código e comportamento. Só UM pai.'),
        ('implements', 'Copia só o CONTRATO — você reescreve tudo. Vários.'),
        ('with', 'Mixin: injeta comportamento pronto. Vários.'),
        ('abstract', 'Classe que não pode virar objeto direto.'),
      ],
    ),
    BlocoCodigo(
      r'''
mixin Nadador {
  void nadar() => print('Nadando 🏊');
}

mixin Corredor {
  void correr() => print('Correndo 🏃');
}

// Uma classe pode combinar vários mixins:
class Triatleta with Nadador, Corredor {}

Triatleta()
  ..nadar()     // ← `..` é o operador cascata: chama vários métodos
  ..correr();   //   no MESMO objeto, sem repetir o nome
''',
      saida: 'Nadando 🏊\nCorrendo 🏃',
      legenda: 'Mixin = comportamento reutilizável sem herança.',
    ),
    BlocoTitulo('9. extension: adicionar métodos a tipos alheios'),
    BlocoCodigo(
      r'''
extension TextoUtil on String {
  String get capitalizado =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);

  bool get ehEmail => contains('@') && contains('.');
}

print('dart'.capitalizado); // Dart
print('a@b.com'.ehEmail);   // true
''',
      saida: 'Dart\ntrue',
      legenda: 'Dá para "aumentar" String, int, List… sem herdar nada.',
    ),
    BlocoDica(
      'Este app inteiro usa uma extension para pegar as cores do tema: '
      '`context.paleta`. Procure em `core/tema/tema_app.dart`.',
    ),
    BlocoAviso(
      'Em Dart, `==` compara **identidade** por padrão: dois objetos com os '
      'mesmos dados são considerados diferentes. Para comparar por valor, '
      'sobrescreva `==` e `hashCode` — ou use um `record`.',
    ),
  ],
);
