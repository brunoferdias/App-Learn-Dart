import '../../../../domain/entities/exercicio.dart';

const List<Exercicio> exerciciosParte2 = [
  ExercicioCertoOuErrado(
    id: 'e6-1',
    licaoId: 'colecoes',
    codigo: '''final lista = [10, 20, 30];
print(lista[3]);''',
    estaCorreto: false,
    explicacao:
        'Índices começam em 0. Numa lista de 3 itens os válidos são 0, 1 e 2 — '
        '`lista[3]` lança RangeError. O último item é `lista.last`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e6-2',
    licaoId: 'colecoes',
    enunciado: 'Qual é o tipo de `preco` aqui?',
    codigo: '''final precos = <String, double>{'café': 5.0};
final preco = precos['pizza'];''',
    opcoes: ['double?', 'double', 'null', 'dynamic'],
    resposta: 0,
    explicacao:
        'Acessar um Map sempre devolve tipo anulável, porque a chave pode não '
        'existir. Aqui `preco` é `double?` e vale null. Trate com `?? 0`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e6-3',
    licaoId: 'colecoes',
    enunciado: 'O que este código imprime?',
    codigo: '''final n = [1, 2, 3, 4];
print(n.where((x) => x.isEven).map((x) => x * 10).toList());''',
    opcoes: ['[20, 40]', '[10, 20, 30, 40]', '[2, 4]', '[10, 30]'],
    resposta: 0,
    explicacao:
        'Primeiro `where` filtra os pares (2 e 4), depois `map` multiplica '
        'cada um por 10. A ordem das chamadas importa!',
  ),
  ExercicioCompletar(
    id: 'e6-4',
    licaoId: 'colecoes',
    enunciado: 'Complete para incluir o item apenas quando `ehAdmin` for true:',
    codigoComLacuna: '''final menu = [
  'Início',
  ___ (ehAdmin) 'Painel',
];''',
    opcoes: ['if', 'when', 'case', 'for'],
    resposta: 0,
    explicacao:
        'O "collection if" permite condicionar um item dentro da própria '
        'lista — é o que você usa em `children:` no Flutter para mostrar ou '
        'esconder um widget.',
  ),
  ExercicioCertoOuErrado(
    id: 'e6-5',
    licaoId: 'colecoes',
    codigo: '''final usuarios = <String>[];
final achado = usuarios.firstWhere((u) => u == 'ana');''',
    estaCorreto: false,
    explicacao:
        '`firstWhere` sem o parâmetro `orElse` lança StateError quando nada '
        'combina. Use `.where(...).firstOrNull` e trate o `null`.',
  ),

  ExercicioCertoOuErrado(
    id: 'e7-1',
    licaoId: 'classes-e-objetos',
    codigo: '''class Produto {
  const Produto(this.nome);
  String nome;
}''',
    estaCorreto: false,
    explicacao:
        'Um construtor `const` exige que TODOS os campos sejam `final`. Troque '
        'para `final String nome;`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e7-2',
    licaoId: 'classes-e-objetos',
    enunciado: 'Qual palavra-chave adiciona comportamento pronto sem herança?',
    opcoes: ['with (mixin)', 'implements', 'extends', 'abstract'],
    resposta: 0,
    explicacao:
        '`with` aplica um mixin: código reutilizável que você "mistura" na '
        'classe. `extends` é herança (só uma), e `implements` copia apenas o '
        'contrato — você reescreve tudo.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e7-3',
    licaoId: 'classes-e-objetos',
    enunciado: 'O que este código imprime?',
    codigo: '''class R {
  R(this.l, this.a);
  double l, a;
  double get area => l * a;
}

print(R(3, 4).area);''',
    opcoes: ['12.0', '12', 'Instance of R', 'Erro: falta ()'],
    resposta: 0,
    explicacao:
        'Getter é lido SEM parênteses. Como os campos são `double`, o '
        'resultado sai como `12.0`.',
  ),
  ExercicioCompletar(
    id: 'e7-4',
    licaoId: 'classes-e-objetos',
    enunciado: 'Complete para chamar o construtor da classe pai:',
    codigoComLacuna: '''class Cachorro extends Animal {
  Cachorro(___ nome);
}''',
    opcoes: ['super.', 'this.', 'parent.', 'base.'],
    resposta: 0,
    explicacao:
        '`super.nome` repassa o parâmetro direto para o construtor do pai — '
        'atalho moderno que substitui `Cachorro(String nome) : super(nome);`.',
  ),
  ExercicioCompletar(
    id: 'e7-5',
    licaoId: 'classes-e-objetos',
    enunciado: 'Complete para adicionar um método ao tipo String:',
    codigoComLacuna: '''___ TextoUtil on String {
  bool get ehEmail => contains('@');
}''',
    opcoes: ['extension', 'mixin', 'class', 'abstract class'],
    resposta: 0,
    explicacao:
        '`extension X on Tipo` adiciona métodos e getters a um tipo que você '
        'não escreveu, sem herdar nem embrulhar nada.',
  ),

  ExercicioCertoOuErrado(
    id: 'e8-1',
    licaoId: 'assincronia',
    codigo: '''void main() {
  final nome = await buscarNome();
  print(nome);
}''',
    estaCorreto: false,
    explicacao:
        '`await` só pode ser usado dentro de função marcada com `async`. O '
        'certo é `void main() async { ... }`.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e8-2',
    licaoId: 'assincronia',
    enunciado: 'O que é impresso se você ESQUECER o `await`?',
    codigo: '''Future<String> buscar() async => 'Ana';

void main() async {
  final nome = buscar();
  print(nome);
}''',
    opcoes: [
      "Instance of 'Future<String>'",
      'Ana',
      'null',
      'Erro de compilação',
    ],
    resposta: 0,
    explicacao:
        'Sem `await` você guarda a PROMESSA, não o valor. Esse é o bug '
        'assíncrono mais comum de todos.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e8-3',
    licaoId: 'assincronia',
    enunciado:
        'Duas buscas levam 2 segundos cada e são independentes. Qual forma '
        'termina em ~2s no total?',
    opcoes: [
      'await Future.wait([buscarA(), buscarB()])',
      'await buscarA(); await buscarB();',
      'buscarA(); buscarB();',
      'await buscarA().then(buscarB)',
    ],
    resposta: 0,
    explicacao:
        '`Future.wait` dispara as duas ao mesmo tempo e espera as duas. Dois '
        '`await` seguidos rodam em sequência: 4 segundos.',
  ),
  ExercicioCompletar(
    id: 'e8-4',
    licaoId: 'assincronia',
    enunciado: 'Complete para o bloco que roda SEMPRE, com erro ou sem erro:',
    codigoComLacuna: '''try {
  await carregar();
} catch (e) {
  print(e);
} ___ {
  esconderLoading();
}''',
    opcoes: ['finally', 'always', 'else', 'on'],
    resposta: 0,
    explicacao:
        '`finally` executa em qualquer cenário — ideal para esconder loading '
        'ou fechar conexões.',
  ),
  ExercicioCompletar(
    id: 'e8-5',
    licaoId: 'assincronia',
    enunciado: 'Complete a função que devolve uma Stream:',
    codigoComLacuna: '''Stream<int> contar() async* {
  for (var i = 0; i < 3; i++) {
    ___ i;
  }
}''',
    opcoes: ['yield', 'return', 'await', 'emit'],
    resposta: 0,
    explicacao:
        'Em uma função `async*`, `yield` solta mais um valor na Stream sem '
        'encerrar a função. `return` encerraria de vez.',
  ),

  ExercicioMultiplaEscolha(
    id: 'e9-1',
    licaoId: 'dart-3',
    enunciado: 'O que este código imprime?',
    codigo: '''(String, int) dados() => ('Ana', 30);

void main() {
  final (nome, idade) = dados();
  print('\$nome-\$idade');
}''',
    opcoes: ['Ana-30', '(Ana, 30)', 'nome-idade', 'Erro'],
    resposta: 0,
    explicacao:
        'Isso é desestruturação de um record: `nome` recebe o primeiro campo '
        'e `idade` o segundo, cada um já com o tipo correto.',
  ),
  ExercicioCertoOuErrado(
    id: 'e9-2',
    licaoId: 'dart-3',
    codigo: '''sealed class Estado {}
final class Ok extends Estado {}
final class Falhou extends Estado {}

String txt(Estado e) => switch (e) {
      Ok() => 'ok',
    };''',
    estaCorreto: false,
    explicacao:
        'O switch não está exaustivo: falta o caso `Falhou()`. Como a classe é '
        '`sealed`, o compilador conhece todos os filhos e cobra você por isso — '
        'exatamente o comportamento que queremos.',
  ),
  ExercicioCompletar(
    id: 'e9-3',
    licaoId: 'dart-3',
    enunciado: 'Complete para extrair o campo dentro do pattern:',
    codigoComLacuna: '''String txt(Estado e) => switch (e) {
      Ok() => 'ok',
      Falhou(___ msg) => 'erro: \$msg',
    };''',
    opcoes: [':final', 'final', 'var', 'this.'],
    resposta: 0,
    explicacao:
        '`Falhou(:final msg)` é o atalho que extrai o campo `msg` do objeto '
        'para uma variável de mesmo nome.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e9-4',
    licaoId: 'dart-3',
    enunciado: 'Quando preferir `sealed class` em vez de `enum`?',
    opcoes: [
      'Quando cada caso carrega dados diferentes',
      'Sempre, enum está obsoleto',
      'Quando há mais de 5 casos',
      'Quando os casos são só rótulos de texto',
    ],
    resposta: 0,
    explicacao:
        'Enum é ideal para rótulos fixos sem dados próprios. Sealed brilha '
        'quando cada caso tem campos distintos — como Carregado(itens) e '
        'Erro(mensagem).',
  ),

  ExercicioMultiplaEscolha(
    id: 'e10-1',
    licaoId: 'clean-architecture',
    enunciado: 'Qual import NÃO deveria existir na camada domain?',
    opcoes: [
      "import 'package:flutter/cupertino.dart';",
      "import '../entities/licao.dart';",
      "import '../../../core/utils/resultado.dart';",
      "import 'dart:async';",
    ],
    resposta: 0,
    explicacao:
        'O domain é Dart puro: nada de Flutter. Se ele conhecesse widgets, a '
        'regra de negócio ficaria presa à interface e difícil de testar.',
  ),
  ExercicioMultiplaEscolha(
    id: 'e10-2',
    licaoId: 'clean-architecture',
    enunciado: 'Onde fica a decisão "os dados vêm da memória ou de uma API"?',
    opcoes: [
      'No datasource, dentro da camada data',
      'No caso de uso',
      'Na página (presentation)',
      'Na entidade',
    ],
    resposta: 0,
    explicacao:
        'O datasource é a única peça que sabe a origem real. Por isso trocar '
        'memória por API não afeta nenhuma outra camada.',
  ),
  ExercicioCertoOuErrado(
    id: 'e10-3',
    licaoId: 'clean-architecture',
    codigo: '''// domain/usecases/listar_licoes.dart
class ListarLicoes {
  const ListarLicoes(this._repo);
  final LicaoRepositorioImpl _repo; // implementação concreta
}''',
    estaCorreto: false,
    explicacao:
        'O caso de uso deve depender da ABSTRAÇÃO (`LicaoRepositorio`), não da '
        'implementação. Assim o domain não conhece a camada data — e nos testes '
        'você injeta um repositório falso.',
  ),
  ExercicioCompletar(
    id: 'e10-4',
    licaoId: 'clean-architecture',
    enunciado: 'Complete a declaração do contrato do repositório:',
    codigoComLacuna: '''___ LicaoRepositorio {
  Future<Resultado<List<Licao>>> listarTodas();
}''',
    opcoes: [
      'abstract interface class',
      'final class',
      'sealed class',
      'mixin',
    ],
    resposta: 0,
    explicacao:
        '`abstract interface class` (Dart 3) declara algo feito só para ser '
        'implementado: não pode virar objeto nem ser herdado, apenas '
        '`implements`.',
  ),
];
