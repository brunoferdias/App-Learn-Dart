import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao02Variaveis = Licao(
  id: 'variaveis-e-tipos',
  titulo: 'Variáveis e tipos',
  resumo: 'var, final, const, os tipos básicos e a interpolação de texto.',
  nivel: NivelLicao.iniciante,
  minutos: 8,
  objetivos: [
    'Escolher entre var, final e const sem dúvida',
    'Conhecer int, double, String, bool, List e Map',
    'Montar textos com interpolação em vez de somar Strings',
  ],
  blocos: [
    BlocoTexto(
      'Variável é uma **caixa com nome** que guarda um valor. Em Dart você '
      'pode dizer o tipo da caixa ou deixar o Dart adivinhar.',
    ),
    BlocoCodigo(r'''
// 1) Tipo explícito — você escreve o tipo.
String nome = 'Ana';

// 2) Inferência — o Dart descobre sozinho que é String.
var cidade = 'Recife';

// 3) final — o valor é definido UMA vez e nunca mais muda.
final int idade = 25;

// 4) const — além de não mudar, já é conhecido na COMPILAÇÃO.
const double pi = 3.14;
''', legenda: 'Quatro maneiras de declarar. Todas corretas.'),
    BlocoTitulo('final × const: a dúvida clássica'),
    BlocoTexto(
      'Os dois impedem a variável de ser trocada. A diferença é **quando** o '
      'valor é conhecido: `const` precisa ser conhecido na hora de compilar; '
      '`final` pode ser descoberto só quando o app roda.',
    ),
    BlocoCodigo(r'''
final agora = DateTime.now(); // ✅ só dá para saber ao rodar
// const agora = DateTime.now(); // ❌ ERRO: não é constante de compilação

const taxa = 0.15;            // ✅ o valor já está escrito aqui
''', legenda: 'Regra prática: use final sempre; use const quando puder.'),
    BlocoDica(
      'Comece tudo com `final`. Só troque para `var` quando o compilador '
      'reclamar que você precisa mesmo reatribuir. Código com menos variáveis '
      'mutáveis tem menos bugs.',
    ),
    BlocoTitulo('Os tipos básicos'),
    BlocoTabela(
      cabecalho: ('Tipo', 'Para que serve'),
      linhas: [
        ('int', 'Número inteiro: 1, 42, -7'),
        ('double', 'Número com casas decimais: 3.14, 0.5'),
        ('num', 'Pai dos dois acima: aceita int OU double'),
        ('String', 'Texto: \'oi\' ou "oi"'),
        ('bool', 'Apenas true ou false'),
        ('List<T>', 'Lista ordenada: [1, 2, 3]'),
        ('Set<T>', 'Conjunto sem repetição: {1, 2}'),
        ('Map<K,V>', 'Pares chave→valor: {\'a\': 1}'),
        ('dynamic', 'Desliga a checagem de tipo — evite!'),
      ],
    ),
    BlocoCodigo(r'''
int curtidas = 120;
double nota = 9.5;
bool ativo = true;
String titulo = 'Aprenda Dart';
List<String> tags = ['dart', 'flutter'];
Map<String, int> placar = {'Ana': 10, 'Léo': 8};

// Conversões
int inteiro = int.parse('42');        // texto → int
double decimal = double.parse('3.5'); // texto → double
String texto = 42.toString();         // int → texto
int arredondado = 9.7.round();        // 10
''', legenda: 'Os tipos que você vai usar em 95% do tempo.'),
    BlocoTitulo('Interpolação: montando textos'),
    BlocoCodigo(
      r'''
final nome = 'Ana';
final itens = 3;

// ❌ Jeito trabalhoso
print('Olá ' + nome + ', você tem ' + itens.toString() + ' itens');

// ✅ Interpolação com $
print('Olá $nome, você tem $itens itens');

// Para expressões (com ponto, cálculo, chamada), use ${...}
print('Em maiúsculas: ${nome.toUpperCase()}');
print('Dobro: ${itens * 2}');
''',
      legenda: 'O cifrão puxa o valor da variável para dentro do texto.',
      saida: 'Olá Ana, você tem 3 itens\nEm maiúsculas: ANA\nDobro: 6',
    ),
    BlocoAviso(
      'Use `\$variavel` só para nomes simples. Se tiver ponto, parênteses ou '
      'conta, precisa das chaves: `\${objeto.campo}`.',
    ),
    BlocoTitulo('Cuidado com dynamic'),
    BlocoComparacao(
      codigoErrado: r'''
dynamic valor = 'texto';
valor = 10;
print(valor.length); // 💥 quebra só ao RODAR''',
      notaErrado:
          '`dynamic` desliga a proteção do compilador. O erro só aparece com '
          'o app na mão do usuário.',
      codigoCerto: r'''
String valor = 'texto';
print(valor.length); // 5 — seguro''',
      notaCerto:
          'Com tipo definido, a IDE já avisa antes mesmo de você salvar.',
    ),
    BlocoTexto(
      'Existe também `Object?`, que aceita qualquer coisa **sem** desligar a '
      'checagem: para usar o valor você é obrigado a verificar o tipo antes. '
      'É a alternativa segura ao `dynamic`.',
    ),
  ],
);
