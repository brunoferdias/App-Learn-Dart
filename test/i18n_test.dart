import 'package:aprenda_dart/core/i18n/idioma.dart';
import 'package:aprenda_dart/core/i18n/textos.dart';
import 'package:aprenda_dart/features/exercicios/data/datasources/exercicios_locais_datasource.dart';
import 'package:aprenda_dart/features/exercicios/domain/entities/exercicio.dart';
import 'package:aprenda_dart/features/glossario/data/datasources/glossario_local_datasource.dart';
import 'package:aprenda_dart/features/licoes/data/datasources/licoes_locais_datasource.dart';
import 'package:aprenda_dart/features/licoes/domain/entities/bloco_conteudo.dart';
import 'package:aprenda_dart/features/licoes/domain/entities/licao.dart';
import 'package:aprenda_dart/features/playground/data/datasources/exemplos_locais_datasource.dart';
import 'package:aprenda_dart/features/playground/data/repositories/playground_repositorio_impl.dart';
import 'package:aprenda_dart/features/playground/domain/entities/arquivo_dart.dart';
import 'package:aprenda_dart/features/testes/data/datasources/cenarios_locais_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

List<String> _textosDaLicao(Licao l) => [
  l.titulo,
  l.resumo,
  ...l.objetivos,
  for (final b in l.blocos)
    ...switch (b) {
      BlocoTexto(:final texto) => [texto],
      BlocoTitulo(:final texto) => [texto],
      BlocoDica(:final texto) => [texto],
      BlocoAviso(:final texto) => [texto],
      BlocoLista(:final itens) => itens,
      BlocoCodigo(:final legenda, :final saida) => [?legenda, ?saida],
      BlocoComparacao(:final notaErrado, :final notaCerto) => [
        notaErrado,
        notaCerto,
      ],
      BlocoTabela(:final cabecalho, :final linhas) => [
        cabecalho.$1,
        cabecalho.$2,
        for (final (a, b) in linhas) ...[a, b],
      ],
      BlocoLaboratorio(:final titulo, :final chamada) => [titulo, chamada],
    },
];

final RegExp _cheiroDePortugues = RegExp(
  r'\b(você|não|também|então|porque|para|uma|isso|quando|onde|precisa|'
  r'código|função|variável|lição|exercício|texto|apenas|dentro|cada|'
  r'mesmo|sempre|nunca)\b',
  caseSensitive: false,
);

