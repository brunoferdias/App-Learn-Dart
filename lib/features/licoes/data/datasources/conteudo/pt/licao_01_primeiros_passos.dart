import '../../../../domain/entities/bloco_conteudo.dart';
import '../../../../domain/entities/licao.dart';

const licao01PrimeirosPassos = Licao(
  id: 'primeiros-passos',
  titulo: 'Como o Dart funciona',
  resumo: 'O ponto de entrada, a sintaxe básica e como o código vira app.',
  nivel: NivelLicao.iniciante,
  minutos: 6,
  objetivos: [
    'Entender o que a função main() faz',
    'Ler a sintaxe básica sem se perder',
    'Saber quando usar ponto e vírgula, chaves e comentários',
  ],
  blocos: [
    BlocoTexto(
      'Dart é a linguagem que move o **Flutter**. Ela é **compilada** '
      '(vira código nativo antes de rodar) e **tipada estaticamente** — o que '
      'significa que muitos erros aparecem enquanto você digita, e não com o '
      'app na mão do usuário.',
    ),
    BlocoTexto(
      'Em Dart, **tudo é objeto**. Até o número `7` é um objeto da classe '
      '`int`, e até uma função pode ser guardada dentro de uma variável.',
    ),
    BlocoTitulo('O programa mais simples possível'),
    BlocoCodigo(
      r'''
// Todo programa Dart começa pela função main().
// É ela que o sistema procura para dar o "start".
void main() {
  print('Olá, Dart!');
}
''',
      legenda: 'O clássico "Olá, mundo" em Dart.',
      saida: 'Olá, Dart!',
    ),
    BlocoTexto('Vamos destrinchar essa função linha por linha:'),
    BlocoTabela(
      cabecalho: ('Trecho', 'O que significa'),
      linhas: [
        ('void', 'Tipo de retorno. `void` = "não devolve nada".'),
        (
          'main',
          'Nome da função. Este nome é obrigatório no ponto de entrada.',
        ),
        ('()', 'Lista de parâmetros. Vazia = a função não recebe nada.'),
        ('{ }', 'Corpo da função: tudo que ela executa fica aqui dentro.'),
        ('print(...)', 'Função pronta do Dart que escreve no console.'),
        (';', 'Fim do comando. Em Dart o ponto e vírgula é obrigatório.'),
      ],
    ),
    BlocoTitulo('Comentários'),
    BlocoCodigo(r'''
// Comentário de uma linha.

/*
  Comentário de várias linhas.
  Útil para desativar um trecho temporariamente.
*/

/// Comentário de DOCUMENTAÇÃO (três barras).
/// Vira a "ajudinha" que aparece quando alguém passa o mouse
/// sobre a função na IDE. Use nas suas funções públicas!
void somar() {}
''', legenda: 'Três estilos — e o de três barras é especial.'),
    BlocoDica(
      'Escreva `main` e aperte Tab na sua IDE: ela completa a função inteira '
      'para você. Atalhos assim economizam horas.',
    ),
    BlocoTitulo('Erros que todo mundo comete no primeiro dia'),
    BlocoComparacao(
      codigoErrado: r'''
void Main() {
  print('Olá')
}''',
      notaErrado:
          'Dois problemas: `Main` com M maiúsculo (Dart diferencia maiúsculas '
          'de minúsculas, então esta NÃO é a função de entrada) e falta o `;`.',
      codigoCerto: r'''
void main() {
  print('Olá');
}''',
      notaCerto: 'Nome exatamente `main`, e todo comando terminado com `;`.',
    ),
    BlocoTitulo('Como seu código vira um app'),
    BlocoLista([
      'Durante o desenvolvimento o Dart usa **JIT** — compila na hora, o que '
          'permite o Hot Reload (você salva e a tela muda em 1 segundo).',
      'Ao publicar, ele usa **AOT** — compila tudo antes, gerando código '
          'nativo rápido para Android, iOS, web e desktop.',
      'O mesmo arquivo `.dart` que você escreve aqui roda nas duas situações.',
    ]),
    BlocoAviso(
      'Se você vem do JavaScript: em Dart o `;` **não** é opcional, e não '
      'existe `==` "esquisito" — comparação é sempre segura por tipo.',
    ),
  ],
);
