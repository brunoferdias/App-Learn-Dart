import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao05ControleFluxo = Licao(
  id: 'controle-de-fluxo',
  titulo: 'Decisões e repetições',
  resumo: 'if, ternário, for, while, switch clássico e switch-expressão.',
  nivel: NivelLicao.iniciante,
  minutos: 10,
  objetivos: [
    'Escrever condições legíveis',
    'Escolher o laço certo para cada situação',
    'Usar switch como expressão (Dart 3)',
  ],
  blocos: [
    BlocoTitulo('if / else'),
    BlocoCodigo(
      r'''
final nota = 7.5;

if (nota >= 9) {
  print('Excelente');
} else if (nota >= 6) {
  print('Aprovado');
} else {
  print('Recuperação');
}
''',
      saida: 'Aprovado',
      legenda: 'A condição precisa ser bool — não existe "if (1)" em Dart.',
    ),
    BlocoAviso(
      'Em Dart, `if (algumaString)` **não compila**. A condição tem que ser '
      '`bool` de verdade. Escreva `if (texto.isNotEmpty)`.',
    ),
    BlocoTitulo('Ternário: if em uma linha'),
    BlocoCodigo(r'''
final idade = 20;

// condicao ? seValorVerdadeiro : seValorFalso
final status = idade >= 18 ? 'maior' : 'menor';

// Muito usado no Flutter dentro do build:
// child: carregando ? CircularProgressIndicator() : ListaDeItens()
''', legenda: 'Ótimo para escolher entre dois valores. Não aninhe demais.'),
    BlocoTitulo('Operadores lógicos'),
    BlocoTabela(
      cabecalho: ('Operador', 'Significado'),
      linhas: [
        ('&&', 'E — precisa que os dois lados sejam verdadeiros'),
        ('||', 'OU — basta um lado ser verdadeiro'),
        ('!', 'NÃO — inverte o valor'),
        ('==  !=', 'Igual / diferente'),
        ('>  <  >=  <=', 'Comparações numéricas'),
      ],
    ),
    BlocoTitulo('for clássico'),
    BlocoCodigo(
      r'''
// for (inicialização; condição; passo)
for (var i = 0; i < 3; i++) {
  print('Volta $i');
}
''',
      saida: 'Volta 0\nVolta 1\nVolta 2',
      legenda: 'Use quando o ÍNDICE importa.',
    ),
    BlocoTitulo('for-in: o mais usado no dia a dia'),
    BlocoCodigo(
      r'''
final frutas = ['maçã', 'uva', 'pera'];

for (final fruta in frutas) {
  print(fruta);
}

// Precisa do índice também? Use asMap() ou indexed (Dart 3):
for (final (indice, fruta) in frutas.indexed) {
  print('$indice: $fruta');
}
''',
      saida: 'maçã\nuva\npera\n0: maçã\n1: uva\n2: pera',
      legenda: 'Use `final` na variável do laço: ela não precisa mudar.',
    ),
    BlocoTitulo('while e do-while'),
    BlocoCodigo(
      r'''
var tentativas = 0;

while (tentativas < 3) {   // testa ANTES
  tentativas++;
}

do {                        // executa pelo menos UMA vez
  print('rodou');
} while (false);
''',
      saida: 'rodou',
      legenda: 'while quando você não sabe quantas voltas serão.',
    ),
    BlocoTitulo('break e continue'),
    BlocoCodigo(r'''
for (final n in [1, 2, 3, 4, 5]) {
  if (n == 2) continue; // pula ESTA volta
  if (n == 4) break;    // sai do laço inteiro
  print(n);
}
''', saida: '1\n3'),
    BlocoTitulo('switch clássico'),
    BlocoCodigo(
      r'''
final dia = 'sabado';

switch (dia) {
  case 'sabado':
  case 'domingo':
    print('Fim de semana!');
  case 'segunda':
    print('Força.');
  default:
    print('Dia útil');
}
''',
      saida: 'Fim de semana!',
      legenda:
          'Desde o Dart 3 não precisa mais escrever `break` em cada case — '
          'ele não "vaza" para o próximo.',
    ),
    BlocoTitulo('switch como EXPRESSÃO (Dart 3) 💎'),
    BlocoTexto(
      'Aqui o switch **devolve um valor** em vez de executar comandos. É mais '
      'curto, e o compilador **obriga** você a cobrir todos os casos quando o '
      'tipo é um enum ou uma sealed class.',
    ),
    BlocoCodigo(r'''
enum Status { carregando, sucesso, erro }

String mensagem(Status s) => switch (s) {
      Status.carregando => 'Carregando...',
      Status.sucesso => 'Tudo certo!',
      Status.erro => 'Deu ruim.',
    };

// Se você criar Status.vazio e esquecer de tratar aqui,
// o Dart avisa: "The type 'Status' is not exhaustively matched".
''', legenda: 'Repare: usa `=>` entre o caso e o valor, e vírgula no fim.'),
    BlocoCodigo(r'''
// Também funciona com condições (guard) usando `when`:
String faixa(int idade) => switch (idade) {
      < 13 => 'criança',
      < 18 => 'adolescente',
      _ when idade >= 60 => 'idoso',
      _ => 'adulto',
    };
''', legenda: 'O `_` é o "qualquer outro caso" (curinga).'),
    BlocoDica(
      'Prefira `switch` a uma escada de `if/else` quando você compara **a mesma '
      'variável** com vários valores. Fica mais legível e o compilador ajuda.',
    ),
  ],
);
