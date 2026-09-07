import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../../domain/entities/progresso.dart';
import '../../domain/repositories/progresso_repositorio.dart';
import '../datasources/progresso_local_datasource.dart';
import '../models/progresso_model.dart';

class ProgressoRepositorioImpl implements ProgressoRepositorio {
  const ProgressoRepositorioImpl(this._datasource);

  final ProgressoLocalDatasource _datasource;

  @override
  Future<Resultado<Progresso>> carregar(Textos textos) async {
    try {
      final mapa = await _datasource.ler();
      return Resultado.ok(ProgressoModel.deMapa(mapa));
    } catch (e) {
      return Resultado.falha(textos.erroLerProgresso(e));
    }
  }

  @override
  Future<Resultado<Progresso>> salvar(
    Progresso progresso,
    Textos textos,
  ) async {
    try {
      final model = ProgressoModel.daEntidade(progresso);
      await _datasource.escrever(model.paraMapa());
      return Resultado.ok(progresso);
    } catch (e) {
      return Resultado.falha(textos.erroSalvarProgresso(e));
    }
  }
}
