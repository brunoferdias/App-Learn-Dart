import '../../../domain/entities/cenario.dart';
import '../../../domain/entities/finder_simulado.dart';
import '../../../domain/entities/matcher_simulado.dart';
import '../../../domain/entities/no_widget.dart';

const List<Cenario> cenariosEn = [
  Cenario(
    id: 'etiqueta',
    titulo: 'One tag on the screen',
    resumo:
        'Start with the basics: the finder either finds it, or it does not.',
    codigoFonte: '''await tester.pumpWidget(
  montar(
    const Etiqueta(
      'Beginner',
      cor: CoresApp.acerto,
      icone: CupertinoIcons.star_fill,
    ),
  ),
);''',
    arvore: NoWidget(
      'Center',
      filhos: [
        NoWidget(
          'Etiqueta',
          filhos: [
            NoWidget(
              'Row',
              filhos: [
                NoWidget('Icon', icone: 'star_fill'),
                NoWidget('Text', texto: 'Beginner'),
              ],
            ),
          ],
        ),
      ],
    ),
    finders: [
      FinderTexto('Beginner'),
      FinderTexto('Advanced'),
      FinderTipo('Etiqueta'),
      FinderTipo('Text'),
      FinderIcone('star_fill'),
    ],
    desafio: Desafio(
      enunciado: 'Prove that the "Advanced" tag is NOT on this screen.',
      finder: FinderTexto('Advanced'),
      matcher: EncontraNada(),
      dica:
          'Finding nothing is a test too — and one of the most useful. '
          'The matcher for that is findsNothing.',
    ),
  ),

  Cenario(
    id: 'alternativas',
    titulo: 'Three answers',
    resumo: 'byType counts widgets of the same type. How many are there?',
    codigoFonte: '''Column(
  children: [
    const Text('What is the type of prices[pizza]?'),
    for (final (letter, text) in options)
      OpcaoResposta(
        letra: letter,
        texto: text,
        estado: EstadoOpcao.neutra,
        aoTocar: () {},
      ),
  ],
)''',
    arvore: NoWidget(
      'Column',
      filhos: [
        NoWidget('Text', texto: 'What is the type of prices[pizza]?'),
        NoWidget(
          'OpcaoResposta',
          filhos: [
            NoWidget(
              'Row',
              filhos: [
                NoWidget('Text', texto: 'A'),
                NoWidget('Text', texto: 'double?'),
              ],
            ),
          ],
        ),
        NoWidget(
          'OpcaoResposta',
          filhos: [
            NoWidget(
              'Row',
              filhos: [
                NoWidget('Text', texto: 'B'),
                NoWidget('Text', texto: 'double'),
              ],
            ),
          ],
        ),
        NoWidget(
          'OpcaoResposta',
          filhos: [
            NoWidget(
              'Row',
              filhos: [
                NoWidget('Text', texto: 'C'),
                NoWidget('Text', texto: 'null'),
              ],
            ),
          ],
        ),
      ],
    ),
    finders: [
      FinderTipo('OpcaoResposta'),
      FinderTipo('Text'),
      FinderTexto('double?'),
      FinderTexto('A'),
      FinderIcone('checkmark_circle_fill'),
    ],
    desafio: Desafio(
      enunciado: 'Prove that the question offers exactly 3 answers.',
      finder: FinderTipo('OpcaoResposta'),
      matcher: EncontraN(3),
      dica:
          'findsNWidgets(n) demands the EXACT number. Note that '
          'find.byType(Text) would find quite a few more — each answer has two.',
    ),
  ),

  Cenario(
    id: 'toque',
    titulo: 'After the tap',
    resumo: 'The tree only changes after the interaction (and the pump).',
    codigoFonte: '''await tester.tap(find.byType(OpcaoResposta));
await tester.pumpAndSettle();

// Only now does the congratulation exist in the tree.
expect(find.text('Nice. String? accepts null.'), findsOneWidget);''',
    acaoDeToque:
        'await tester.tap(find.byType(OpcaoResposta)); '
        'await tester.pumpAndSettle();',
    arvore: NoWidget(
      'Column',
      filhos: [
        NoWidget(
          'OpcaoResposta',
          filhos: [
            NoWidget(
              'Row',
              filhos: [
                NoWidget('Text', texto: 'A'),
                NoWidget('Text', texto: 'String? accepts null'),
              ],
            ),
          ],
        ),
      ],
    ),
    arvoreAposToque: NoWidget(
      'Column',
      filhos: [
        NoWidget(
          'OpcaoResposta',
          filhos: [
            NoWidget(
              'Row',
              filhos: [
                NoWidget('Text', texto: 'A'),
                NoWidget('Text', texto: 'String? accepts null'),
                NoWidget('Icon', icone: 'checkmark_circle_fill'),
              ],
            ),
          ],
        ),
        NoWidget('Text', texto: 'Nice. String? accepts null.'),
      ],
    ),
    finders: [
      FinderTexto('Nice. String? accepts null.'),
      FinderIcone('checkmark_circle_fill'),
      FinderTipo('OpcaoResposta'),
      FinderTipo('Text'),
    ],
    desafio: Desafio(
      enunciado: 'Tap the answer and prove the congratulation showed up.',
      finder: FinderTexto('Nice. String? accepts null.'),
      matcher: EncontraUm(),
      exigeInteracao: true,
      dica:
          'Before the tap that text does not even exist in the tree. '
          'Use the tap button and run it again.',
    ),
  ),

  Cenario(
    id: 'chaves',
    titulo: 'Two identical texts',
    resumo: 'find.text finds both. How do you reach just one of them?',
    codigoFonte: '''Column(
  children: const [
    Etiqueta('Level', key: Key('tag-level'), cor: CoresApp.erro),
    Etiqueta('Level', key: Key('tag-theme'), cor: CoresApp.dica),
  ],
)''',
    arvore: NoWidget(
      'Column',
      filhos: [
        NoWidget(
          'Etiqueta',
          chave: 'tag-level',
          filhos: [
            NoWidget('Row', filhos: [NoWidget('Text', texto: 'Level')]),
          ],
        ),
        NoWidget(
          'Etiqueta',
          chave: 'tag-theme',
          filhos: [
            NoWidget('Row', filhos: [NoWidget('Text', texto: 'Level')]),
          ],
        ),
      ],
    ),
    finders: [
      FinderTexto('Level'),
      FinderTipo('Etiqueta'),
      FinderChave('tag-theme'),
      FinderChave('tag-level'),
    ],
    desafio: Desafio(
      enunciado: 'Reach ONLY the second tag, the theme one.',
      finder: FinderChave('tag-theme'),
      matcher: EncontraUm(),
      dica:
          'This is exactly what a Key is for: breaking ties between widgets '
          'the user sees as identical.',
    ),
  ),
];
