import 'token.dart';

sealed class Expressao {
  const Expressao(this.token);

  final Token token;
}

final class LiteralExpr extends Expressao {
  const LiteralExpr(super.token, this.valor);
  final Object? valor;
}

final class TextoExpr extends Expressao {
  const TextoExpr(super.token, this.partes);

  final List<Object> partes;
}

final class ListaExpr extends Expressao {
  const ListaExpr(super.token, this.elementos);
  final List<ElementoColecao> elementos;
}

final class MapaExpr extends Expressao {
  const MapaExpr(super.token, this.entradas);
  final List<EntradaMapa> entradas;
}

final class VariavelExpr extends Expressao {
  const VariavelExpr(super.token, this.nome);
  final String nome;
}

final class AtribuicaoExpr extends Expressao {
  const AtribuicaoExpr(super.token, this.alvo, this.operador, this.valor);
  final Expressao alvo;

  final String operador;
  final Expressao valor;
}

final class BinariaExpr extends Expressao {
  const BinariaExpr(super.token, this.esquerda, this.operador, this.direita);
  final Expressao esquerda;
  final String operador;
  final Expressao direita;
}

final class LogicaExpr extends Expressao {
  const LogicaExpr(super.token, this.esquerda, this.operador, this.direita);
  final Expressao esquerda;
  final String operador;
  final Expressao direita;
}

final class UnariaExpr extends Expressao {
  const UnariaExpr(super.token, this.operador, this.operando);
  final String operador;
  final Expressao operando;
}

final class BangExpr extends Expressao {
  const BangExpr(super.token, this.operando);
  final Expressao operando;
}

final class IncrementoExpr extends Expressao {
  const IncrementoExpr(
    super.token,
    this.alvo,
    this.operador, {
    required this.prefixado,
  });
  final Expressao alvo;
  final String operador;
  final bool prefixado;
}

final class TernarioExpr extends Expressao {
  const TernarioExpr(super.token, this.condicao, this.entao, this.senao);
  final Expressao condicao;
  final Expressao entao;
  final Expressao senao;
}

final class ChamadaExpr extends Expressao {
  const ChamadaExpr(
    super.token,
    this.alvo,
    this.argumentos,
    this.argumentosNomeados,
  );
  final Expressao alvo;
  final List<Expressao> argumentos;
  final Map<String, Expressao> argumentosNomeados;
}

final class MembroExpr extends Expressao {
  const MembroExpr(
    super.token,
    this.objeto,
    this.nome, {
    required this.anulavel,
  });
  final Expressao objeto;
  final String nome;
  final bool anulavel;
}

final class IndiceExpr extends Expressao {
  const IndiceExpr(super.token, this.objeto, this.indice);
  final Expressao objeto;
  final Expressao indice;
}

final class FuncaoAnonimaExpr extends Expressao {
  const FuncaoAnonimaExpr(super.token, this.parametros, this.corpo);
  final List<Parametro> parametros;
  final List<Comando> corpo;
}

final class TesteTipoExpr extends Expressao {
  const TesteTipoExpr(
    super.token,
    this.objeto,
    this.tipo, {
    required this.negado,
  });
  final Expressao objeto;
  final String tipo;
  final bool negado;
}

final class EsteExpr extends Expressao {
  const EsteExpr(super.token);
}

sealed class ElementoColecao {
  const ElementoColecao();
}

final class ElementoValor extends ElementoColecao {
  const ElementoValor(this.valor);
  final Expressao valor;
}

final class ElementoEspalhar extends ElementoColecao {
  const ElementoEspalhar(this.valor, {required this.anulavel});
  final Expressao valor;
  final bool anulavel;
}

final class ElementoSe extends ElementoColecao {
  const ElementoSe(this.condicao, this.entao, this.senao);
  final Expressao condicao;
  final ElementoColecao entao;
  final ElementoColecao? senao;
}

final class ElementoPara extends ElementoColecao {
  const ElementoPara(this.variavel, this.iteravel, this.corpo);
  final String variavel;
  final Expressao iteravel;
  final ElementoColecao corpo;
}

class EntradaMapa {
  const EntradaMapa(this.chave, this.valor);
  final Expressao chave;
  final Expressao valor;
}

