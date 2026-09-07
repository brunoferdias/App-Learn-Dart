import 'erro_dart.dart';
import 'mensagens.dart';
import 'token.dart';
import 'valores.dart';

class ParChaveValor {
  const ParChaveValor(this.chave, this.valor);
  final Object? chave;
  final Object? valor;
}

class EstaticoDart {
  const EstaticoDart(this.nome);
  final String nome;

  @override
  String toString() => nome;
}

class ExcecaoDart {
  const ExcecaoDart(this.tipo, this.mensagem);
  final String tipo;
  final Object? mensagem;

  @override
  String toString() => mensagem == null ? tipo : '$tipo: $mensagem';
}

const Set<String> tiposDeExcecao = {
  'Exception',
  'StateError',
  'ArgumentError',
  'FormatException',
  'RangeError',
  'UnsupportedError',
};

class Biblioteca {
  Biblioteca({
    required this.invocar,
    required this.formatar,
    required this.msg,
  });

  final MensagensDart msg;

  final Object? Function(Object? funcao, List<Object?> argumentos) invocar;

  final String Function(Object? valor) formatar;

  Never _erro(String mensagem, Token t, {String? dica}) {
    throw ErroDart(
      mensagem,
      linha: t.linha,
      coluna: t.coluna,
      dica: dica,
      arquivo: t.arquivo,
    );
  }

  String _tipoDe(Object? v) => switch (v) {
    null => 'Null',
    int() => 'int',
    double() => 'double',
    String() => 'String',
    bool() => 'bool',
    List() => 'List',
    Set() => 'Set',
    Map() => 'Map',
    FuncaoDart() => 'Function',
    InstanciaDart(:final classe) => classe.nome,
    _ => v.runtimeType.toString(),
  };

  static const Object naoEncontrado = Object();

  Object? propriedade(Object? alvo, String nome, Token t) {
    switch (alvo) {
      case String s:
        return switch (nome) {
          'length' => s.length,
          'isEmpty' => s.isEmpty,
          'isNotEmpty' => s.isNotEmpty,
          'hashCode' => s.hashCode,
          'runtimeType' => 'String',
          _ => naoEncontrado,
        };

      case int n:
        return switch (nome) {
          'isEven' => n.isEven,
          'isOdd' => n.isOdd,
          'isNegative' => n.isNegative,
          'sign' => n.sign,
          'runtimeType' => 'int',
          _ => naoEncontrado,
        };

      case double d:
        return switch (nome) {
          'isNegative' => d.isNegative,
          'isNaN' => d.isNaN,
          'isFinite' => d.isFinite,
          'runtimeType' => 'double',
          _ => naoEncontrado,
        };

      case List<Object?> l:
        return switch (nome) {
          'length' => l.length,
          'isEmpty' => l.isEmpty,
          'isNotEmpty' => l.isNotEmpty,
          'first' =>
            l.isEmpty
                ? _erro(msg.listaVaziaFirst, t, dica: msg.listaVaziaFirstDica)
                : l.first,
          'last' => l.isEmpty ? _erro(msg.listaVaziaLast, t) : l.last,
          'firstOrNull' => l.isEmpty ? null : l.first,
          'lastOrNull' => l.isEmpty ? null : l.last,
          'reversed' => l.reversed.toList(),
          'runtimeType' => 'List',
          _ => naoEncontrado,
        };

      case Set<Object?> s:
        return switch (nome) {
          'length' => s.length,
          'isEmpty' => s.isEmpty,
          'isNotEmpty' => s.isNotEmpty,
          'first' => s.isEmpty ? _erro(msg.conjuntoVazio, t) : s.first,
          'runtimeType' => 'Set',
          _ => naoEncontrado,
        };

      case Map<Object?, Object?> m:
        return switch (nome) {
          'length' => m.length,
          'isEmpty' => m.isEmpty,
          'isNotEmpty' => m.isNotEmpty,
          'keys' => m.keys.toList(),
          'values' => m.values.toList(),
          'entries' => [
            for (final e in m.entries) ParChaveValor(e.key, e.value),
          ],
          'runtimeType' => 'Map',
          _ => naoEncontrado,
        };

      case ParChaveValor p:
        return switch (nome) {
          'key' => p.chave,
          'value' => p.valor,
          _ => naoEncontrado,
        };

      case ExcecaoDart e:
        return switch (nome) {
          'message' => e.mensagem,
          _ => naoEncontrado,
        };

      case bool b:
        return switch (nome) {
          'runtimeType' => 'bool',
          'hashCode' => b.hashCode,
          _ => naoEncontrado,
        };
    }
    return naoEncontrado;
  }