void main() {
  const licoes = LicoesEmMemoria();
  const exercicios = ExerciciosEmMemoria();
  const glossario = GlossarioEmMemoria();
  const cenarios = CenariosEmMemoria();
  const exemplos = ExemplosEmMemoria();

  group('o contrato de Textos cobre os dois idiomas', () {
    test('a fábrica devolve a tradução certa para cada idioma', () {
      expect(Textos.de(Idioma.portugues).idioma, Idioma.portugues);
      expect(Textos.de(Idioma.ingles).idioma, Idioma.ingles);
    });

    test('as frases realmente mudam de um idioma para o outro', () {
      final pt = Textos.de(Idioma.portugues);
      final en = Textos.de(Idioma.ingles);

      expect(pt.abaAprender, isNot(en.abaAprender));
      expect(pt.licaoObjetivos, isNot(en.licaoObjetivos));
      expect(pt.praticarTudo, isNot(en.praticarTudo));
      expect(pt.quizEscolhaAlternativa, isNot(en.quizEscolhaAlternativa));
      expect(pt.editorChamadaTitulo, isNot(en.editorChamadaTitulo));
      expect(pt.labAsercaoTitulo, isNot(en.labAsercaoTitulo));
      expect(pt.perfilTitulo, isNot(en.perfilTitulo));
      expect(pt.avisoNaoOficialCompleto, isNot(en.avisoNaoOficialCompleto));
    });

    test('o aviso de não-afiliação cita o Google nos dois idiomas', () {
      for (final idioma in Idioma.values) {
        final t = Textos.de(idioma);
        expect(t.avisoNaoOficialCompleto, contains('Google'));
        expect(t.avisoNaoOficialCurto, contains('Google'));
      }
    });

    test('o nome de cada idioma vem escrito no próprio idioma', () {
      expect(Idioma.portugues.nome, 'Português');
      expect(Idioma.ingles.nome, 'English');
    });
  });

  group('as lições estão em sincronia', () {
    test('mesma quantidade e mesmos ids, na mesma ordem', () async {
      final pt = await licoes.buscarTodas(Idioma.portugues);
      final en = await licoes.buscarTodas(Idioma.ingles);

      expect(en.length, pt.length);
      expect(
        en.map((l) => l.id).toList(),
        pt.map((l) => l.id).toList(),
        reason: 'os ids amarram o progresso do usuário aos dois idiomas',
      );
    });

    test('nível e número de exemplos batem em cada lição', () async {
      final pt = await licoes.buscarTodas(Idioma.portugues);
      final en = await licoes.buscarTodas(Idioma.ingles);

      for (final (i, licao) in pt.indexed) {
        expect(en[i].nivel, licao.nivel, reason: 'nível de ${licao.id}');
        expect(
          en[i].quantidadeDeExemplos,
          licao.quantidadeDeExemplos,
          reason: 'exemplos de ${licao.id}',
        );
        expect(en[i].objetivos.length, licao.objetivos.length);
        expect(en[i].blocos.length, licao.blocos.length);
      }
    });

    test('o conteúdo em inglês não tem sobras de português', () async {
      final en = await licoes.buscarTodas(Idioma.ingles);

      for (final licao in en) {
        for (final texto in _textosDaLicao(licao)) {
          expect(
            _cheiroDePortugues.hasMatch(texto),
            isFalse,
            reason: 'lição "${licao.id}" tem português: "$texto"',
          );
        }
      }
    });
  });

  group('os exercícios estão em sincronia', () {
    test('mesma quantidade, mesmos ids e mesma resposta certa', () async {
      final pt = await exercicios.buscarTodos(Idioma.portugues);
      final en = await exercicios.buscarTodos(Idioma.ingles);

      expect(en.length, pt.length);
      for (final (i, exercicio) in pt.indexed) {
        expect(en[i].id, exercicio.id);
        expect(en[i].licaoId, exercicio.licaoId);
        expect(
          en[i].indiceCorreto,
          exercicio.indiceCorreto,
          reason: 'a resposta certa de ${exercicio.id} mudou de idioma',
        );
        expect(en[i].runtimeType, exercicio.runtimeType);
      }
    });

    test('todo exercício aponta para uma lição que existe', () async {
      final todasAsLicoes = await licoes.buscarTodas(Idioma.portugues);
      final ids = todasAsLicoes.map((l) => l.id).toSet();

      for (final idioma in Idioma.values) {
        for (final e in await exercicios.buscarTodos(idioma)) {
          expect(ids, contains(e.licaoId), reason: 'exercício ${e.id}');
        }
      }
    });

    test('a explicação em inglês não tem sobras de português', () async {
      for (final e in await exercicios.buscarTodos(Idioma.ingles)) {
        expect(
          _cheiroDePortugues.hasMatch(e.explicacao),
          isFalse,
          reason: 'exercício ${e.id}: "${e.explicacao}"',
        );
      }
    });

    test('as opções de múltipla escolha também foram traduzidas', () async {
      for (final e in await exercicios.buscarTodos(Idioma.ingles)) {
        if (e case ExercicioMultiplaEscolha(:final opcoes)) {
          for (final o in opcoes) {
            expect(
              _cheiroDePortugues.hasMatch(o),
              isFalse,
              reason: 'exercício ${e.id}, opção "$o"',
            );
          }
        }
      }
    });
  });

  group('glossário, cenários e exemplos', () {
    test('o glossário tem o mesmo tamanho nos dois idiomas', () async {
      final pt = await glossario.buscarTodos(Idioma.portugues);
      final en = await glossario.buscarTodos(Idioma.ingles);

      expect(en.length, pt.length);
      expect(
        en.map((i) => i.categoria).toList(),
        pt.map((i) => i.categoria).toList(),
      );
    });

    test('a explicação do glossário em inglês está traduzida', () async {
      for (final item in await glossario.buscarTodos(Idioma.ingles)) {
        expect(
          _cheiroDePortugues.hasMatch(item.significado),
          isFalse,
          reason: 'termo "${item.termo}": "${item.significado}"',
        );
      }
    });

    test('os cenários do laboratório têm os mesmos ids', () async {
      final pt = await cenarios.buscarTodos(Idioma.portugues);
      final en = await cenarios.buscarTodos(Idioma.ingles);

      expect(en.map((c) => c.id).toList(), pt.map((c) => c.id).toList());
      for (final (i, c) in pt.indexed) {
        expect(en[i].finders.length, c.finders.length);
        expect(en[i].temInteracao, c.temInteracao);
      }
    });

    test('os exemplos do editor existem nos dois idiomas', () {
      final pt = exemplos.exemplos(Idioma.portugues);
      final en = exemplos.exemplos(Idioma.ingles);

      expect(en.length, pt.length);
      expect(
        exemplos.iniciais(Idioma.ingles).length,
        exemplos.iniciais(Idioma.portugues).length,
      );
    });
  });

  group('o mini-interpretador também fala os dois idiomas', () {
    const repo = PlaygroundRepositorioImpl(ExemplosEmMemoria());

    ({String mensagem, String? dica}) erroEm(String codigo, Idioma idioma) {
      final r = repo.executar([
        ArquivoDart(id: 'main', nome: 'main.dart', conteudo: codigo),
      ], Textos.de(idioma));
      expect(r.erro, isNotNull, reason: 'era para dar erro');
      return (mensagem: r.erro!.mensagem, dica: r.erro!.dica);
    }

    test('erro de sintaxe sai no idioma escolhido', () {
      const codigo = "void main() { print('oi') }";

      expect(erroEm(codigo, Idioma.portugues).mensagem, contains('Esperava'));
      expect(erroEm(codigo, Idioma.ingles).mensagem, contains('Expected'));
    });

    test('erro de execução e a dica saem no idioma escolhido', () {
      const codigo = 'void main() { final l = [1, 2]; print(l[9]); }';

      final pt = erroEm(codigo, Idioma.portugues);
      final en = erroEm(codigo, Idioma.ingles);

      expect(pt.mensagem, contains('índice'));
      expect(en.mensagem, contains('invalid index'));
      expect(pt.dica, contains('Índices válidos'));
      expect(en.dica, contains('Valid indexes'));
    });

    test('a falta de main() é avisada nos dois idiomas', () {
      const codigo = "void f() { print('oi'); }";

      expect(erroEm(codigo, Idioma.portugues).mensagem, contains('main()'));
      expect(
        erroEm(codigo, Idioma.ingles).mensagem,
        allOf(contains('main()'), contains('find')),
      );
    });

    test('o mesmo código válido roda igual nos dois idiomas', () {
      const codigo = "void main() { print('42'); }";

      for (final idioma in Idioma.values) {
        final r = repo.executar(const [
          ArquivoDart(id: 'main', nome: 'main.dart', conteudo: codigo),
        ], Textos.de(idioma));
        expect(r.erro, isNull);
        expect(r.saida, ['42']);
      }
    });
  });

  group('o idioma vem do sistema no primeiro uso', () {
    test('locale pt-BR escolhe português', () {
      expect(Idioma.doSistema('pt'), Idioma.portugues);
      expect(Idioma.doSistema('pt_BR'), Idioma.portugues);
    });

    test('qualquer outro locale escolhe inglês', () {
      expect(Idioma.doSistema('en'), Idioma.ingles);
      expect(Idioma.doSistema('fr'), Idioma.ingles);
    });

    test('um código desconhecido no disco cai no padrão, sem quebrar', () {
      expect(Idioma.deCodigo('xx'), Idioma.portugues);
      expect(Idioma.deCodigo(null), Idioma.portugues);
      expect(Idioma.deCodigo('en'), Idioma.ingles);
    });
  });
}
