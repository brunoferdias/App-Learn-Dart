import '../../../../core/i18n/textos.dart';

sealed class Exercicio {
  const Exercicio({
    required this.id,
    required this.licaoId,
    required this.explicacao,
    this.enunciado,
  });

  final String id;
  final String licaoId;

  final String? enunciado;

  final String explicacao;

  String enunciadoPadrao(Textos t);

  String enunciadoDe(Textos t) => enunciado ?? enunciadoPadrao(t);

  List<String> alternativas(Textos t);
  int get indiceCorreto;

  bool acertou(int indiceEscolhido) => indiceEscolhido == indiceCorreto;
}

final class ExercicioCertoOuErrado extends Exercicio {
  const ExercicioCertoOuErrado({
    required super.id,
    required super.licaoId,
    required super.explicacao,
    required this.codigo,
    required this.estaCorreto,
    super.enunciado,
  });

  final String codigo;
  final bool estaCorreto;

  @override
  String enunciadoPadrao(Textos t) => t.enunciadoPadraoCertoOuErrado;

  @override
  List<String> alternativas(Textos t) => [
    t.alternativaEstaCerto,
    t.alternativaEstaErrado,
  ];

  @override
  int get indiceCorreto => estaCorreto ? 0 : 1;
}

final class ExercicioMultiplaEscolha extends Exercicio {
  const ExercicioMultiplaEscolha({
    required super.id,
    required super.licaoId,
    required String super.enunciado,
    required super.explicacao,
    required this.opcoes,
    required this.resposta,
    this.codigo,
  });

  final List<String> opcoes;
  final int resposta;

  final String? codigo;

  @override
  String enunciadoPadrao(Textos t) => t.formatoMultiplaEscolha;

  @override
  List<String> alternativas(Textos t) => opcoes;

  @override
  int get indiceCorreto => resposta;
}

final class ExercicioCompletar extends Exercicio {
  const ExercicioCompletar({
    required super.id,
    required super.licaoId,
    required super.explicacao,
    required this.codigoComLacuna,
    required this.opcoes,
    required this.resposta,
    super.enunciado,
  });

  final String codigoComLacuna;
  final List<String> opcoes;
  final int resposta;

  @override
  String enunciadoPadrao(Textos t) => t.enunciadoPadraoCompletar;

  @override
  List<String> alternativas(Textos t) => opcoes;

  @override
  int get indiceCorreto => resposta;

  String codigoPreenchido(int indice) =>
      codigoComLacuna.replaceAll('___', opcoes[indice]);
}
