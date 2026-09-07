import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/progresso.dart';
import '../repositories/progresso_repositorio.dart';

class CarregarProgresso {
  const CarregarProgresso(this._repositorio);
  final ProgressoRepositorio _repositorio;

  Future<Resultado<Progresso>> call(Textos textos) =>
      _repositorio.carregar(textos);
}

class ConcluirLicao {
  const ConcluirLicao(this._repositorio);
  final ProgressoRepositorio _repositorio;

  Future<Resultado<Progresso>> call(
    Progresso atual,
    String licaoId,
    Textos textos,
  ) {
    final novo = atual.copiarCom(
      licoesConcluidas: {...atual.licoesConcluidas, licaoId},
    );
    return _repositorio.salvar(novo, textos);
  }
}

class RegistrarResposta {
  const RegistrarResposta(this._repositorio);
  final ProgressoRepositorio _repositorio;

  Future<Resultado<Progresso>> call(
    Progresso atual,
    Textos textos, {
    required bool acertou,
  }) {
    final novo = atual.copiarCom(
      acertos: acertou ? atual.acertos + 1 : atual.acertos,
      erros: acertou ? atual.erros : atual.erros + 1,
    );
    return _repositorio.salvar(novo, textos);
  }
}