  Object? metodo(
    Object? alvo,
    String nome,
    List<Object?> args,
    Map<String, Object?> nomeados,
    Token t,
  ) {
    if (nome == 'toString' && args.isEmpty) return formatar(alvo);

    switch (alvo) {
      case EstaticoDart e:
        return _estatico(e, nome, args, nomeados, t);
      case String s:
        return _texto(s, nome, args, nomeados, t);
      case num n:
        return _numero(n, nome, args, t);
      case List<Object?> l:
        return _lista(l, nome, args, nomeados, t);
      case Set<Object?> s:
        return _conjunto(s, nome, args, t);
      case Map<Object?, Object?> m:
        return _mapa(m, nome, args, t);
    }

    return _erro(
      msg.tipoNaoTemMetodo(_tipoDe(alvo), nome),
      t,
      dica: msg.tipoNaoTemMetodoDica,
    );
  }

  Object? _estatico(
    EstaticoDart e,
    String nome,
    List<Object?> args,
    Map<String, Object?> nomeados,
    Token t,
  ) {
    final chave = '${e.nome}.$nome';
    switch (chave) {
      case 'int.parse':
        final texto = formatar(args.first);
        final v = int.tryParse(texto.trim());
        if (v == null) {
          return _erro(
            msg.intParseFalhou(texto),
            t,
            dica: msg.intParseFalhouDica,
          );
        }
        return v;
      case 'int.tryParse':
        return int.tryParse(formatar(args.first).trim());
      case 'double.parse':
        final texto = formatar(args.first);
        final v = double.tryParse(texto.trim());
        if (v == null) {
          return _erro(msg.doubleParseFalhou(texto), t);
        }
        return v;
      case 'double.tryParse':
        return double.tryParse(formatar(args.first).trim());
      case 'num.parse':
        return num.tryParse(formatar(args.first).trim()) ??
            _erro(msg.numParseFalhou, t);
      case 'List.generate':
        final n = args[0]! as int;
        final f = args[1];
        return [
          for (var i = 0; i < n; i++) invocar(f, [i]),
        ];
      case 'List.filled':
        final n = args[0]! as int;
        return List<Object?>.filled(n, args[1], growable: true);
      case 'List.from':
        return List<Object?>.from(args.first! as Iterable<Object?>);
      case 'Set.from':
        return Set<Object?>.from(args.first! as Iterable<Object?>);
      case 'Map.from':
        return Map<Object?, Object?>.from(args.first! as Map<Object?, Object?>);
      case 'String.fromCharCode':
        return String.fromCharCode(args.first! as int);
    }
    return _erro(msg.enumNaoTem(e.nome, nome), t);
  }

  Object? _texto(
    String s,
    String nome,
    List<Object?> args,
    Map<String, Object?> nomeados,
    Token t,
  ) {
    switch (nome) {
      case 'toUpperCase':
        return s.toUpperCase();
      case 'toLowerCase':
        return s.toLowerCase();
      case 'trim':
        return s.trim();
      case 'contains':
        return s.contains(formatar(args.first));
      case 'startsWith':
        return s.startsWith(formatar(args.first));
      case 'endsWith':
        return s.endsWith(formatar(args.first));
      case 'indexOf':
        return s.indexOf(formatar(args.first));
      case 'split':
        return s.split(formatar(args.first));
      case 'replaceAll':
        return s.replaceAll(formatar(args[0]), formatar(args[1]));
      case 'padLeft':
        return s.padLeft(
          args[0]! as int,
          args.length > 1 ? formatar(args[1]) : ' ',
        );
      case 'padRight':
        return s.padRight(
          args[0]! as int,
          args.length > 1 ? formatar(args[1]) : ' ',
        );
      case 'compareTo':
        return s.compareTo(formatar(args.first));
      case 'codeUnitAt':
        return s.codeUnitAt(args.first! as int);
      case 'substring':
        final inicio = args[0]! as int;
        final fim = args.length > 1 ? args[1] as int? : null;
        if (inicio < 0 ||
            inicio > s.length ||
            (fim != null && fim > s.length)) {
          return _erro(msg.substringForaIntervalo(s.length), t);
        }
        return s.substring(inicio, fim);
    }
    return _erro(msg.tipoNaoTemMetodo('String', nome), t);
  }

  Object? _numero(num n, String nome, List<Object?> args, Token t) {
    switch (nome) {
      case 'abs':
        return n.abs();
      case 'round':
        return n.round();
      case 'floor':
        return n.floor();
      case 'ceil':
        return n.ceil();
      case 'toInt':
        return n.toInt();
      case 'toDouble':
        return n.toDouble();
      case 'toStringAsFixed':
        return n.toStringAsFixed(args.first! as int);
      case 'compareTo':
        return n.compareTo(args.first! as num);
      case 'clamp':
        return n.clamp(args[0]! as num, args[1]! as num);
      case 'remainder':
        return n.remainder(args.first! as num);
    }
    return _erro(msg.tipoNaoTemMetodo(_tipoDe(n), nome), t);
  }

