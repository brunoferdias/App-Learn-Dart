import 'no_widget.dart';

sealed class FinderSimulado {
  const FinderSimulado();

  String get codigo;

  String get nomeInterno;

  String get descricao;

  bool combina(NoWidget no);

  List<NoLocalizado> encontrar(NoWidget raiz) =>
      NoWidget.achatar(raiz).where((n) => combina(n.no)).toList();
}

final class FinderTexto extends FinderSimulado {
  const FinderTexto(this.texto);
  final String texto;

  @override
  String get codigo => "find.text('$texto')";
  @override
  String get nomeInterno => '_TextWidgetFinder';
  @override
  String get descricao => 'widgets with text "$texto"';
  @override
  bool combina(NoWidget no) => no.tipo == 'Text' && no.texto == texto;
}

final class FinderTipo extends FinderSimulado {
  const FinderTipo(this.tipo);
  final String tipo;

  @override
  String get codigo => 'find.byType($tipo)';
  @override
  String get nomeInterno => '_TypeWidgetFinder';
  @override
  String get descricao => 'widgets with type "$tipo"';
  @override
  bool combina(NoWidget no) => no.tipo == tipo;
}

final class FinderIcone extends FinderSimulado {
  const FinderIcone(this.icone);
  final String icone;

  @override
  String get codigo => 'find.byIcon(CupertinoIcons.$icone)';
  @override
  String get nomeInterno => '_IconWidgetFinder';
  @override
  String get descricao => 'widgets with icon "CupertinoIcons.$icone"';
  @override
  bool combina(NoWidget no) => no.icone == icone;
}

final class FinderChave extends FinderSimulado {
  const FinderChave(this.chave);
  final String chave;

  @override
  String get codigo => "find.byKey(const Key('$chave'))";
  @override
  String get nomeInterno => '_KeyWidgetFinder';
  @override
  String get descricao => "widgets with key [<'$chave'>]";
  @override
  bool combina(NoWidget no) => no.chave == chave;
}
