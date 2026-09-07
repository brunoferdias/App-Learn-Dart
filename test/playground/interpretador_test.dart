import 'package:aprenda_dart/features/playground/data/datasources/exemplos_locais_datasource.dart';
import 'package:aprenda_dart/features/playground/data/repositories/playground_repositorio_impl.dart';
import 'package:aprenda_dart/features/playground/domain/entities/arquivo_dart.dart';
import 'package:aprenda_dart/features/playground/domain/entities/resultado_execucao.dart';
import 'package:flutter_test/flutter_test.dart';

import '../ajuda.dart';

void main() {
  const repo = PlaygroundRepositorioImpl(ExemplosEmMemoria());

  ResultadoExecucao rodarArquivos(List<ArquivoDart> arquivos) =>
      repo.executar(arquivos, textosTeste);

  List<String> rodar(String codigo) {
    final r = rodarArquivos([
      ArquivoDart(id: 'main', nome: 'main.dart', conteudo: codigo),
    ]);
    expect(r.erro?.mensagem, isNull, reason: 'não era para dar erro');
    return r.saida;
  }

  String erroDe(String codigo) {
    final r = rodarArquivos([
      ArquivoDart(id: 'main', nome: 'main.dart', conteudo: codigo),
    ]);
    expect(r.erro, isNotNull, reason: 'era para dar erro');
    return r.erro!.mensagem;
  }

  group('básico', () {
    test('hello world', () {
      expect(rodar("void main() { print('Olá, Dart!'); }"), ['Olá, Dart!']);
    });

    test('aritmética respeita precedência', () {
      expect(rodar('void main() { print(1 + 2 * 3); }'), ['7']);
      expect(rodar('void main() { print((1 + 2) * 3); }'), ['9']);
    });

    test('int e double imprimem como no Dart', () {
      expect(rodar('void main() { print(4); print(4.0); print(10 / 4); }'), [
        '4',
        '4.0',
        '2.5',
      ]);
    });

    test('interpolação simples e com expressão', () {
      expect(
        rodar(r"void main() { final n = 'Ana'; print('Oi $n, ${n.length}'); }"),
        ['Oi Ana, 3'],
      );
    });

    test('operadores de comparação e lógicos', () {
      expect(rodar('void main() { print(3 > 2 && 1 < 2); print(!true); }'), [
        'true',
        'false',
      ]);
    });
  });

  group('null safety', () {
    test('?. devolve null em vez de quebrar', () {
      expect(rodar('void main() { String? a; print(a?.length); }'), ['null']);
    });

    test('?? fornece valor padrão', () {
      expect(rodar("void main() { String? a; print(a ?? 'padrão'); }"), [
        'padrão',
      ]);
    });

    test('??= só atribui quando está null', () {
      expect(
        rodar("void main() { String? a; a ??= 'x'; a ??= 'y'; print(a); }"),
        ['x'],
      );
    });

    test('! em null gera o erro clássico', () {
      expect(
        erroDe('void main() { String? a; print(a!.length); }'),
        contains('Null check operator'),
      );
    });

    test('String não aceita null', () {
      expect(
        erroDe('void main() { String nome = null; print(nome); }'),
        contains('null'),
      );
    });

    test('String? aceita null', () {
      expect(rodar('void main() { String? nome = null; print(nome); }'), [
        'null',
      ]);
    });

    test('acessar membro de null explica o problema', () {
      expect(
        erroDe('void main() { String? a; print(a.length); }'),
        contains('nulo'),
      );
    });

    test('chave inexistente de mapa devolve null', () {
      expect(rodar("void main() { final m = {'a': 1}; print(m['z']); }"), [
        'null',
      ]);
    });
  });

  group('funções', () {
    test('parâmetros nomeados com required e padrão', () {
      expect(
        rodar('''
void main() { f(a: 1); f(a: 1, b: 9); }
void f({required int a, int b = 5}) { print(a + b); }
'''),
        ['6', '10'],
      );
    });

    test('faltando um required, o erro é claro', () {
      expect(
        erroDe('void main() { f(); }\nvoid f({required int a}) {}'),
        contains('obrigatório'),
      );
    });

    test('posicionais opcionais', () {
      expect(
        rodar('''
void main() { print(g('Ana')); print(g('Ana', 'Dra.')); }
String g(String n, [String? t]) => t == null ? n : '\$t \$n';
'''),
        ['Ana', 'Dra. Ana'],
      );
    });

    test('closure guarda o estado', () {
      expect(
        rodar('''
void main() {
  final c = contador();
  c(); c();
  print(c());
}
Function contador() {
  var n = 0;
  return () { n++; return n; };
}
'''),
        ['3'],
      );
    });

    test('recursão', () {
      expect(
        rodar('''
void main() { print(fat(5)); }
int fat(int n) => n <= 1 ? 1 : n * fat(n - 1);
'''),
        ['120'],
      );
    });
  });

  group('controle de fluxo', () {
    test('for, break e continue', () {
      expect(
        rodar('''
void main() {
  for (final n in [1, 2, 3, 4, 5]) {
    if (n == 2) continue;
    if (n == 4) break;
    print(n);
  }
}
'''),
        ['1', '3'],
      );
    });

    test('while', () {
      expect(
        rodar('void main() { var i = 0; while (i < 3) { print(i); i++; } }'),
        ['0', '1', '2'],
      );
    });

    test('switch com vários case', () {
      expect(
        rodar('''
void main() {
  final d = 'sabado';
  switch (d) {
    case 'sabado':
    case 'domingo':
      print('Fim de semana');
      break;
    default:
      print('Dia útil');
  }
}
'''),
        ['Fim de semana'],
      );
    });

    test('condição não-bool é recusada, como no Dart real', () {
      expect(
        erroDe("void main() { if ('texto') { print('x'); } }"),
        contains('true ou false'),
      );
    });

    test('try/catch/finally', () {
      expect(
        rodar('''
void main() {
  try {
    throw Exception('falhou');
  } catch (e) {
    print('peguei: \$e');
  } finally {
    print('fim');
  }
}
'''),
        ['peguei: Exception: falhou', 'fim'],
      );
    });
  });

  group('coleções', () {
    test('map, where e fold', () {
      expect(
        rodar('''
void main() {
  final n = [1, 2, 3, 4];
  print(n.where((x) => x % 2 == 0).toList());
  print(n.map((x) => x * 10).toList());
  print(n.fold(0, (t, x) => t + x));
}
'''),
        ['[2, 4]', '[10, 20, 30, 40]', '10'],
      );
    });

    test('collection if, for e spread', () {
      expect(
        rodar('''
void main() {
  final base = [1, 2];
  print([...base, 3]);
  print(['a', if (false) 'b', if (true) 'c']);
  print([for (final x in base) x * 2]);
}
'''),
        ['[1, 2, 3]', '[a, c]', '[2, 4]'],
      );
    });

    test('índice fora do intervalo explica o RangeError', () {
      expect(
        erroDe('void main() { final l = [1, 2]; print(l[5]); }'),
        contains('RangeError'),
      );
    });

    test('mapa: entries, keys e values', () {
      expect(
        rodar('''
void main() {
  final m = {'a': 1, 'b': 2};
  print(m.keys);
  print(m.values);
  for (final e in m.entries) { print('\${e.key}=\${e.value}'); }
}
'''),
        ['[a, b]', '[1, 2]', 'a=1', 'b=2'],
      );
    });
  });

  group('classes', () {
    test('construtor, método e getter', () {
      expect(
        rodar('''
void main() {
  final p = Pessoa('Ana', 30);
  p.apresentar();
  print(p.adulto);
}
class Pessoa {
  Pessoa(this.nome, this.idade);
  final String nome;
  final int idade;
  bool get adulto => idade >= 18;
  void apresentar() { print('\$nome, \$idade'); }
}
'''),
        ['Ana, 30', 'true'],
      );
    });

    test('toString personalizado é usado pelo print', () {
      expect(
        rodar('''
void main() { print(Ponto(1, 2)); }
class Ponto {
  Ponto(this.x, this.y);
  final int x;
  final int y;
  String toString() => 'Ponto(\$x, \$y)';
}
'''),
        ['Ponto(1, 2)'],
      );
    });
  });

  group('erros de sintaxe', () {
    test('ponto e vírgula faltando', () {
      expect(erroDe("void main() { print('a') }"), contains(';'));
    });

    test('chave não fechada', () {
      expect(erroDe("void main() { print('a');"), isNotEmpty);
    });

    test('aspas não fechadas', () {
      expect(erroDe("void main() { print('a); }"), contains('não foi fechado'));
    });

    test('sem main', () {
      expect(erroDe('int x = 1;'), contains('main'));
    });

    test('variável não declarada', () {
      expect(
        erroDe('void main() { print(inexistente); }'),
        contains('não foi definida'),
      );
    });

    test('reatribuir final é recusado', () {
      expect(
        erroDe("void main() { final a = 1; a = 2; print(a); }"),
        contains('final'),
      );
    });
  });

  group('segurança', () {
    test('laço infinito vira erro em vez de travar o app', () {
      final msg = erroDe('void main() { while (true) { var x = 1; } }');
      expect(msg, contains('tempo demais'));
    });

    test('excesso de prints é interrompido', () {
      final msg = erroDe(
        'void main() { for (var i = 0; i < 99999; i++) '
        '{ print(i); } }',
      );
      expect(msg, contains('linhas'));
    });
  });

  group('múltiplos arquivos', () {
    test('as abas compartilham o escopo global', () {
      final r = rodarArquivos(const [
        ArquivoDart(
          id: 'a',
          nome: 'main.dart',
          conteudo: "void main() { print(saudar('Ana')); }",
        ),
        ArquivoDart(
          id: 'b',
          nome: 'util.dart',
          conteudo: "String saudar(String n) => 'Oi, \$n';",
        ),
      ]);
      expect(r.erro, isNull);
      expect(r.saida, ['Oi, Ana']);
    });

    test('o erro aponta o arquivo certo', () {
      final r = rodarArquivos(const [
        ArquivoDart(
          id: 'a',
          nome: 'main.dart',
          conteudo: 'void main() { f(); }',
        ),
        ArquivoDart(
          id: 'b',
          nome: 'util.dart',
          conteudo: "void f() { print('a') }",
        ),
      ]);
      expect(r.erro!.arquivo, 'util.dart');
    });

    test('import de aba inexistente é apontado', () {
      final r = rodarArquivos(const [
        ArquivoDart(
          id: 'a',
          nome: 'main.dart',
          conteudo: "import 'nao_existe.dart';\nvoid main() {}",
        ),
      ]);
      expect(r.erro!.mensagem, contains('nao_existe.dart'));
    });
  });

  group('exemplos prontos rodam sem erro', () {
    for (final exemplo in const ExemplosEmMemoria().exemplos(
      textosTeste.idioma,
    )) {
      test(exemplo.titulo, () {
        final r = rodarArquivos(exemplo.arquivos);
        if (exemplo.titulo == 'Erros de propósito') {
          expect(r.erro, isNotNull);
        } else {
          expect(r.erro?.mensagem, isNull);
        }
      });
    }

    test('os arquivos iniciais rodam', () {
      final r = rodarArquivos(
        const ExemplosEmMemoria().iniciais(textosTeste.idioma),
      );
      expect(r.erro?.mensagem, isNull);
      expect(r.saida.first, contains('Olá, Ana'));
    });
  });
}
