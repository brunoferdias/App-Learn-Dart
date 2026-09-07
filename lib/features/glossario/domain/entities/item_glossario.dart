import '../../../../core/i18n/textos.dart';

enum CategoriaGlossario {
  sintaxe,
  nullSafety,
  funcoes,
  colecoes,
  classes,
  assincrono;

  String rotulo(Textos t) => switch (this) {
    CategoriaGlossario.sintaxe => t.categoriaSintaxe,
    CategoriaGlossario.nullSafety => t.categoriaNullSafety,
    CategoriaGlossario.funcoes => t.categoriaFuncoes,
    CategoriaGlossario.colecoes => t.categoriaColecoes,
    CategoriaGlossario.classes => t.categoriaClasses,
    CategoriaGlossario.assincrono => t.categoriaAssincrono,
  };
}

class ItemGlossario {
  const ItemGlossario({
    required this.termo,
    required this.sintaxe,
    required this.significado,
    required this.categoria,
  });

  final String termo;
  final String sintaxe;
  final String significado;
  final CategoriaGlossario categoria;

  bool combinaCom(String termoBuscado) {
    final busca = termoBuscado.toLowerCase().trim();
    if (busca.isEmpty) return true;
    return termo.toLowerCase().contains(busca) ||
        sintaxe.toLowerCase().contains(busca) ||
        significado.toLowerCase().contains(busca);
  }
}
