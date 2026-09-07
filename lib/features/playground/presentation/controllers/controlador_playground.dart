import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/i18n/textos.dart';
import '../../domain/entities/arquivo_dart.dart';
import '../../domain/entities/diagnostico.dart';
import '../../domain/entities/resultado_execucao.dart';
import '../../domain/repositories/playground_repositorio.dart';
import '../../domain/usecases/analisar_codigo.dart';
import '../../domain/usecases/executar_codigo.dart';

class ControladorPlayground extends ChangeNotifier {
  ControladorPlayground({
    required this.executarCodigo,
    required this.analisarCodigo,
    required this.repositorio,
    required Textos textos,
  }) : _textos = textos {
    _arquivos = List.of(repositorio.arquivosIniciais(textos));
  }

  final ExecutarCodigo executarCodigo;
  final AnalisarCodigo analisarCodigo;
  final PlaygroundRepositorio repositorio;

  Textos _textos;

  void atualizarTextos(Textos novos) {
    if (novos.idioma == _textos.idioma) return;
    _textos = novos;
    _diagnosticos = analisarCodigo(_arquivos, _textos);
    notifyListeners();
  }

  late List<ArquivoDart> _arquivos;
  int _ativo = 0;
  ResultadoExecucao? _resultado;
  List<Diagnostico> _diagnosticos = const [];
  Timer? _debounce;

  List<ArquivoDart> get arquivos => List.unmodifiable(_arquivos);
  int get indiceAtivo => _ativo;
  ArquivoDart get arquivoAtivo => _arquivos[_ativo];
  ResultadoExecucao? get resultado => _resultado;
  List<Diagnostico> get diagnosticos => _diagnosticos;
  List<ExemploPlayground> get exemplos => repositorio.exemplos(_textos);

  Set<int> get linhasComErroNoAtivo => {
    for (final d in _diagnosticos)
      if (d.arquivo == arquivoAtivo.nome) d.linha,
    if (_resultado?.erro case final e?)
      if (e.arquivo == arquivoAtivo.nome) e.linha,
  };

  void selecionar(int indice) {
    if (indice == _ativo || indice < 0 || indice >= _arquivos.length) return;
    _ativo = indice;
    notifyListeners();
  }

  void atualizarConteudo(String texto) {
    _arquivos[_ativo] = _arquivos[_ativo].copiarCom(conteudo: texto);
    _agendarAnalise();
  }

  void _agendarAnalise() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _diagnosticos = analisarCodigo(_arquivos, _textos);
      notifyListeners();
    });
  }

  void adicionarArquivo() {
    var n = _arquivos.length;
    String nome;
    do {
      n++;
      nome = 'arquivo$n.dart';
    } while (_arquivos.any((a) => a.nome == nome));

    _arquivos.add(
      ArquivoDart(
        id: 'a${DateTime.now().microsecondsSinceEpoch}',
        nome: nome,
        conteudo: '// $nome\n\n',
      ),
    );
    _ativo = _arquivos.length - 1;
    _agendarAnalise();
    notifyListeners();
  }

  bool removerArquivo(int indice) {
    if (_arquivos.length <= 1) return false;
    _arquivos.removeAt(indice);
    if (_ativo >= _arquivos.length) _ativo = _arquivos.length - 1;
    _diagnosticos = analisarCodigo(_arquivos, _textos);
    notifyListeners();
    return true;
  }

  void renomear(int indice, String novoNome) {
    var nome = novoNome.trim();
    if (nome.isEmpty) return;
    if (!nome.endsWith('.dart')) nome = '$nome.dart';
    _arquivos[indice] = _arquivos[indice].copiarCom(nome: nome);
    _diagnosticos = analisarCodigo(_arquivos, _textos);
    notifyListeners();
  }

  void carregarExemplo(ExemploPlayground exemplo) {
    _arquivos = List.of(exemplo.arquivos);
    _ativo = 0;
    _resultado = null;
    _diagnosticos = analisarCodigo(_arquivos, _textos);
    notifyListeners();
  }

  void rodar() {
    _debounce?.cancel();
    _resultado = executarCodigo(_arquivos, _textos);
    _diagnosticos = analisarCodigo(_arquivos, _textos);

    final erro = _resultado?.erro;
    if (erro != null && erro.arquivo.isNotEmpty) {
      final i = _arquivos.indexWhere((a) => a.nome == erro.arquivo);
      if (i >= 0) _ativo = i;
    }
    notifyListeners();
  }

  void limparSaida() {
    _resultado = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
