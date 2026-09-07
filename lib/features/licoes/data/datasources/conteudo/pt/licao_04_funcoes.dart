import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao04Funcoes = Licao(
  id: 'funcoes',
  titulo: 'Funções de A a Z',
  resumo:
      'Anatomia, arrow, parâmetros posicionais, opcionais, nomeados, anônimas, '
      'closures e funções que recebem funções.',
  nivel: NivelLicao.iniciante,
  minutos: 18,
  objetivos: [
    'Ler e escrever qualquer assinatura de função Dart',
    'Escolher entre parâmetro posicional, opcional e nomeado',
    'Usar arrow (=>) sem confundir com bloco { }',
    'Entender funções anônimas, closures e ordem superior',
  ],
  blocos: [
    BlocoTexto(
      'Função é um **pedaço de código com nome** que você pode chamar quantas '
      'vezes quiser. Em Dart, funções também são **valores**: dá para guardar '
      'em variáveis, passar como parâmetro e devolver de outra função.',
    ),
    BlocoTitulo('1. Anatomia de uma função'),
    BlocoCodigo(
      r'''
int somar(int a, int b) {
  return a + b;
}
// ↑    ↑     ↑            ↑
// │    │     │            └─ corpo: o que ela faz
// │    │     └─ parâmetros: o que ela recebe (com tipo!)
// │    └─ nome: em lowerCamelCase, começando com verbo
// └─ tipo de retorno: o que ela devolve
''',
      legenda:
          'Leia sempre de trás para frente: "somar recebe dois int e devolve um int".',
    ),
    BlocoTabela(
      cabecalho: ('Tipo de retorno', 'Quando usar'),
      linhas: [
        ('int, String, bool…', 'A função devolve um valor desse tipo'),
        ('void', 'A função só EXECUTA algo, não devolve nada'),
        ('String?', 'Pode devolver um texto OU null'),
        ('Future<T>', 'Devolve depois (assíncrono) — ver lição de async'),
        ('(nada escrito)', 'Vira dynamic — evite, sempre escreva o tipo'),
      ],
    ),
    BlocoTitulo('2. Arrow: função de uma linha só'),
    BlocoTexto(
      'Quando o corpo é **uma única expressão**, troque `{ return x; }` por '
      '`=> x`. É a mesma coisa, escrita curta.',
    ),
    BlocoCodigo(r'''
// Forma longa
int dobro(int n) {
  return n * 2;
}

// Forma arrow — idêntica em comportamento
int dobroCurto(int n) => n * 2;

// Arrow também funciona com void
void log(String msg) => print('[LOG] $msg');
''', legenda: '=> significa literalmente "return isto".'),
    BlocoAviso(
      'Não escreva `=> { return n * 2; }`. As chaves depois da seta criam um '
      '**mapa vazio**, não um bloco — erro clássico de quem está começando.',
    ),
    BlocoTitulo('3. Parâmetros POSICIONAIS obrigatórios'),
    BlocoCodigo(
      r'''
void apresentar(String nome, int idade) {
  print('$nome tem $idade anos');
}

apresentar('Ana', 30);   // ✅ a ORDEM importa
// apresentar(30, 'Ana'); // ❌ tipos trocados: erro de compilação
// apresentar('Ana');     // ❌ falta um argumento
''',
      legenda: 'O padrão: obrigatórios, na ordem exata.',
      saida: 'Ana tem 30 anos',
    ),
    BlocoTitulo('4. Parâmetros POSICIONAIS opcionais  [ ]'),
    BlocoTexto(
      'Colchetes deixam o parâmetro opcional. Como pode não vir nada, o tipo '
      'precisa aceitar null (`String?`) **ou** ter valor padrão.',
    ),
    BlocoCodigo(
      r'''
String saudacao(String nome, [String? titulo, String pontuacao = '!']) {
  final prefixo = titulo == null ? '' : '$titulo ';
  return 'Olá, $prefixo$nome$pontuacao';
}

print(saudacao('Ana'));                 // Olá, Ana!
print(saudacao('Ana', 'Dra.'));         // Olá, Dra. Ana!
print(saudacao('Ana', 'Dra.', '...'));  // Olá, Dra. Ana...
''',
      legenda: 'Você só pode omitir do FIM para o começo.',
      saida: 'Olá, Ana!\nOlá, Dra. Ana!\nOlá, Dra. Ana...',
    ),
    BlocoTitulo('5. Parâmetros NOMEADOS  { }  ← o preferido no Flutter'),
    BlocoTexto(
      'Com chaves, quem chama escreve o nome do parâmetro. A ordem deixa de '
      'importar e o código fica **autoexplicativo**. É por isso que todo '
      'widget do Flutter usa isso.',
    ),
    BlocoCodigo(r'''
void criarBotao({
  required String texto,        // obrigatório
  Color cor = Colors.blue,      // opcional com padrão
  VoidCallback? aoTocar,        // opcional, pode ser null
}) {
  print('Botão "$texto"');
}

// A ordem não importa e fica claro o que é cada coisa:
criarBotao(texto: 'Salvar');
criarBotao(cor: Colors.red, texto: 'Excluir');
''', legenda: '`required` obriga; sem ele, o parâmetro é opcional.'),
    BlocoComparacao(
      codigoErrado: r'''
void criarBotao({String texto}) {}
// ❌ ERRO: "The parameter 'texto' can't have
// a value of null because of its type"''',
      notaErrado:
          'Parâmetro nomeado é opcional por padrão. Se o tipo não aceita null, '
          'o Dart exige que você resolva isso.',
      codigoCerto: r'''
void criarBotao({required String texto}) {}
// ou
void criarBotao({String texto = 'OK'}) {}
// ou
void criarBotao({String? texto}) {}''',
      notaCerto: 'Três saídas válidas: obrigar, dar padrão, ou aceitar null.',
    ),
    BlocoTitulo('6. Misturando os três'),
    BlocoCodigo(
      r'''
// Regra: posicionais obrigatórios vêm SEMPRE primeiro.
void enviar(
  String destino, {           // posicional obrigatório
  required String mensagem,   // nomeado obrigatório
  bool urgente = false,       // nomeado com padrão
  String? assinatura,         // nomeado anulável
}) {
  final marca = urgente ? '🔴 ' : '';
  print('$marca$destino: $mensagem ${assinatura ?? ""}');
}

enviar('ana@x.com', mensagem: 'Oi!', urgente: true);
''',
      saida: '🔴 ana@x.com: Oi! ',
      legenda: 'Você NÃO pode usar [ ] e { } na mesma função — escolha um.',
    ),
    BlocoTitulo('7. Funções anônimas (lambdas)'),
    BlocoTexto(
      'Função sem nome, criada na hora. Você usa isso o tempo todo em listas e '
      'em callbacks de botão.',
    ),
    BlocoCodigo(r'''
final nomes = ['ana', 'léo', 'bia'];

// Função anônima com bloco
nomes.forEach((nome) {
  print(nome.toUpperCase());
});

// Função anônima com arrow (mesma coisa, mais curta)
nomes.forEach((nome) => print(nome.toUpperCase()));

// Guardando uma função dentro de uma variável
final int Function(int) triplo = (n) => n * 3;
print(triplo(5)); // 15

// Tear-off: passar a função pelo NOME, sem parênteses
nomes.forEach(print); // equivale a (n) => print(n)
''', legenda: '`int Function(int)` é o TIPO de uma função.'),
    BlocoTitulo('8. Funções de ordem superior'),
    BlocoTexto(
      'São funções que **recebem** ou **devolvem** outras funções. Parece '
      'complicado, mas você já usa: `map`, `where` e `onPressed` são assim.',
    ),
    BlocoCodigo(r'''
// Recebe uma função como parâmetro
void repetir(int vezes, void Function(int) acao) {
  for (var i = 1; i <= vezes; i++) {
    acao(i);
  }
}

repetir(3, (i) => print('Volta $i'));

// Devolve uma função
Function(int) multiplicadorPor(int fator) {
  return (int n) => n * fator;
}

final dobrar = multiplicadorPor(2);
print(dobrar(10)); // 20
''', saida: 'Volta 1\nVolta 2\nVolta 3\n20'),
    BlocoTitulo('9. Closure: a função que lembra'),
    BlocoTexto(
      'Uma função criada dentro de outra **guarda** as variáveis do lugar onde '
      'nasceu, mesmo depois que a função de fora terminou. Isso é uma closure.',
    ),
    BlocoCodigo(
      r'''
Function contador() {
  var total = 0;        // vive "dentro" da closure
  return () {
    total++;            // continua existindo entre as chamadas!
    print('Chamada nº $total');
  };
}

final contar = contador();
contar(); // Chamada nº 1
contar(); // Chamada nº 2
contar(); // Chamada nº 3
''',
      saida: 'Chamada nº 1\nChamada nº 2\nChamada nº 3',
      legenda: 'Cada chamada de contador() cria um total independente.',
    ),
    BlocoTitulo('10. typedef: apelido para tipos de função'),
    BlocoCodigo(r'''
// Sem typedef — assinatura enorme e repetida:
void aoMudar(void Function(String texto, bool valido) callback) {}

// Com typedef — legível:
typedef ValidadorTexto = void Function(String texto, bool valido);

void aoMudarLimpo(ValidadorTexto callback) {}
''', legenda: 'O Flutter faz isso: `VoidCallback` é `void Function()`.'),
    BlocoTitulo('11. Funções genéricas'),
    BlocoCodigo(r'''
// <T> = "funciona com qualquer tipo, e eu devolvo o MESMO tipo"
T primeiro<T>(List<T> lista) => lista.first;

final n = primeiro<int>([1, 2, 3]);      // n é int
final s = primeiro(['a', 'b']);          // s é String (inferido!)
''', legenda: 'Genéricos evitam duplicar a função para cada tipo.'),
    BlocoDica(
      'Nomes de função descrevem AÇÃO: `calcularTotal`, `buscarUsuario`, '
      '`validarEmail`. Se o nome tem "e" no meio (`salvarEEnviar`), '
      'provavelmente são duas funções.',
    ),
    BlocoTitulo('Cola rápida'),
    BlocoTabela(
      cabecalho: ('Sintaxe', 'Significado'),
      linhas: [
        ('f(a, b)', 'Posicionais obrigatórios'),
        ('f(a, [b])', 'b é posicional opcional'),
        ('f({a, b})', 'a e b são nomeados opcionais'),
        ('f({required a})', 'a é nomeado obrigatório'),
        ('f({a = 1})', 'a é nomeado com valor padrão'),
        ('=> x', 'Corpo de uma expressão só (return implícito)'),
        ('(x) => x * 2', 'Função anônima'),
        ('int Function(int)', 'Tipo "função que recebe int e devolve int"'),
      ],
    ),
  ],
);
