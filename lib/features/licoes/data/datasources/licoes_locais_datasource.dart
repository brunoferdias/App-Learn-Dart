import '../../../../core/i18n/idioma.dart';
import '../../domain/entities/licao.dart';
import 'conteudo/en/licao_01_primeiros_passos.dart';
import 'conteudo/en/licao_02_variaveis.dart';
import 'conteudo/en/licao_03_null_safety.dart';
import 'conteudo/en/licao_04_funcoes.dart';
import 'conteudo/en/licao_05_controle_fluxo.dart';
import 'conteudo/en/licao_06_colecoes.dart';
import 'conteudo/en/licao_07_classes.dart';
import 'conteudo/en/licao_08_async.dart';
import 'conteudo/en/licao_09_dart3.dart';
import 'conteudo/en/licao_10_arquitetura.dart';
import 'conteudo/en/licao_11_testes.dart';
import 'conteudo/pt/licao_01_primeiros_passos.dart';
import 'conteudo/pt/licao_02_variaveis.dart';
import 'conteudo/pt/licao_03_null_safety.dart';
import 'conteudo/pt/licao_04_funcoes.dart';
import 'conteudo/pt/licao_05_controle_fluxo.dart';
import 'conteudo/pt/licao_06_colecoes.dart';
import 'conteudo/pt/licao_07_classes.dart';
import 'conteudo/pt/licao_08_async.dart';
import 'conteudo/pt/licao_09_dart3.dart';
import 'conteudo/pt/licao_10_arquitetura.dart';
import 'conteudo/pt/licao_11_testes.dart';

abstract interface class LicoesLocaisDatasource {
  Future<List<Licao>> buscarTodas(Idioma idioma);
}

class LicoesEmMemoria implements LicoesLocaisDatasource {
  const LicoesEmMemoria();

  static const List<Licao> _pt = [
    licao01PrimeirosPassos,
    licao02Variaveis,
    licao03NullSafety,
    licao04Funcoes,
    licao05ControleFluxo,
    licao06Colecoes,
    licao07Classes,
    licao08Async,
    licao09Dart3,
    licao10Arquitetura,
    licao11Testes,
  ];

  static const List<Licao> _en = [
    licao01PrimeirosPassosEn,
    licao02VariaveisEn,
    licao03NullSafetyEn,
    licao04FuncoesEn,
    licao05ControleFluxoEn,
    licao06ColecoesEn,
    licao07ClassesEn,
    licao08AsyncEn,
    licao09Dart3En,
    licao10ArquiteturaEn,
    licao11TestesEn,
  ];

  @override
  Future<List<Licao>> buscarTodas(Idioma idioma) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return switch (idioma) {
      Idioma.portugues => _pt,
      Idioma.ingles => _en,
    };
  }
}
