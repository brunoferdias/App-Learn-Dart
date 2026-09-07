import '../../../../core/i18n/textos.dart';
import '../../domain/entities/arquivo_dart.dart';
import '../../domain/entities/diagnostico.dart';
import '../../domain/entities/resultado_execucao.dart';
import '../../domain/repositories/playground_repositorio.dart';
import '../datasources/exemplos_locais_datasource.dart';
import '../interpretador/ast.dart';
import '../interpretador/erro_dart.dart';
import '../interpretador/interpretador.dart';
import '../interpretador/lexer.dart';
import '../interpretador/mensagens.dart';
import '../interpretador/parser.dart';
import '../interpretador/valores.dart';

class PlaygroundRepositorioImpl implements PlaygroundRepositorio {
  const PlaygroundRepositorioImpl(this._datasource);

  final ExemplosLocaisDatasource _datasource;

  @override
  List<ArquivoDart> arquivosIniciais(Textos textos) =>
      _datasource.iniciais(textos.idioma);

  @override
  List<ExemploPlayground> exemplos(Textos textos) =>
      _datasource.exemplos(textos.idioma);

  @override
  List<Diagnostico> analisar(List<ArquivoDart> arquivos, Textos textos) {
    final problemas = <Diagnostico>[];
    final msg = MensagensDart.de(textos.idioma);

    for (final arquivo in arquivos) {
      try {
        _analisarUm(arquivo, msg);
      } on ErroDart catch (e) {
        problemas.add(_paraDiagnostico(e, arquivo.nome));
      }
    }

    if (problemas.isEmpty && !arquivos.any((a) => a.temMain)) {
      problemas.add(
        Diagnostico(
          mensagem: textos.diagSemMain,
          linha: 1,
          coluna: 1,
          arquivo: arquivos.isEmpty ? '' : arquivos.first.nome,
          tipo: TipoDiagnostico.sintaxe,
          dica: textos.diagSemMainDica,
        ),
      );
    }

    return problemas;
  }

  List<Comando> _analisarUm(ArquivoDart arquivo, MensagensDart msg) {
    final tokens = Lexer(
      arquivo.conteudo,
      msg: msg,
      arquivo: arquivo.nome,
    ).tokenizar();
    return Parser(tokens, msg: msg).analisar();
  }

  @override
  ResultadoExecucao executar(List<ArquivoDart> arquivos, Textos textos) {
    final relogio = Stopwatch()..start();
    final msg = MensagensDart.de(textos.idioma);

    final programa = <Comando>[];
    for (final arquivo in arquivos) {
      try {
        programa.addAll(_analisarUm(arquivo, msg));
      } on ErroDart catch (e) {
        return ResultadoExecucao(
          saida: const [],
          duracao: relogio.elapsed,
          erro: _paraDiagnostico(e, arquivo.nome),
        );
      }
    }

    final nomes = arquivos.map((a) => a.nome).toSet();
    for (final comando in programa) {
      if (comando is ImportComando &&
          !comando.caminho.startsWith('dart:') &&
          !comando.caminho.startsWith('package:') &&
          !nomes.contains(comando.caminho)) {
        return ResultadoExecucao(
          saida: const [],
          duracao: relogio.elapsed,
          erro: Diagnostico(
            mensagem: textos.diagAbaInexistente(comando.caminho),
            linha: comando.token.linha,
            coluna: comando.token.coluna,
            arquivo: comando.token.arquivo,
            tipo: TipoDiagnostico.sintaxe,
            dica: textos.diagAbasDisponiveis(nomes.join(', ')),
          ),
        );
      }
    }

    final interpretador = Interpretador(msg: msg);
    try {
      final saida = interpretador.executar(programa);
      return ResultadoExecucao(saida: saida, duracao: relogio.elapsed);
    } on ErroDart catch (e) {
      return ResultadoExecucao(
        saida: interpretador.saida,
        duracao: relogio.elapsed,
        erro: _paraDiagnostico(e, e.arquivo),
      );
    } on LancamentoDoUsuario catch (e) {
      return ResultadoExecucao(
        saida: interpretador.saida,
        duracao: relogio.elapsed,
        erro: Diagnostico(
          mensagem: textos.diagExcecaoNaoTratada(
            interpretador.formatar(e.valor),
          ),
          linha: 1,
          coluna: 1,
          arquivo: '',
          tipo: TipoDiagnostico.execucao,
          dica: textos.diagExcecaoDica,
        ),
      );
    } on StackOverflowError {
      return ResultadoExecucao(
        saida: interpretador.saida,
        duracao: relogio.elapsed,
        erro: Diagnostico(
          mensagem: textos.diagRecursaoInfinita,
          linha: 1,
          coluna: 1,
          arquivo: '',
          tipo: TipoDiagnostico.execucao,
          dica: textos.diagRecursaoDica,
        ),
      );
    }
  }

  Diagnostico _paraDiagnostico(ErroDart e, String arquivoPadrao) => Diagnostico(
    mensagem: e.mensagem,
    linha: e.linha,
    coluna: e.coluna,
    arquivo: e.arquivo.isEmpty ? arquivoPadrao : e.arquivo,
    dica: e.dica,
    tipo: e.fase == FaseErro.execucao
        ? TipoDiagnostico.execucao
        : TipoDiagnostico.sintaxe,
  );
}
