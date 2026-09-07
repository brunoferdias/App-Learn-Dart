import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/item_glossario.dart';
import '../repositories/glossario_repositorio.dart';

class BuscarNoGlossario {
  const BuscarNoGlossario(this._repositorio);
  final GlossarioRepositorio _repositorio;

  Future<Resultado<List<ItemGlossario>>> call(
    Textos textos, [
    String termo = '',
  ]) async {
    final resultado = await _repositorio.listar(textos);

    return resultado.quando(
      sucesso: (itens) =>
          Resultado.ok(itens.where((i) => i.combinaCom(termo)).toList()),
      falha: Resultado.falha,
    );
  }
}
