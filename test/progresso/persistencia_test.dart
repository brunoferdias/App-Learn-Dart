import 'package:aprenda_dart/core/i18n/textos_pt.dart';
import 'package:aprenda_dart/core/preferencias/preferencias.dart';
import 'package:aprenda_dart/features/progresso/data/datasources/progresso_local_datasource.dart';
import 'package:aprenda_dart/features/progresso/data/repositories/progresso_repositorio_impl.dart';
import 'package:aprenda_dart/features/progresso/domain/entities/progresso.dart';
import 'package:aprenda_dart/features/progresso/domain/repositories/progresso_repositorio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const textos = TextosPt();

  late Preferencias prefs;

  /// Um repositório novo sobre as mesmas preferências: é o que acontece quando
  /// a pessoa fecha o app e abre de novo.
  ProgressoRepositorio repositorio() =>
      ProgressoRepositorioImpl(ProgressoEmPreferencias(prefs));

  setUp(() => prefs = PreferenciasEmMemoria());

  test('o disco vazio vira um progresso zerado, sem quebrar', () async {
    final lido = await repositorio().carregar(textos);

    expect(lido.valorOuNulo?.licoesConcluidas, isEmpty);
    expect(lido.valorOuNulo?.acertos, 0);
    expect(lido.valorOuNulo?.erros, 0);
  });

  test('lições, acertos e erros sobrevivem ao fechar o app', () async {
    const feito = Progresso(
      licoesConcluidas: {'null-safety', 'funcoes'},
      acertos: 7,
      erros: 3,
    );

    await repositorio().salvar(feito, textos);

    final depoisDeReabrir = await repositorio().carregar(textos);
    final p = depoisDeReabrir.valorOuNulo!;

    expect(p.licoesConcluidas, {'null-safety', 'funcoes'});
    expect(p.acertos, 7);
    expect(p.erros, 3);
    expect(p.percentual, 70);
  });

  test('salvar de novo substitui, em vez de acumular lixo', () async {
    await repositorio().salvar(
      const Progresso(licoesConcluidas: {'a', 'b'}, acertos: 2),
      textos,
    );
    await repositorio().salvar(
      const Progresso(licoesConcluidas: {'a'}, acertos: 5),
      textos,
    );

    final p = (await repositorio().carregar(textos)).valorOuNulo!;

    expect(p.licoesConcluidas, {'a'});
    expect(p.acertos, 5);
  });

  test('as chaves gravadas são as esperadas no disco', () async {
    await repositorio().salvar(
      const Progresso(licoesConcluidas: {'dart-3'}, acertos: 1, erros: 1),
      textos,
    );

    expect(prefs.lerListaDeTextos(ChavesPref.progressoLicoes), ['dart-3']);
    expect(prefs.lerInteiro(ChavesPref.progressoAcertos), 1);
    expect(prefs.lerInteiro(ChavesPref.progressoErros), 1);
  });

  test('apagar zera o progresso e tira as chaves do disco', () async {
    await repositorio().salvar(
      const Progresso(licoesConcluidas: {'a', 'b'}, acertos: 9, erros: 4),
      textos,
    );

    final zerado = (await repositorio().apagar(textos)).valorOuNulo!;

    expect(zerado.licoesConcluidas, isEmpty);
    expect(zerado.acertos, 0);
    expect(zerado.erros, 0);

    expect(prefs.lerListaDeTextos(ChavesPref.progressoLicoes), isNull);
    expect(prefs.lerInteiro(ChavesPref.progressoAcertos), 0);
    expect(prefs.lerInteiro(ChavesPref.progressoErros), 0);
  });

  test('depois de apagar, reabrir o app continua zerado', () async {
    await repositorio().salvar(
      const Progresso(licoesConcluidas: {'null-safety'}, acertos: 3),
      textos,
    );
    await repositorio().apagar(textos);

    final p = (await repositorio().carregar(textos)).valorOuNulo!;

    expect(p.licoesConcluidas, isEmpty);
    expect(p.acertos, 0);
  });
}
