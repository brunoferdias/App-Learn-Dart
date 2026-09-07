import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao08Async = Licao(
  id: 'assincronia',
  titulo: 'Future, async e await',
  resumo: 'Como esperar a internet sem travar a tela — e tratar erros.',
  nivel: NivelLicao.intermediario,
  minutos: 13,
  objetivos: [
    'Entender o que é um Future',
    'Usar async/await no lugar de callbacks',
    'Tratar erros com try/catch/finally',
    'Conhecer Stream para valores que chegam aos poucos',
  ],
  blocos: [
    BlocoTexto(
      'Buscar dados na internet demora. Se o app ficasse **parado** esperando, '
      'a tela congelaria. A solução do Dart é o `Future`: uma **promessa de '
      'valor futuro**.',
    ),
    BlocoTitulo('Future: o valor que ainda não chegou'),
    BlocoCodigo(
      r'''
// Future<String> = "um dia isto vira uma String"
Future<String> buscarNome() async {
  await Future.delayed(Duration(seconds: 2)); // simula a internet
  return 'Ana';
}

void main() async {
  print('Buscando...');
  final nome = await buscarNome(); // espera SEM travar a tela
  print('Chegou: $nome');
}
''',
      saida: 'Buscando...\n(2 segundos depois)\nChegou: Ana',
      legenda: 'async marca a função; await espera dentro dela.',
    ),
    BlocoTabela(
      cabecalho: ('Palavra', 'Significado'),
      linhas: [
        ('Future<T>', 'Promessa de um valor T que chega depois'),
        ('async', 'Marca a função como assíncrona (ela devolve um Future)'),
        ('await', 'Pausa AQUI até o Future terminar. Só dentro de async.'),
        ('Future<void>', 'Termina depois, mas não devolve valor'),
        ('Stream<T>', 'Vários valores ao longo do tempo (um "cano")'),
      ],
    ),
    BlocoComparacao(
      codigoErrado: r'''
void main() {
  final nome = await buscarNome();
}
// ❌ "await can only be used in async"''',
      notaErrado: 'Faltou marcar a função com `async`.',
      codigoCerto: r'''
void main() async {
  final nome = await buscarNome();
}''',
      notaCerto: 'Toda função que usa `await` precisa ser `async`.',
    ),
    BlocoAviso(
      'Se você esquecer o `await`, a variável recebe o **Future** em vez do '
      'valor: `Instance of Future<String>`. É o bug assíncrono nº 1.',
    ),
    BlocoTitulo('Tratando erros'),
    BlocoCodigo(
      r'''
Future<void> carregar() async {
  try {
    final dados = await buscarDaApi();
    print(dados);
  } on FormatException catch (e) {
    print('Resposta em formato inválido: $e'); // erro específico
  } catch (e, pilha) {
    print('Erro inesperado: $e');              // qualquer outro
    print(pilha);                              // onde aconteceu
  } finally {
    print('Sempre roda, dando certo ou errado');
  }
}
''',
      legenda:
          '`on Tipo` captura um erro específico; `catch (e)` captura tudo.',
    ),
    BlocoCodigo(
      r'''
// Criando sua própria exceção — vira documentação do que pode dar errado.
class SemConexao implements Exception {
  const SemConexao(this.mensagem);
  final String mensagem;

  @override
  String toString() => 'SemConexao: $mensagem';
}

void verificar(bool online) {
  if (!online) throw const SemConexao('Você está offline');
}
''',
      legenda:
          'Neste app usamos outra abordagem: erro como VALOR (`Resultado`).',
    ),
    BlocoTitulo('Vários Futures ao mesmo tempo'),
    BlocoCodigo(r'''
// ❌ Um depois do outro: 2s + 2s = 4 segundos
final a = await buscarA();
final b = await buscarB();

// ✅ Juntos: 2 segundos no total
final resultados = await Future.wait([buscarA(), buscarB()]);
''', legenda: '`Future.wait` dispara tudo em paralelo e espera o conjunto.'),
    BlocoTitulo('Stream: muitos valores ao longo do tempo'),
    BlocoTexto(
      'Se `Future` é **uma** entrega, `Stream` é uma **esteira**: valores '
      'chegando continuamente — digitação, GPS, mensagens de chat.',
    ),
    BlocoCodigo(
      r'''
// async* + yield = função que produz uma Stream
Stream<int> contagemRegressiva(int de) async* {
  for (var i = de; i >= 0; i--) {
    await Future.delayed(Duration(seconds: 1));
    yield i;              // "solta" mais um valor na esteira
  }
}

void main() async {
  await for (final n in contagemRegressiva(3)) {
    print(n);             // 3, 2, 1, 0 — um por segundo
  }
  print('Fim!');
}
''',
      saida: '3\n2\n1\n0\nFim!',
      legenda: '`await for` percorre uma Stream como o for-in faz com listas.',
    ),
    BlocoDica(
      'No Flutter você raramente escreve `await` no `build`. Use `FutureBuilder` '
      'ou `StreamBuilder`, que já reconstroem a tela quando o dado chega.',
    ),
  ],
);
