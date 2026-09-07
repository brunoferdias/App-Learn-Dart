enum TomSaida { normal, sucesso, falha, apagado }

typedef LinhaSaida = ({TomSaida tom, String texto});

class ResultadoTeste {
  const ResultadoTeste({
    required this.passou,
    required this.linhaExpect,
    required this.quantidadeEncontrada,
    required this.caminhosEncontrados,
    required this.saida,
  });

  final bool passou;

  final String linhaExpect;

  final int quantidadeEncontrada;

  final List<String> caminhosEncontrados;

  final List<LinhaSaida> saida;
}
