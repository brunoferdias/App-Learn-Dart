abstract interface class ProgressoLocalDatasource {
  Future<Map<String, dynamic>> ler();
  Future<void> escrever(Map<String, dynamic> dados);
}

class ProgressoEmMemoria implements ProgressoLocalDatasource {
  Map<String, dynamic> _dados = <String, dynamic>{};

  @override
  Future<Map<String, dynamic>> ler() async => _dados;

  @override
  Future<void> escrever(Map<String, dynamic> dados) async {
    _dados = dados;
  }
}
