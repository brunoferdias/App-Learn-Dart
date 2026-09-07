import '../i18n/textos.dart';

enum ModoTema {
  sistema,
  claro,
  escuro;

  String get codigo => name;

  static ModoTema deCodigo(String? codigo) => ModoTema.values.firstWhere(
    (m) => m.name == codigo,
    orElse: () => ModoTema.sistema,
  );

  String rotulo(Textos t) => switch (this) {
    ModoTema.sistema => t.temaSistema,
    ModoTema.claro => t.temaClaro,
    ModoTema.escuro => t.temaEscuro,
  };

  String descricao(Textos t) => switch (this) {
    ModoTema.sistema => t.temaSistemaDescricao,
    ModoTema.claro => t.temaClaroDescricao,
    ModoTema.escuro => t.temaEscuroDescricao,
  };

  bool get ehSistema => this == ModoTema.sistema;
}
