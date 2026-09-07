sealed class BlocoConteudo {
  const BlocoConteudo();
}

final class BlocoTexto extends BlocoConteudo {
  const BlocoTexto(this.texto);
  final String texto;
}

final class BlocoTitulo extends BlocoConteudo {
  const BlocoTitulo(this.texto);
  final String texto;
}

final class BlocoCodigo extends BlocoConteudo {
  const BlocoCodigo(this.codigo, {this.legenda, this.saida});
  final String codigo;
  final String? legenda;
  final String? saida;
}

final class BlocoDica extends BlocoConteudo {
  const BlocoDica(this.texto);
  final String texto;
}

final class BlocoAviso extends BlocoConteudo {
  const BlocoAviso(this.texto);
  final String texto;
}

final class BlocoComparacao extends BlocoConteudo {
  const BlocoComparacao({
    required this.codigoErrado,
    required this.notaErrado,
    required this.codigoCerto,
    required this.notaCerto,
  });

  final String codigoErrado;
  final String notaErrado;
  final String codigoCerto;
  final String notaCerto;
}

final class BlocoLista extends BlocoConteudo {
  const BlocoLista(this.itens);
  final List<String> itens;
}

final class BlocoTabela extends BlocoConteudo {
  const BlocoTabela({required this.cabecalho, required this.linhas});
  final (String, String) cabecalho;
  final List<(String, String)> linhas;
}

final class BlocoLaboratorio extends BlocoConteudo {
  const BlocoLaboratorio({required this.titulo, required this.chamada});
  final String titulo;
  final String chamada;
}
