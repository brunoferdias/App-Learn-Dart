import '../../../../core/i18n/textos.dart';
import '../../../../core/utils/resultado.dart';
import '../entities/licao.dart';

abstract interface class LicaoRepositorio {
  Future<Resultado<List<Licao>>> listarTodas(Textos textos);
  Future<Resultado<Licao>> obterPorId(String id, Textos textos);
}
