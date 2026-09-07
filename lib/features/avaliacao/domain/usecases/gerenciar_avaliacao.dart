import '../entities/estado_avaliacao.dart';
import '../entities/momento_avaliacao.dart';
import '../repositories/avaliacao_repositorio.dart';

/// Lê o estado e, na primeira vez, carimba a data de início — é ela que faz a
/// carência da política valer a partir da instalação.
class CarregarAvaliacao {
  const CarregarAvaliacao(this._repositorio);
  final AvaliacaoRepositorio _repositorio;

  Future<EstadoAvaliacao> call({required DateTime agora}) async {
    final estado = await _repositorio.carregar();
    if (estado.primeiroUsoEm != null) return estado;

    final comInicio = estado.copiarCom(primeiroUsoEm: agora);
    await _repositorio.salvar(comInicio);
    return comInicio;
  }
}

class RegistrarMomento {
  const RegistrarMomento(this._repositorio);
  final AvaliacaoRepositorio _repositorio;

  Future<EstadoAvaliacao> call(
    EstadoAvaliacao atual,
    MomentoAvaliacao momento,
  ) async {
    final novo = atual.comMomento(momento);
    await _repositorio.salvar(novo);
    return novo;
  }
}

class RegistrarPedido {
  const RegistrarPedido(this._repositorio);
  final AvaliacaoRepositorio _repositorio;

  Future<EstadoAvaliacao> call(EstadoAvaliacao atual, DateTime agora) async {
    final novo = atual.comPedidoEm(agora);
    await _repositorio.salvar(novo);
    return novo;
  }
}

/// Chamado quando a pessoa avalia por vontade própria: o app para de tomar a
/// iniciativa para sempre.
class EncerrarPedidos {
  const EncerrarPedidos(this._repositorio);
  final AvaliacaoRepositorio _repositorio;

  Future<EstadoAvaliacao> call(EstadoAvaliacao atual) async {
    final novo = atual.encerrada();
    await _repositorio.salvar(novo);
    return novo;
  }
}
