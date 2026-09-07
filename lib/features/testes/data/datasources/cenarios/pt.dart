import '../../../domain/entities/cenario.dart';
import '../../../domain/entities/finder_simulado.dart';
import '../../../domain/entities/matcher_simulado.dart';
import '../../../domain/entities/no_widget.dart';

const List<Cenario> cenariosPt = [
  Cenario(
    id: 'etiqueta',
    titulo: 'Uma etiqueta na tela',
    resumo: 'Comece pelo básico: o finder acha, ou não acha.',
    codigoFonte: '''await tester.pumpWidget(
montar(
  const Etiqueta(
    'Iniciante',
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
                NoWidget('Text', texto: 'Iniciante'),
              ],
            ),
          ],
        ),
      ],
    ),
    finders: [
      FinderTexto('Iniciante'),
      FinderTexto('Avançado'),
      FinderTipo('Etiqueta'),
      FinderTipo('Text'),
      FinderIcone('star_fill'),
    ],
    desafio: Desafio(
      enunciado: 'Prove que a etiqueta "Avançado" NÃO está nesta tela.',
      finder: FinderTexto('Avançado'),
      matcher: EncontraNada(),
      dica:
          'Não achar nada também é um teste — e dos mais úteis. '
          'O matcher para isso é findsNothing.',
    ),
  ),

  Cenario(
    id: 'alternativas',
    titulo: 'Três alternativas',
    resumo: 'byType conta widgets do mesmo tipo. Quantos existem aqui?',
    codigoFonte: '''Column(
children: [
  const Text('Qual é o tipo de precos[pizza]?'),
  for (final (letra, texto) in opcoes)
    OpcaoResposta(
      letra: letra,
      texto: texto,
      estado: EstadoOpcao.neutra,
      aoTocar: () {},
    ),
],
)''',
    arvore: NoWidget(
      'Column',
      filhos: [
        NoWidget('Text', texto: 'Qual é o tipo de precos[pizza]?'),
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
      enunciado: 'Prove que a pergunta oferece exatamente 3 alternativas.',
      finder: FinderTipo('OpcaoResposta'),
      matcher: EncontraN(3),
      dica:
          'findsNWidgets(n) exige o número EXATO. Repare que '
          'find.byType(Text) acharia bem mais — cada alternativa tem dois.',
    ),
  ),

  Cenario(
    id: 'toque',
    titulo: 'Depois do toque',
    resumo: 'A árvore só muda depois da interação (e do pump).',
    codigoFonte: '''await tester.tap(find.byType(OpcaoResposta));
await tester.pumpAndSettle();

// Só agora o parabéns existe na árvore.
expect(find.text('Boa! String? aceita null.'), findsOneWidget);''',
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
                NoWidget('Text', texto: 'String? aceita null'),
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
                NoWidget('Text', texto: 'String? aceita null'),
                NoWidget('Icon', icone: 'checkmark_circle_fill'),
              ],
            ),
          ],
        ),
        NoWidget('Text', texto: 'Boa! String? aceita null.'),
      ],
    ),
    finders: [
      FinderTexto('Boa! String? aceita null.'),
      FinderIcone('checkmark_circle_fill'),
      FinderTipo('OpcaoResposta'),
      FinderTipo('Text'),
    ],
    desafio: Desafio(
      enunciado: 'Toque na alternativa e prove que o parabéns apareceu.',
      finder: FinderTexto('Boa! String? aceita null.'),
      matcher: EncontraUm(),
      exigeInteracao: true,
      dica:
          'Antes do toque esse texto nem existe na árvore. '
          'Use o botão de tocar e rode de novo.',
    ),
  ),

  Cenario(
    id: 'chaves',
    titulo: 'Dois textos iguais',
    resumo: 'find.text acha os dois. Como alcançar só um deles?',
    codigoFonte: '''Column(
children: const [
  Etiqueta('Nível', key: Key('etiqueta-nivel'), cor: CoresApp.erro),
  Etiqueta('Nível', key: Key('etiqueta-tema'), cor: CoresApp.dica),
],
)''',
    arvore: NoWidget(
      'Column',
      filhos: [
        NoWidget(
          'Etiqueta',
          chave: 'etiqueta-nivel',
          filhos: [
            NoWidget('Row', filhos: [NoWidget('Text', texto: 'Nível')]),
          ],
        ),
        NoWidget(
          'Etiqueta',
          chave: 'etiqueta-tema',
          filhos: [
            NoWidget('Row', filhos: [NoWidget('Text', texto: 'Nível')]),
          ],
        ),
      ],
    ),
    finders: [
      FinderTexto('Nível'),
      FinderTipo('Etiqueta'),
      FinderChave('etiqueta-tema'),
      FinderChave('etiqueta-nivel'),
    ],
    desafio: Desafio(
      enunciado: 'Alcance SÓ a segunda etiqueta, a do tema.',
      finder: FinderChave('etiqueta-tema'),
      matcher: EncontraUm(),
      dica:
          'É exatamente para isso que a Key existe: desempatar widgets '
          'que o usuário vê iguais.',
    ),
  ),
];
