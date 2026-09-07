sealed class MatcherSimulado {
  const MatcherSimulado();

  String get codigo;

  String get esperado;

  bool aceita(int quantidade);

  String motivo(int quantidade);
}

final class EncontraUm extends MatcherSimulado {
  const EncontraUm();

  @override
  String get codigo => 'findsOneWidget';
  @override
  String get esperado => 'exactly one matching candidate';
  @override
  bool aceita(int quantidade) => quantidade == 1;
  @override
  String motivo(int quantidade) => quantidade == 0
      ? 'means none were found but one was expected'
      : 'is too many';
}

final class EncontraNada extends MatcherSimulado {
  const EncontraNada();

  @override
  String get codigo => 'findsNothing';
  @override
  String get esperado => 'no matching candidates';
  @override
  bool aceita(int quantidade) => quantidade == 0;
  @override
  String motivo(int quantidade) =>
      'means some were found but none were expected';
}

final class EncontraVarios extends MatcherSimulado {
  const EncontraVarios();

  @override
  String get codigo => 'findsWidgets';
  @override
  String get esperado => 'at least one matching candidate';
  @override
  bool aceita(int quantidade) => quantidade > 0;
  @override
  String motivo(int quantidade) =>
      'means none were found but some were expected';
}

final class EncontraN extends MatcherSimulado {
  const EncontraN(this.quantos);
  final int quantos;

  @override
  String get codigo => 'findsNWidgets($quantos)';
  @override
  String get esperado => 'exactly $quantos matching candidates';
  @override
  bool aceita(int quantidade) => quantidade == quantos;
  @override
  String motivo(int quantidade) =>
      quantidade < quantos ? 'is not enough' : 'is too many';
}
