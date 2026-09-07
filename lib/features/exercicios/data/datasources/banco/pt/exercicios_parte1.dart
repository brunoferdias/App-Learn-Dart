import '../../../../domain/entities/exercicio.dart';

const List<Exercicio> exerciciosParte1 = [
  ExercicioCertoOuErrado(
    id: 'e1-1',
    licaoId: 'primeiros-passos',
    codigo: '''void main() {
  print('Olá, Dart!')
}''',
    estaCorreto: false,
    explicacao:
        'Falta o ponto e vírgula no fim da linha do print. Em Dart o `;` é '
        'obrigatório ao final de cada comando.',
  ),
  ExercicioCertoOuErrado(
    id: 'e1-2',
    licaoId: 'primeiros-passos',
    codigo: '''void Main() {
  print('Oi');
}''',
    estaCorreto: false,
    explicacao:
        'Dart diferencia maiúsculas de minúsculas. O ponto de entrada precisa '
        'se chamar exatamente `main` — com M maiúsculo é só uma função comum, '
        'e o programa não tem por onde começar.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e1-3',
    licaoId: 'primeiros-passos',
    enunciado: 'Para que serve o comentário de três barras `///`?',
    opcoes: [
      'Escrever documentação que a IDE mostra ao passar o mouse',
      'Comentar várias linhas de uma vez',
      'Fazer o Dart ignorar o arquivo inteiro',
      'Nada, é igual a `//`',
    ],
    resposta: 0,
    explicacao:
        'O `///` é o comentário de documentação (DartDoc). Ele vira a ajuda '
        'que aparece na IDE e pode gerar site de documentação.',
  ),
  ExercicioCompletar(
    id: 'e1-4',
    licaoId: 'primeiros-passos',
    codigoComLacuna: '''___ main() {
  print('Começou!');
}''',
    opcoes: ['void', 'String', 'int', 'var'],
    resposta: 0,
    explicacao:
        '`void` significa "não devolve nada". A função main normalmente não '
        'retorna valor algum, então `void main()` é a assinatura padrão.',
  ),

  ExercicioCertoOuErrado(
    id: 'e2-1',
    licaoId: 'variaveis-e-tipos',
    codigo: '''final nome = 'Ana';
nome = 'Bia';''',
    estaCorreto: false,
    explicacao:
        'Uma variável `final` recebe valor UMA única vez. A segunda atribuição '
        'gera erro de compilação. Se precisa mudar, use `var`.',
  ),
  ExercicioCertoOuErrado(
    id: 'e2-2',
    licaoId: 'variaveis-e-tipos',
    codigo: '''const agora = DateTime.now();''',
    estaCorreto: false,
    explicacao:
        '`const` exige um valor conhecido em tempo de COMPILAÇÃO, e a hora '
        'atual só existe quando o app roda. O certo aqui é `final`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e2-3',
    licaoId: 'variaveis-e-tipos',
    enunciado: 'Qual é a saída deste código?',
    codigo: '''final nome = 'Ana';
print('Oi, \${nome.toUpperCase()}!');''',
    opcoes: [r'Oi, ANA!', r'Oi, ${nome.toUpperCase()}!', r'Oi, Ana!', 'Erro'],
    resposta: 0,
    explicacao:
        'As chaves `\${...}` permitem colocar uma EXPRESSÃO dentro do texto. '
        '`toUpperCase()` devolve o texto em maiúsculas.',
  ),
  ExercicioCompletar(
    id: 'e2-4',
    licaoId: 'variaveis-e-tipos',
    enunciado: 'Complete para imprimir "Total: 30":',
    codigoComLacuna: '''final preco = 10;
final qtd = 3;
print('Total: ___');''',
    opcoes: [
      r'${preco * qtd}',
      r'$preco * qtd',
      r'preco * qtd',
      r'$(preco*qtd)',
    ],
    resposta: 0,
    explicacao:
        'Cálculos dentro de uma String precisam das chaves: `\${preco * qtd}`. '
        'Com apenas `\$preco * qtd` o Dart substitui só a variável e deixa '
        '" * qtd" como texto literal.',
  ),

  ExercicioCertoOuErrado(
    id: 'e3-1',
    licaoId: 'null-safety',
    codigo: '''String nome = null;''',
    estaCorreto: false,
    explicacao:
        'Com null safety, `String` NUNCA aceita null. Para permitir vazio use '
        '`String? nome = null;`.',
  ),
  ExercicioCertoOuErrado(
    id: 'e3-2',
    licaoId: 'null-safety',
    codigo: '''String? apelido;
print(apelido?.length ?? 0);''',
    estaCorreto: true,
    explicacao:
        'Perfeito: `?.` evita o acesso quando é null (devolvendo null) e o '
        '`??` fornece o valor padrão 0. Nenhum risco de crash.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e3-3',
    licaoId: 'null-safety',
    enunciado: 'O que este código imprime?',
    codigo: '''String? nome;
nome ??= 'Visitante';
nome ??= 'Outro';
print(nome);''',
    opcoes: ['Visitante', 'Outro', 'null', 'Erro de compilação'],
    resposta: 0,
    explicacao:
        '`??=` só atribui se a variável estiver null. Na primeira linha ela '
        'estava, então virou "Visitante". Na segunda já tinha valor, então o '
        'comando foi ignorado.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e3-4',
    licaoId: 'null-safety',
    enunciado: 'Qual é o problema deste código?',
    codigo: '''String? buscar() => null;

void main() {
  print(buscar()!.length);
}''',
    opcoes: [
      'O `!` promete que não é null, mas é — o app quebra ao rodar',
      'Nada, funciona normalmente',
      'Falta marcar main como async',
      '`length` não existe em String',
    ],
    resposta: 0,
    explicacao:
        'O `!` desliga a proteção. Como a função devolve null de verdade, o '
        'app lança "Null check operator used on a null value". Use `?.` com '
        '`??`, ou verifique com `if`.',
  ),
  ExercicioCompletar(
    id: 'e3-5',
    licaoId: 'null-safety',
    enunciado: 'Complete para usar o e-mail com um padrão quando não houver:',
    codigoComLacuna: '''String? email;
final exibir = email ___ 'sem e-mail';''',
    opcoes: ['??', '?.', '!', '||'],
    resposta: 0,
    explicacao:
        'O `??` significa "se o da esquerda for null, use o da direita". O '
        '`?.` serve para ACESSAR membros com segurança, não para dar padrão.',
  ),
  ExercicioCompletar(
    id: 'e3-6',
    licaoId: 'null-safety',
    enunciado:
        'Complete para que o campo não seja anulável, mas preenchido depois:',
    codigoComLacuna: '''class Tela {
  ___ final String titulo;

  void iniciar() {
    titulo = 'Pronto';
  }
}''',
    opcoes: ['late', 'const', 'static', 'dynamic'],
    resposta: 0,
    explicacao:
        '`late final` significa "juro que preencho antes de alguém ler". '
        'Assim o campo continua sendo `String` (nunca nulo) sem precisar de '
        'valor no construtor.',
  ),

  ExercicioCertoOuErrado(
    id: 'e4-1',
    licaoId: 'funcoes',
    codigo: '''int dobro(int n) => { return n * 2; };''',
    estaCorreto: false,
    explicacao:
        'Depois de `=>` vai apenas UMA expressão, sem chaves e sem `return`. '
        'As chaves ali criam um mapa. O certo é `int dobro(int n) => n * 2;`.',
  ),
  ExercicioCertoOuErrado(
    id: 'e4-2',
    licaoId: 'funcoes',
    codigo: '''void criar({String nome}) {
  print(nome);
}''',
    estaCorreto: false,
    explicacao:
        'Parâmetro nomeado é opcional por padrão, então ele poderia chegar '
        'null — e `String` não aceita null. Use `required String nome`, ou '
        '`String? nome`, ou um valor padrão.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e4-3',
    licaoId: 'funcoes',
    enunciado: 'Qual chamada é VÁLIDA para esta função?',
    codigo:
        '''void enviar(String para, {required String texto, bool urgente = false}) {}''',
    opcoes: [
      "enviar('ana@x.com', texto: 'Oi')",
      "enviar(texto: 'Oi', 'ana@x.com')",
      "enviar('ana@x.com', 'Oi')",
      "enviar(para: 'ana@x.com', texto: 'Oi')",
    ],
    resposta: 0,
    explicacao:
        '`para` é posicional (vem primeiro, sem nome) e `texto` é nomeado '
        'obrigatório. `urgente` tem padrão, então pode ser omitido.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e4-4',
    licaoId: 'funcoes',
    enunciado: 'O que este código imprime?',
    codigo: '''Function contador() {
  var n = 0;
  return () => ++n;
}

void main() {
  final c = contador();
  c();
  c();
  print(c());
}''',
    opcoes: ['3', '1', '0', 'null'],
    resposta: 0,
    explicacao:
        'Isso é uma CLOSURE: a função devolvida guarda a variável `n` do lugar '
        'onde nasceu. Cada chamada incrementa o mesmo `n`: 1, 2 e por fim 3.',
  ),
  ExercicioCompletar(
    id: 'e4-5',
    licaoId: 'funcoes',
    enunciado: 'Complete para tornar o parâmetro nomeado OBRIGATÓRIO:',
    codigoComLacuna: '''void criarBotao({___ String texto}) {
  print(texto);
}''',
    opcoes: ['required', 'final', 'late', 'const'],
    resposta: 0,
    explicacao:
        '`required` obriga quem chama a passar o argumento. É o que todo '
        'widget do Flutter faz com seus parâmetros essenciais.',
  ),
  ExercicioCompletar(
    id: 'e4-6',
    licaoId: 'funcoes',
    enunciado: 'Complete o tipo desta variável que guarda uma função:',
    codigoComLacuna: '''___ triplo = (n) => n * 3;
print(triplo(5)); // 15''',
    opcoes: ['int Function(int)', 'Function<int>', 'int(int)', 'var Function'],
    resposta: 0,
    explicacao:
        'O tipo de uma função se escreve `Retorno Function(Parâmetros)`. Aqui: '
        'recebe um int e devolve um int.',
  ),

  ExercicioCertoOuErrado(
    id: 'e5-1',
    licaoId: 'controle-de-fluxo',
    codigo: '''final nome = 'Ana';
if (nome) {
  print('tem nome');
}''',
    estaCorreto: false,
    explicacao:
        'Em Dart a condição do `if` precisa ser `bool`. Não existe "valor '
        'verdadeiro" como em JavaScript. O certo: `if (nome.isNotEmpty)`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e5-2',
    licaoId: 'controle-de-fluxo',
    enunciado: 'O que este laço imprime?',
    codigo: '''for (final n in [1, 2, 3, 4]) {
  if (n == 2) continue;
  if (n == 4) break;
  print(n);
}''',
    opcoes: ['1 e 3', '1, 2 e 3', '1, 3 e 4', 'Somente 1'],
    resposta: 0,
    explicacao:
        '`continue` pula apenas aquela volta (o 2 não é impresso) e `break` '
        'encerra o laço inteiro antes de imprimir o 4.',
  ),
  ExercicioCompletar(
    id: 'e5-3',
    licaoId: 'controle-de-fluxo',
    enunciado: 'Complete o switch-expressão:',
    codigoComLacuna: '''enum Status { ok, erro }

String msg(Status s) ___ switch (s) {
      Status.ok => 'Tudo certo',
      Status.erro => 'Falhou',
    };''',
    opcoes: ['=>', '=', '{', ':'],
    resposta: 0,
    explicacao:
        'A função devolve o resultado do switch em uma única expressão, então '
        'usamos a seta `=>`. Note também a `;` no fim e as vírgulas entre os '
        'casos — é sintaxe de expressão, não de bloco.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e5-4',
    licaoId: 'controle-de-fluxo',
    enunciado:
        'Você adiciona `Status.carregando` ao enum e esquece de tratá-lo no '
        'switch-expressão. O que acontece?',
    opcoes: [
      'O compilador acusa que o switch não é exaustivo',
      'O app roda e devolve null naquele caso',
      'Nada, o Dart usa o primeiro caso',
      'Lança exceção somente em produção',
    ],
    resposta: 0,
    explicacao:
        'Essa é a grande vantagem do switch-expressão com enum ou sealed: o '
        'erro aparece na compilação, não na mão do usuário.',
  ),
];
