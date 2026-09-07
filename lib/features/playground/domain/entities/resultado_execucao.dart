import 'diagnostico.dart';

class ResultadoExecucao {
  const ResultadoExecucao({
    required this.saida,
    required this.duracao,
    this.erro,
  });

  final List<String> saida;

  final Duration duracao;

  final Diagnostico? erro;

  bool get deuCerto => erro == null;
}
