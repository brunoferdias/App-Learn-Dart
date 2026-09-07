import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao03NullSafety = Licao(
  id: 'null-safety',
  titulo: 'Null Safety',
  resumo: 'O superpoder do Dart: o compilador impede o erro de valor nulo.',
  nivel: NivelLicao.iniciante,
  minutos: 14,
  objetivos: [
    'Diferenciar String de String?',
    'Usar ?., ??, ??= e ! sabendo o que cada um faz',
    'Entender promoção de tipo e quando usar late',
    'Nunca mais tomar "Null check operator used on a null value"',
  ],
  blocos: [
    BlocoTexto(
      'O erro mais comum da história da programação é usar algo que **não '
      'existe** — o famoso *null pointer*. O Dart resolveu isso na raiz: por '
      'padrão, **nenhuma variável pode ser nula**.',
    ),
    BlocoCodigo(r'''
String nome = 'Ana';
// nome = null; // ❌ ERRO DE COMPILAÇÃO: String não aceita null

String? apelido = 'Aninha';
apelido = null;  // ✅ pode: o ? diz "isto pode estar vazio"
''', legenda: 'A interrogação muda TUDO: ela cria um tipo diferente.'),
    BlocoTexto(
      '`String` e `String?` são **dois tipos distintos**. O primeiro promete '
      'que sempre tem texto. O segundo avisa: "pode ser texto, pode ser nada — '
      'trate os dois casos".',
    ),
    BlocoTitulo('Por que isso é tão bom?'),
    BlocoTexto(
      'Porque o erro sai do celular do usuário e vem para a sua tela, '
      'sublinhado de vermelho, antes de você compilar.',
    ),
    BlocoCodigo(r'''
String? apelido;          // começa null

// print(apelido.length); // ❌ o Dart NÃO deixa nem compilar
                          //    "The property 'length' can't be
                          //     unconditionally accessed"
''', legenda: 'O compilador te protege de você mesmo.'),
    BlocoTitulo('Os quatro operadores que você precisa decorar'),
    BlocoTabela(
      cabecalho: ('Operador', 'O que faz'),
      linhas: [
        ('?.', 'Acesso seguro: se for null, para tudo e devolve null'),
        ('??', 'Valor padrão: "use isto se o da esquerda for null"'),
        ('??=', 'Atribui só se estiver null'),
        ('!', 'Afirma "confia, não é null" — perigoso, use por último'),
      ],
    ),
    BlocoCodigo(
      r'''
String? apelido;

// ?.  → chamada segura
print(apelido?.length);        // null (não quebra!)
print(apelido?.toUpperCase()); // null

// ??  → valor padrão
final exibicao = apelido ?? 'Sem apelido';
print(exibicao);               // Sem apelido

// ??= → só preenche se estiver vazio
apelido ??= 'Visitante';
print(apelido);                // Visitante
apelido ??= 'Outro';
print(apelido);                // Visitante (já tinha valor, ignorou)

// Encadeando: seguro + padrão na mesma linha
final tamanho = apelido?.length ?? 0;
print(tamanho);                // 9
''',
      legenda: 'Este é o kit de sobrevivência do null safety.',
      saida: 'null\nnull\nSem apelido\nVisitante\nVisitante\n9',
    ),
    BlocoTitulo('O operador ! (bang) — use com medo'),
    BlocoTexto(
      'O `!` diz ao compilador: *"eu garanto que aqui não é nulo, pode '
      'confiar"*. Se você mentir, o app **quebra em tempo de execução**. É '
      'literalmente abrir mão da proteção.',
    ),
    BlocoComparacao(
      codigoErrado: r'''
String? nome = buscarNome();
print(nome!.length);
// 💥 Se buscarNome() devolver null:
// Null check operator used on a null value''',
      notaErrado:
          'Você trocou um erro de compilação por um crash. Péssimo negócio.',
      codigoCerto: r'''
String? nome = buscarNome();
if (nome != null) {
  print(nome.length); // sem ! nenhum aqui 👇
}
// ou, mais curto:
print(nome?.length ?? 0);''',
      notaCerto:
          'Dentro do `if`, o Dart já SABE que não é nulo. Isso se chama '
          'promoção de tipo.',
    ),
    BlocoTitulo('Promoção de tipo (type promotion)'),
    BlocoTexto(
      'Quando você verifica `!= null`, o Dart **promove** a variável de `String?` '
      'para `String` dentro daquele bloco. Você não precisa do `!` nem do `?.` '
      'ali dentro — é o compilador raciocinando junto com você.',
    ),
    BlocoCodigo(r'''
void saudar(String? nome) {
  if (nome == null) {
    print('Olá, visitante!');
    return; // saímos cedo — daqui para baixo nome NÃO é null
  }

  // Aqui nome é String (promovido!), não String?
  print('Olá, ${nome.toUpperCase()}');
}
''', legenda: 'O padrão "early return" deixa o resto da função limpo.'),
    BlocoAviso(
      'A promoção **não funciona** em campos de classe que não sejam `final`, '
      'porque outra parte do código poderia mudar o valor no meio do caminho. '
      'Solução: copie para uma variável local primeiro.',
    ),
    BlocoCodigo(r'''
class Perfil {
  String? bio;

  void mostrar() {
    // ❌ if (bio != null) print(bio.length);  → não promove!

    final b = bio;            // ✅ cópia local
    if (b != null) {
      print(b.length);        // agora promove numa boa
    }
  }
}
''', legenda: 'A famosa "cópia local" — memorize este truque.'),
    BlocoTitulo('late: prometo preencher depois'),
    BlocoTexto(
      '`late` serve para dizer: *"esta variável não é nula, só não sei o valor '
      'agora — antes de alguém ler, eu preencho"*. Se você quebrar a promessa, '
      'o erro aparece na hora da leitura.',
    ),
    BlocoCodigo(r'''
class Tela {
  late final String titulo; // sem valor ainda, mas nunca será null

  void iniciar() {
    titulo = 'Carregado!'; // preenchido aqui
  }
}

// Bônus: late também adia cálculos caros.
// A função só roda na PRIMEIRA vez que alguém ler `dados`.
late final dados = calculoDemorado();
''', legenda: 'late = "confie em mim, eu preencho antes de usar".'),
    BlocoTitulo('Null safety em listas e mapas'),
    BlocoCodigo(r'''
List<String>? listaTalvezNula;  // a LISTA pode ser nula
List<String?> listaComNulos;    // a lista existe, os ITENS podem ser nulos
List<String?>? ambos;           // os dois podem ser nulos 😅

// Mapa SEMPRE devolve tipo anulável: a chave pode não existir!
final idades = {'Ana': 30};
int? idade = idades['Léo']; // null — e o Dart já te obriga a tratar
print(idade ?? 0);          // 0
''', legenda: 'Onde o ? aparece muda completamente o significado.'),
    BlocoDica(
      'Acessar um mapa **sempre** devolve um tipo com `?`. Isso é o Dart '
      'lembrando que a chave pode não existir. Trate com `??` e siga a vida.',
    ),
    BlocoTitulo('required: null safety nos parâmetros'),
    BlocoCodigo(
      r'''
// Parâmetros nomeados são opcionais por padrão.
// Se o tipo não aceita null, o Dart EXIGE `required` ou um valor padrão.

void criarUsuario({
  required String nome,     // obrigatório
  String? email,            // opcional, pode vir nulo
  int idade = 18,           // opcional com valor padrão
}) {
  print('$nome | ${email ?? "sem e-mail"} | $idade anos');
}

void main() {
  criarUsuario(nome: 'Ana');
  criarUsuario(nome: 'Léo', email: 'leo@x.com', idade: 30);
}
''',
      saida: 'Ana | sem e-mail | 18 anos\nLéo | leo@x.com | 30 anos',
      legenda: 'Null safety e parâmetros andam sempre juntos.',
    ),
    BlocoTitulo('Resumo em 5 linhas'),
    BlocoLista([
      '`Tipo` = nunca nulo. `Tipo?` = pode ser nulo.',
      'Use `?.` para acessar com segurança.',
      'Use `??` para dar um valor padrão.',
      'Use `if (x != null)` e deixe o Dart promover o tipo.',
      'Use `!` só quando tiver **certeza absoluta** — e prefira não usar.',
    ]),
  ],
);
