sealed class Resultado<T> {
  const Resultado();

  const factory Resultado.ok(T valor) = Sucesso<T>;
  const factory Resultado.falha(String mensagem) = Falha<T>;

  R quando<R>({
    required R Function(T valor) sucesso,
    required R Function(String mensagem) falha,
  }) {
    return switch (this) {
      Sucesso(:final valor) => sucesso(valor),
      Falha(:final mensagem) => falha(mensagem),
    };
  }

  T? get valorOuNulo => switch (this) {
    Sucesso(:final valor) => valor,
    Falha() => null,
  };
}

final class Sucesso<T> extends Resultado<T> {
  const Sucesso(this.valor);
  final T valor;
}

final class Falha<T> extends Resultado<T> {
  const Falha(this.mensagem);
  final String mensagem;
}
