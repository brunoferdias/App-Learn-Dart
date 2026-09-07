import 'ast.dart';

class Ambiente {
  Ambiente([this.pai]);

  final Ambiente? pai;
  final Map<String, Object?> _valores = {};
  final Set<String> _finais = {};

  void declarar(String nome, Object? valor, {bool ehFinal = false}) {
    _valores[nome] = valor;
    if (ehFinal) _finais.add(nome);
  }

  bool existe(String nome) =>
      _valores.containsKey(nome) || (pai?.existe(nome) ?? false);

  bool ehFinal(String nome) {
    if (_valores.containsKey(nome)) return _finais.contains(nome);
    return pai?.ehFinal(nome) ?? false;
  }

  Object? ler(String nome) {
    if (_valores.containsKey(nome)) return _valores[nome];
    final p = pai;
    if (p != null) return p.ler(nome);
    return null;
  }

  bool atribuir(String nome, Object? valor) {
    if (_valores.containsKey(nome)) {
      _valores[nome] = valor;
      return true;
    }
    return pai?.atribuir(nome, valor) ?? false;
  }
}

class FuncaoDart {
  const FuncaoDart({
    required this.nome,
    required this.parametros,
    required this.corpo,
    required this.fechamento,
    this.esteObjeto,
  });

  final String nome;
  final List<Parametro> parametros;
  final List<Comando> corpo;

  final Ambiente fechamento;

  final InstanciaDart? esteObjeto;

  FuncaoDart ligarA(InstanciaDart instancia) => FuncaoDart(
    nome: nome,
    parametros: parametros,
    corpo: corpo,
    fechamento: fechamento,
    esteObjeto: instancia,
  );

  @override
  String toString() => "Closure: '$nome'";
}

class ClasseDart {
  const ClasseDart({
    required this.nome,
    required this.campos,
    required this.metodos,
    required this.getters,
    required this.construtor,
    required this.fechamento,
  });

  final String nome;
  final List<CampoClasse> campos;
  final Map<String, FuncaoComando> metodos;
  final Map<String, FuncaoComando> getters;
  final ConstrutorClasse? construtor;
  final Ambiente fechamento;

  @override
  String toString() => nome;
}

class InstanciaDart {
  InstanciaDart(this.classe);

  final ClasseDart classe;
  final Map<String, Object?> campos = {};

  @override
  String toString() => "Instance of '${classe.nome}'";
}

class LancamentoDoUsuario implements Exception {
  const LancamentoDoUsuario(this.valor);
  final Object? valor;
}

class SinalRetorno {
  const SinalRetorno(this.valor);
  final Object? valor;
}

class SinalQuebra {
  const SinalQuebra();
}

class SinalContinua {
  const SinalContinua();
}