sealed class Comando {
  const Comando(this.token);
  final Token token;
}

final class ExpressaoComando extends Comando {
  const ExpressaoComando(super.token, this.expressao);
  final Expressao expressao;
}

final class DeclaracaoVariavelComando extends Comando {
  const DeclaracaoVariavelComando(
    super.token,
    this.nome,
    this.inicial, {
    required this.ehFinal,
    this.tipoAnotado,
  });
  final String nome;
  final Expressao? inicial;
  final bool ehFinal;
  final String? tipoAnotado;
}

final class BlocoComando extends Comando {
  const BlocoComando(super.token, this.comandos);
  final List<Comando> comandos;
}

final class SeComando extends Comando {
  const SeComando(super.token, this.condicao, this.entao, this.senao);
  final Expressao condicao;
  final Comando entao;
  final Comando? senao;
}

final class EnquantoComando extends Comando {
  const EnquantoComando(super.token, this.condicao, this.corpo);
  final Expressao condicao;
  final Comando corpo;
}

final class FacaEnquantoComando extends Comando {
  const FacaEnquantoComando(super.token, this.corpo, this.condicao);
  final Comando corpo;
  final Expressao condicao;
}

final class ParaComando extends Comando {
  const ParaComando(
    super.token,
    this.inicializador,
    this.condicao,
    this.incrementos,
    this.corpo,
  );
  final Comando? inicializador;
  final Expressao? condicao;
  final List<Expressao> incrementos;
  final Comando corpo;
}

final class ParaEmComando extends Comando {
  const ParaEmComando(super.token, this.variavel, this.iteravel, this.corpo);
  final String variavel;
  final Expressao iteravel;
  final Comando corpo;
}

final class RetornoComando extends Comando {
  const RetornoComando(super.token, this.valor);
  final Expressao? valor;
}

final class QuebraComando extends Comando {
  const QuebraComando(super.token);
}

final class ContinuaComando extends Comando {
  const ContinuaComando(super.token);
}

final class LancaComando extends Comando {
  const LancaComando(super.token, this.valor);
  final Expressao valor;
}

final class EscolhaComando extends Comando {
  const EscolhaComando(super.token, this.valor, this.casos, this.padrao);
  final Expressao valor;
  final List<CasoEscolha> casos;
  final List<Comando>? padrao;
}

class CasoEscolha {
  const CasoEscolha(this.valores, this.comandos);

  final List<Expressao> valores;
  final List<Comando> comandos;
}

final class TenteComando extends Comando {
  const TenteComando(
    super.token,
    this.corpo,
    this.nomeErro,
    this.captura,
    this.finalmente,
  );
  final List<Comando> corpo;
  final String? nomeErro;
  final List<Comando>? captura;
  final List<Comando>? finalmente;
}

final class FuncaoComando extends Comando {
  const FuncaoComando(super.token, this.nome, this.parametros, this.corpo);
  final String nome;
  final List<Parametro> parametros;
  final List<Comando> corpo;
}

final class ClasseComando extends Comando {
  const ClasseComando(
    super.token,
    this.nome, {
    required this.campos,
    required this.metodos,
    required this.getters,
    this.construtor,
  });
  final String nome;
  final List<CampoClasse> campos;
  final List<FuncaoComando> metodos;
  final List<FuncaoComando> getters;
  final ConstrutorClasse? construtor;
}

class CampoClasse {
  const CampoClasse(this.nome, this.inicial);
  final String nome;
  final Expressao? inicial;
}

class ConstrutorClasse {
  const ConstrutorClasse(this.parametros, this.corpo);
  final List<Parametro> parametros;
  final List<Comando> corpo;
}

final class ImportComando extends Comando {
  const ImportComando(super.token, this.caminho);
  final String caminho;
}

class Parametro {
  const Parametro(
    this.nome, {
    this.padrao,
    this.ehNomeado = false,
    this.obrigatorio = true,
    this.ehCampoThis = false,
  });

  final String nome;
  final Expressao? padrao;
  final bool ehNomeado;
  final bool obrigatorio;

  final bool ehCampoThis;
}