  Object? _lista(
    List<Object?> l,
    String nome,
    List<Object?> args,
    Map<String, Object?> nomeados,
    Token t,
  ) {
    switch (nome) {
      case 'add':
        l.add(args.first);
        return null;
      case 'addAll':
        l.addAll(args.first! as Iterable<Object?>);
        return null;
      case 'insert':
        l.insert(args[0]! as int, args[1]);
        return null;
      case 'remove':
        return l.remove(args.first);
      case 'removeAt':
        return l.removeAt(args.first! as int);
      case 'removeLast':
        return l.removeLast();
      case 'clear':
        l.clear();
        return null;
      case 'contains':
        return l.contains(args.first);
      case 'indexOf':
        return l.indexOf(args.first);
      case 'elementAt':
        return l.elementAt(args.first! as int);
      case 'sublist':
        return l.sublist(
          args[0]! as int,
          args.length > 1 ? args[1] as int? : null,
        );
      case 'join':
        final sep = args.isEmpty ? '' : formatar(args.first);
        return l.map(formatar).join(sep);
      case 'toList':
        return List<Object?>.from(l);
      case 'toSet':
        return Set<Object?>.from(l);
      case 'take':
        return l.take(args.first! as int).toList();
      case 'skip':
        return l.skip(args.first! as int).toList();
      case 'map':
        return [
          for (final e in l) invocar(args.first, [e]),
        ];
      case 'where':
        return [
          for (final e in l)
            if (invocar(args.first, [e]) == true) e,
        ];
      case 'expand':
        return [
          for (final e in l) ...invocar(args.first, [e])! as Iterable<Object?>,
        ];
      case 'forEach':
        for (final e in l) {
          invocar(args.first, [e]);
        }
        return null;
      case 'any':
        return l.any((e) => invocar(args.first, [e]) == true);
      case 'every':
        return l.every((e) => invocar(args.first, [e]) == true);
      case 'reduce':
        if (l.isEmpty) {
          return _erro(msg.reduceListaVazia, t, dica: msg.reduceListaVaziaDica);
        }
        var acumulado = l.first;
        for (var i = 1; i < l.length; i++) {
          acumulado = invocar(args.first, [acumulado, l[i]]);
        }
        return acumulado;
      case 'fold':
        var acumulado = args[0];
        for (final e in l) {
          acumulado = invocar(args[1], [acumulado, e]);
        }
        return acumulado;
      case 'firstWhere':
        for (final e in l) {
          if (invocar(args.first, [e]) == true) return e;
        }
        final orElse = nomeados['orElse'];
        if (orElse != null) return invocar(orElse, const []);
        return _erro(
          msg.firstWhereNaoEncontrou,
          t,
          dica: msg.firstWhereNaoEncontrouDica,
        );
      case 'sort':
        if (args.isEmpty) {
          l.sort((a, b) => (a! as Comparable<Object?>).compareTo(b));
        } else {
          l.sort((a, b) => invocar(args.first, [a, b])! as int);
        }
        return null;
    }
    return _erro(msg.tipoNaoTemMetodo('List', nome), t);
  }

  Object? _conjunto(Set<Object?> s, String nome, List<Object?> args, Token t) {
    switch (nome) {
      case 'add':
        return s.add(args.first);
      case 'remove':
        return s.remove(args.first);
      case 'contains':
        return s.contains(args.first);
      case 'toList':
        return s.toList();
      case 'join':
        return s.map(formatar).join(args.isEmpty ? '' : formatar(args.first));
    }
    return _erro(msg.tipoNaoTemMetodo('Set', nome), t);
  }

  Object? _mapa(
    Map<Object?, Object?> m,
    String nome,
    List<Object?> args,
    Token t,
  ) {
    switch (nome) {
      case 'containsKey':
        return m.containsKey(args.first);
      case 'containsValue':
        return m.containsValue(args.first);
      case 'remove':
        return m.remove(args.first);
      case 'addAll':
        m.addAll(args.first! as Map<Object?, Object?>);
        return null;
      case 'putIfAbsent':
        return m.putIfAbsent(args[0], () => invocar(args[1], const []));
      case 'forEach':
        for (final e in m.entries) {
          invocar(args.first, [e.key, e.value]);
        }
        return null;
      case 'clear':
        m.clear();
        return null;
    }
    return _erro(msg.tipoNaoTemMetodo('Map', nome), t);
  }
}
