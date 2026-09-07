import 'package:aprenda_dart/core/preferencias/preferencias.dart';
import 'package:aprenda_dart/features/avaliacao/data/datasources/avaliacao_local_datasource.dart';
import 'package:aprenda_dart/features/avaliacao/data/repositories/avaliacao_repositorio_impl.dart';
import 'package:aprenda_dart/features/avaliacao/domain/entities/momento_avaliacao.dart';
import 'package:aprenda_dart/features/avaliacao/domain/repositories/avaliacao_repositorio.dart';
import 'package:aprenda_dart/features/avaliacao/domain/repositories/loja_de_apps.dart';
import 'package:aprenda_dart/features/avaliacao/domain/usecases/gerenciar_avaliacao.dart';
import 'package:aprenda_dart/features/avaliacao/presentation/controllers/controlador_avaliacao.dart';
import 'package:flutter_test/flutter_test.dart';

class LojaFalsa implements LojaDeApps {
  LojaFalsa({this.disponivel = true});

  final bool disponivel;

  int pedidosNativos = 0;
  int aberturasDaFicha = 0;

  @override
  Future<bool> aceitaPedidoNativo() async => disponivel;

  @override
  Future<void> pedirAvaliacao() async => pedidosNativos++;

  @override
  Future<void> abrirFichaParaAvaliar() async => aberturasDaFicha++;
}

void main() {
  late Preferencias prefs;
  late AvaliacaoRepositorio repositorio;
  late LojaFalsa loja;
  late DateTime agora;

  ControladorAvaliacao criar() => ControladorAvaliacao(
    carregar: CarregarAvaliacao(repositorio),
    registrar: RegistrarMomento(repositorio),
    registrarPedido: RegistrarPedido(repositorio),
    encerrar: EncerrarPedidos(repositorio),
    loja: loja,
    relogio: () => agora,
    esperaAntesDeAparecer: Duration.zero,
  );

  /// Terminar uma lição e dois quizzes bons: o mínimo que a política pede.
  Future<void> usarBastante(ControladorAvaliacao c) async {
    await c.registrarMomento(MomentoAvaliacao.licaoConcluida);
    await c.registrarMomento(MomentoAvaliacao.quizComBomDesempenho);
    await c.registrarMomento(MomentoAvaliacao.quizComBomDesempenho);
  }

  setUp(() {
    prefs = PreferenciasEmMemoria();
    repositorio = AvaliacaoRepositorioImpl(AvaliacaoEmPreferencias(prefs));
    loja = LojaFalsa();
    agora = DateTime(2026, 9, 7);
  });

  test('a primeira abertura só carimba a data, sem pedir nada', () async {
    final controlador = criar();
    await controlador.iniciar();

    expect(controlador.estado.primeiroUsoEm, agora);
    expect(loja.pedidosNativos, 0);
  });

  test('quem usa muito no primeiro dia ainda não é interrompido', () async {
    final controlador = criar();
    await controlador.iniciar();

    await usarBastante(controlador);

    expect(loja.pedidosNativos, 0);
  });

  test('depois da carência, o momento bom vira um pedido — um só', () async {
    final controlador = criar();
    await controlador.iniciar();

    agora = agora.add(const Duration(days: 5));
    await usarBastante(controlador);

    expect(loja.pedidosNativos, 1);

    await usarBastante(controlador);
    await usarBastante(controlador);

    expect(loja.pedidosNativos, 1, reason: 'seria insistir no mesmo mês');
  });

  test('sem loja disponível, o pedido não é gasto', () async {
    loja = LojaFalsa(disponivel: false);
    final controlador = criar();
    await controlador.iniciar();

    agora = agora.add(const Duration(days: 5));
    await usarBastante(controlador);

    expect(loja.pedidosNativos, 0);
    expect(controlador.estado.pedidos, 0);
  });

  test('a data de início sobrevive ao fechar e abrir o app', () async {
    final primeira = criar();
    await primeira.iniciar();
    final inicio = primeira.estado.primeiroUsoEm;

    agora = agora.add(const Duration(days: 5));

    final segunda = criar();
    await segunda.iniciar();

    expect(segunda.estado.primeiroUsoEm, inicio);
  });

  test('avaliar pelo perfil abre a loja e desliga o pedido automático', () async {
    final controlador = criar();
    await controlador.iniciar();

    await controlador.avaliarNaLoja();

    expect(loja.aberturasDaFicha, 1);
    expect(controlador.jaAvaliou, isTrue);

    agora = agora.add(const Duration(days: 5));
    await usarBastante(controlador);

    expect(loja.pedidosNativos, 0);
  });

  test('o "já avaliou" também sobrevive ao reinício do app', () async {
    final primeira = criar();
    await primeira.iniciar();
    await primeira.avaliarNaLoja();

    final segunda = criar();
    await segunda.iniciar();

    expect(segunda.jaAvaliou, isTrue);
  });
}
