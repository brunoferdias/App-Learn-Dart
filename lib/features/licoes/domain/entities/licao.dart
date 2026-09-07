import '../../../../core/i18n/textos.dart';
import 'bloco_conteudo.dart';

enum NivelLicao {
  iniciante,
  intermediario,
  avancado;

  String rotulo(Textos t) => switch (this) {
    NivelLicao.iniciante => t.nivelIniciante,
    NivelLicao.intermediario => t.nivelIntermediario,
    NivelLicao.avancado => t.nivelAvancado,
  };
}

class Licao {
  const Licao({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.nivel,
    required this.minutos,
    required this.objetivos,
    required this.blocos,
  });

  final String id;
  final String titulo;
  final String resumo;
  final NivelLicao nivel;
  final int minutos;
  final List<String> objetivos;
  final List<BlocoConteudo> blocos;

  int get quantidadeDeExemplos => blocos.whereType<BlocoCodigo>().length;
}
