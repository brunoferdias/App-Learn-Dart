import '../../../../core/i18n/idioma.dart';

abstract class MensagensDart {
  const MensagensDart();

  static MensagensDart de(Idioma idioma) => switch (idioma) {
    Idioma.portugues => const MensagensPt(),
    Idioma.ingles => const MensagensEn(),
  };

  String get comentarioNaoFechado;
  String get comentarioNaoFechadoDica;
  String get textoNaoFechado;
  String textoNaoFechadoDica(String aspas);
  String get textoQuebraLinha;
  String get textoQuebraLinhaDica;
  String caractereInesperado(String c);
  String get caractereInesperadoDica;

  String get fimDoArquivo;
  String get umTexto;
  String esperava(String lexema, String encontrado);
  String get importPrecisaCaminho;
  String get esperavaNomeClasse;
  String get herancaNaoSuportada;
  String get herancaNaoSuportadaDica;
  String get esperavaMembroClasse;
  String get asyncNaoSuportado;
  String get asyncNaoSuportadoDica;
  String get esperavaCorpoFuncao;
  String get esperavaCorpoFuncaoDica;
  String get switchSoCaseDefault;
  String get tryPrecisaCatchFinally;
  String get thisSoEmConstrutor;
  String get esperavaNomeParametro;
  String get naoDaParaAtribuir;
  String get esperavaTipoAposIs;
  String get esperavaMembroAposPonto;
  String naoEntendi(String oQue);
  String get naoEntendiDica;

  String get semMain;
  String get semMainDica;
  String muitasLinhas(int maximo);
  String get muitasLinhasDica;
  String get rodandoDemais;
  String get rodandoDemaisDica;
  String get forInNull;
  String get forInNullDica;
  String get forInSoColecoes;
  String condicaoPrecisaBool(String valor);
  String get condicaoPrecisaBoolDica;
  String naoAceitaNull(String nome, String tipo);
  String naoAceitaNullDica(String tipo);
  String tipoIncompativel(String nome, String tipo, String recebido);
  String get tipoIncompativelDica;
  String variavelNaoDefinida(String nome);
  String variavelNaoDefinidaDica(String nome);
  String get thisForaDeClasse;
  String get menosSoNumeros;
  String get naoSoBool;
  String get bangEmNull;
  String get bangEmNullDica;
  String operadorSoNumeros(String operador);
  String get espalharNull;
  String get espalharNullDica;
  String get espalharSoListas;
  String get forNaListaPrecisaLista;
  String somarTextoCom(String tipo);
  String get somarTextoComDica;
  String operadorComNull(String op);
  String get operadorComNullDica;
  String operadorSoEntreNumeros(String op, String esquerda, String direita);
  String get divisaoPorZero;
  String get divisaoPorZeroDica;
  String get divisaoInteiraPorZero;
  String get restoPorZero;
  String operadorDesconhecido(String op);
  String get colchetesEmNull;
  String get colchetesEmNullDica;
  String get indiceListaPrecisaInt;
  String rangeErrorLista(int indice, int tamanho);
  String get listaVaziaDica;
  String indicesValidos(int ultimo);
  String get indiceTextoPrecisaInt;
  String rangeErrorTexto(int tamanho);
  String get naoAceitaColchetes;
  String acessoEmNull(String nome);
  String get acessoEmNullDica;
  String classeNaoTem(String classe, String nome);
  String get classeNaoTemDica;
  String chamadaEmNull(String nome);
  String get chamadaEmNullDica;
  String classeNaoTemMetodo(String classe, String metodo);
  String get chamouAlgoNulo;
  String get chamouAlgoNuloDica;
  String get naoEhFuncao;
  String poucosArgumentos(String contexto, int esperados, int recebidos);
  String get poucosArgumentosDica;
  String muitosArgumentos(String contexto, int recebidos, int esperados);
  String faltouArgumentoNomeado(String nome, String contexto);
  String faltouArgumentoNomeadoDica(String contexto, String nome);
  String semParametroChamado(String contexto, String nome);
  String construtorSemArgumentos(String classe);
  String variavelNaoDeclarada(String nome);
  String variavelNaoDeclaradaDica(String nome);
  String variavelFinalJaTemValor(String nome);
  String get variavelFinalDica;
  String naoDaParaAlterar(String nome);
  String rangeErrorAtribuicao(int tamanho);
  String get naoAceitaAtribuicaoColchetes;
  String get naoDaParaAtribuirValor;

  String get listaVaziaFirst;
  String get listaVaziaFirstDica;
  String get listaVaziaLast;
  String get conjuntoVazio;
  String tipoNaoTemMetodo(String tipo, String nome);
  String get tipoNaoTemMetodoDica;
  String intParseFalhou(String texto);
  String get intParseFalhouDica;
  String doubleParseFalhou(String texto);
  String get numParseFalhou;
  String enumNaoTem(String enumerado, String nome);
  String substringForaIntervalo(int tamanho);
  String get reduceListaVazia;
  String get reduceListaVaziaDica;
  String get firstWhereNaoEncontrou;
  String get firstWhereNaoEncontrouDica;
}

class MensagensPt extends MensagensDart {
  const MensagensPt();

  @override
  String get comentarioNaoFechado => 'Comentário /* não foi fechado.';
  @override
  String get comentarioNaoFechadoDica => 'Feche o comentário com */';
  @override
  String get textoNaoFechado => 'Texto não foi fechado.';
  @override
  String textoNaoFechadoDica(String aspas) =>
      'Faltou fechar as aspas ($aspas) desta string.';
  @override
  String get textoQuebraLinha =>
      'Texto de aspas simples não pode quebrar linha.';
  @override
  String get textoQuebraLinhaDica =>
      'Use três aspas para textos de várias linhas.';
  @override
  String caractereInesperado(String c) => 'Caractere inesperado: "$c".';
  @override
  String get caractereInesperadoDica =>
      'Verifique se você digitou algo fora do lugar.';

  @override
  String get fimDoArquivo => 'o fim do arquivo';
  @override
  String get umTexto => 'um texto';
  @override
  String esperava(String lexema, String encontrado) =>
      'Esperava "$lexema" mas encontrei $encontrado.';
  @override
  String get importPrecisaCaminho =>
      'Depois de import vem o nome do arquivo entre aspas.';
  @override
  String get esperavaNomeClasse =>
      'Esperava o nome da classe depois de "class".';
  @override
  String get herancaNaoSuportada =>
      'Herança ainda não é suportada no mini-editor.';
  @override
  String get herancaNaoSuportadaDica =>
      'Por enquanto, escreva classes independentes (sem extends).';
  @override
  String get esperavaMembroClasse =>
      'Esperava o nome de um campo ou método dentro da classe.';
  @override
  String get asyncNaoSuportado => 'async/await ainda não roda no mini-editor.';
  @override
  String get asyncNaoSuportadoDica =>
      'Programação assíncrona precisa de um "event loop". Estude a lição 8 e '
      'teste no DartPad.';
  @override
  String get esperavaCorpoFuncao =>
      'Esperava o corpo da função: { ... } ou => expressão;';
  @override
  String get esperavaCorpoFuncaoDica =>
      'Lembre: depois de => vai UMA expressão, sem chaves e sem return.';
  @override
  String get switchSoCaseDefault =>
      'Dentro de switch só cabem "case" e "default".';
  @override
  String get tryPrecisaCatchFinally => 'Um try precisa de catch ou finally.';
  @override
  String get thisSoEmConstrutor =>
      '"this." em parâmetro só vale dentro de um construtor.';
  @override
  String get esperavaNomeParametro => 'Esperava o nome de um parâmetro.';
  @override
  String get naoDaParaAtribuir => 'Não dá para atribuir valor a isto.';
  @override
  String get esperavaTipoAposIs => 'Esperava um nome de tipo depois de "is".';
  @override
  String get esperavaMembroAposPonto =>
      'Esperava o nome de um membro depois do ponto.';
  @override
  String naoEntendi(String oQue) => 'Não entendi $oQue aqui.';
  @override
  String get naoEntendiDica =>
      'Esperava um valor, um nome de variável ou uma expressão.';

  @override
  String get semMain => 'Não encontrei a função main().';
  @override
  String get semMainDica =>
      'Todo programa Dart começa por: void main() { ... }';
  @override
  String muitasLinhas(int maximo) =>
      'Seu código imprimiu mais de $maximo linhas.';
  @override
  String get muitasLinhasDica =>
      'Isso costuma indicar um laço que não termina.';
  @override
  String get rodandoDemais => 'Seu código está rodando há tempo demais.';
  @override
  String get rodandoDemaisDica =>
      'Isso quase sempre é um laço infinito: confira a condição de parada do '
      'seu while ou for.';
  @override
  String get forInNull => 'Não dá para percorrer null com for-in.';
  @override
  String get forInNullDica =>
      'Confira se a lista foi inicializada, ou use `?? []`.';
  @override
  String get forInSoColecoes =>
      'Só dá para percorrer listas, conjuntos e mapas.';
  @override
  String condicaoPrecisaBool(String valor) =>
      'A condição precisa ser true ou false, mas veio $valor.';
  @override
  String get condicaoPrecisaBoolDica =>
      'Em Dart não existe "valor verdadeiro": escreva a comparação completa, '
      'como `texto.isNotEmpty` ou `n > 0`.';
  @override
  String naoAceitaNull(String nome, String tipo) =>
      'Não dá para colocar null em "$nome", que é do tipo $tipo.';
  @override
  String naoAceitaNullDica(String tipo) =>
      'Se este valor pode faltar, declare como $tipo? — o ponto de '
      'interrogação é o que autoriza o null.';
  @override
  String tipoIncompativel(String nome, String tipo, String recebido) =>
      'A variável "$nome" é do tipo $tipo, mas recebeu $recebido.';
  @override
  String get tipoIncompativelDica =>
      'Confira o tipo do valor, ou troque a anotação da variável.';
  @override
  String variavelNaoDefinida(String nome) =>
      'A variável "$nome" não foi definida.';
  @override
  String variavelNaoDefinidaDica(String nome) =>
      'Verifique a grafia (Dart diferencia maiúsculas) ou declare antes de '
      'usar: final $nome = ...;';
  @override
  String get thisForaDeClasse =>
      '"this" só existe dentro de um método de classe.';
  @override
  String get menosSoNumeros => 'Só dá para usar "-" em números.';
  @override
  String get naoSoBool => 'Só dá para usar "!" em um bool.';
  @override
  String get bangEmNull => 'Null check operator used on a null value.';
  @override
  String get bangEmNullDica =>
      'O "!" promete que o valor não é nulo — e ele era. Troque por `?.` com '
      '`??`, ou verifique com if (x != null).';
  @override
  String operadorSoNumeros(String operador) =>
      'Só dá para usar $operador em números.';
  @override
  String get espalharNull => 'Não dá para espalhar (...) um valor nulo.';
  @override
  String get espalharNullDica =>
      'Use ...? para ignorar quando a lista for null.';
  @override
  String get espalharSoListas => 'Só dá para espalhar listas e conjuntos.';
  @override
  String get forNaListaPrecisaLista =>
      'O for dentro da lista precisa de uma lista.';
  @override
  String somarTextoCom(String tipo) => 'Não dá para somar texto com $tipo.';
  @override
  String get somarTextoComDica =>
      'Use interpolação: \'texto \$valor\' — ou converta com .toString().';
  @override
  String operadorComNull(String op) =>
      'Não dá para usar "$op" com um valor nulo.';
  @override
  String get operadorComNullDica =>
      'Trate o null antes, com ?? ou com if (x != null).';
  @override
  String operadorSoEntreNumeros(String op, String esquerda, String direita) =>
      'O operador "$op" só funciona entre números aqui '
      '(recebeu $esquerda e $direita).';
  @override
  String get divisaoPorZero => 'Divisão por zero.';
  @override
  String get divisaoPorZeroDica => 'Confira o divisor antes de dividir.';
  @override
  String get divisaoInteiraPorZero => 'Divisão inteira por zero.';
  @override
  String get restoPorZero => 'Resto de divisão por zero.';
  @override
  String operadorDesconhecido(String op) => 'Operador desconhecido: "$op".';
  @override
  String get colchetesEmNull => 'Não dá para usar [] em um valor nulo.';
  @override
  String get colchetesEmNullDica =>
      'Verifique se a lista ou o mapa foi criado antes de usar.';
  @override
  String get indiceListaPrecisaInt => 'O índice de uma lista precisa ser int.';
  @override
  String rangeErrorLista(int indice, int tamanho) =>
      'RangeError: índice $indice inválido — a lista tem $tamanho itens.';
  @override
  String get listaVaziaDica => 'A lista está vazia.';
  @override
  String indicesValidos(int ultimo) => 'Índices válidos vão de 0 a $ultimo.';
  @override
  String get indiceTextoPrecisaInt => 'O índice de um texto precisa ser int.';
  @override
  String rangeErrorTexto(int tamanho) =>
      'RangeError: o texto tem $tamanho caracteres.';
  @override
  String get naoAceitaColchetes => 'Este valor não aceita [].';
  @override
  String acessoEmNull(String nome) =>
      'Você tentou acessar "$nome" em um valor nulo.';
  @override
  String get acessoEmNullDica =>
      'Use `?.` para acesso seguro, ou trate o null com if antes.';
  @override
  String classeNaoTem(String classe, String nome) =>
      'A classe $classe não tem "$nome".';
  @override
  String get classeNaoTemDica => 'Confira o nome do campo ou método.';
  @override
  String chamadaEmNull(String nome) =>
      'Você chamou "$nome()" em um valor nulo.';
  @override
  String get chamadaEmNullDica =>
      'Use `?.` para chamar só quando não for nulo.';
  @override
  String classeNaoTemMetodo(String classe, String metodo) =>
      'A classe $classe não tem o método "$metodo".';
  @override
  String get chamouAlgoNulo => 'Você tentou chamar algo que é nulo.';
  @override
  String get chamouAlgoNuloDica => 'A função existe? Confira o nome.';
  @override
  String get naoEhFuncao => 'Isto não é uma função e não pode ser chamado.';
  @override
  String poucosArgumentos(String contexto, int esperados, int recebidos) =>
      '$contexto precisa de $esperados argumento(s), mas recebeu $recebidos.';
  @override
  String get poucosArgumentosDica => 'Confira a assinatura da função.';
  @override
  String muitosArgumentos(String contexto, int recebidos, int esperados) =>
      '$contexto recebeu argumentos demais ($recebidos para $esperados).';
  @override
  String faltouArgumentoNomeado(String nome, String contexto) =>
      'Faltou o argumento obrigatório "$nome" em $contexto.';
  @override
  String faltouArgumentoNomeadoDica(String contexto, String nome) =>
      'Parâmetros marcados com `required` precisam ser passados: '
      '$contexto($nome: ...).';
  @override
  String semParametroChamado(String contexto, String nome) =>
      '$contexto não tem um parâmetro chamado "$nome".';
  @override
  String construtorSemArgumentos(String classe) =>
      'A classe $classe não tem construtor com argumentos.';
  @override
  String variavelNaoDeclarada(String nome) =>
      'A variável "$nome" não foi declarada.';
  @override
  String variavelNaoDeclaradaDica(String nome) =>
      'Declare antes de usar: var $nome = ...;';
  @override
  String variavelFinalJaTemValor(String nome) =>
      'A variável "$nome" é final e já tem valor.';
  @override
  String get variavelFinalDica =>
      'Uma variável `final` recebe valor uma única vez. Se ela precisa mudar, '
      'declare com `var`.';
  @override
  String naoDaParaAlterar(String nome) =>
      'Não dá para alterar "$nome" neste valor.';
  @override
  String rangeErrorAtribuicao(int tamanho) =>
      'RangeError: índice inválido para uma lista de $tamanho itens.';
  @override
  String get naoAceitaAtribuicaoColchetes =>
      'Este valor não aceita atribuição por [].';
  @override
  String get naoDaParaAtribuirValor => 'Não dá para atribuir valor a isto.';

  @override
  String get listaVaziaFirst => 'A lista está vazia: não existe "first".';
  @override
  String get listaVaziaFirstDica =>
      'Confira com isNotEmpty antes, ou use firstOrNull.';
  @override
  String get listaVaziaLast => 'A lista está vazia: não existe "last".';
  @override
  String get conjuntoVazio => 'O conjunto está vazio.';
  @override
  String tipoNaoTemMetodo(String tipo, String nome) =>
      'O tipo $tipo não tem o método "$nome".';
  @override
  String get tipoNaoTemMetodoDica =>
      'Confira a grafia — nomes em Dart diferenciam maiúsculas.';
  @override
  String intParseFalhou(String texto) =>
      'int.parse não conseguiu ler "$texto" como número inteiro.';
  @override
  String get intParseFalhouDica =>
      'Use int.tryParse para receber null em vez de um erro.';
  @override
  String doubleParseFalhou(String texto) =>
      'double.parse não conseguiu ler "$texto".';
  @override
  String get numParseFalhou => 'num.parse falhou.';
  @override
  String enumNaoTem(String enumerado, String nome) =>
      '$enumerado não tem "$nome" no mini-editor.';
  @override
  String substringForaIntervalo(int tamanho) =>
      'substring fora do intervalo: o texto tem $tamanho caracteres.';
  @override
  String get reduceListaVazia => 'reduce não funciona em lista vazia.';
  @override
  String get reduceListaVaziaDica => 'Use fold, que aceita um valor inicial.';
  @override
  String get firstWhereNaoEncontrou =>
      'firstWhere não encontrou nenhum elemento.';
  @override
  String get firstWhereNaoEncontrouDica =>
      'Passe orElse: () => ..., ou use where(...).firstOrNull.';
}

class MensagensEn extends MensagensDart {
  const MensagensEn();

  @override
  String get comentarioNaoFechado => 'The /* comment was never closed.';
  @override
  String get comentarioNaoFechadoDica => 'Close the comment with */';
  @override
  String get textoNaoFechado => 'The string was never closed.';
  @override
  String textoNaoFechadoDica(String aspas) =>
      'You forgot the closing quote ($aspas) on this string.';
  @override
  String get textoQuebraLinha =>
      'A single-quoted string cannot span several lines.';
  @override
  String get textoQuebraLinhaDica =>
      'Use triple quotes for multi-line strings.';
  @override
  String caractereInesperado(String c) => 'Unexpected character: "$c".';
  @override
  String get caractereInesperadoDica =>
      'Check whether you typed something out of place.';

  @override
  String get fimDoArquivo => 'the end of the file';
  @override
  String get umTexto => 'a string';
  @override
  String esperava(String lexema, String encontrado) =>
      'Expected "$lexema" but found $encontrado.';
  @override
  String get importPrecisaCaminho =>
      'After import comes the file name in quotes.';
  @override
  String get esperavaNomeClasse => 'Expected the class name after "class".';
  @override
  String get herancaNaoSuportada =>
      'Inheritance is not supported in the mini-editor yet.';
  @override
  String get herancaNaoSuportadaDica =>
      'For now, write standalone classes (no extends).';
  @override
  String get esperavaMembroClasse =>
      'Expected the name of a field or method inside the class.';
  @override
  String get asyncNaoSuportado =>
      'async/await does not run in the mini-editor yet.';
  @override
  String get asyncNaoSuportadoDica =>
      'Asynchronous code needs an "event loop". Study lesson 8 and try it on '
      'DartPad.';
  @override
  String get esperavaCorpoFuncao =>
      'Expected the function body: { ... } or => expression;';
  @override
  String get esperavaCorpoFuncaoDica =>
      'Remember: after => comes ONE expression, no braces and no return.';
  @override
  String get switchSoCaseDefault =>
      'Only "case" and "default" fit inside a switch.';
  @override
  String get tryPrecisaCatchFinally => 'A try needs a catch or a finally.';
  @override
  String get thisSoEmConstrutor =>
      '"this." in a parameter only works inside a constructor.';
  @override
  String get esperavaNomeParametro => 'Expected a parameter name.';
  @override
  String get naoDaParaAtribuir => 'You cannot assign a value to this.';
  @override
  String get esperavaTipoAposIs => 'Expected a type name after "is".';
  @override
  String get esperavaMembroAposPonto => 'Expected a member name after the dot.';
  @override
  String naoEntendi(String oQue) => 'I did not understand $oQue here.';
  @override
  String get naoEntendiDica =>
      'Expected a value, a variable name or an expression.';

  @override
  String get semMain => 'I could not find the main() function.';
  @override
  String get semMainDica => 'Every Dart program starts at: void main() { ... }';
  @override
  String muitasLinhas(int maximo) =>
      'Your code printed more than $maximo lines.';
  @override
  String get muitasLinhasDica => 'That usually means a loop that never ends.';
  @override
  String get rodandoDemais => 'Your code has been running for too long.';
  @override
  String get rodandoDemaisDica =>
      'This is almost always an infinite loop: check the stopping condition of '
      'your while or for.';
  @override
  String get forInNull => 'You cannot iterate over null with for-in.';
  @override
  String get forInNullDica =>
      'Check that the list was initialised, or use `?? []`.';
  @override
  String get forInSoColecoes =>
      'You can only iterate over lists, sets and maps.';
  @override
  String condicaoPrecisaBool(String valor) =>
      'The condition has to be true or false, but got $valor.';
  @override
  String get condicaoPrecisaBoolDica =>
      'Dart has no "truthy value": write the full comparison, like '
      '`text.isNotEmpty` or `n > 0`.';
  @override
  String naoAceitaNull(String nome, String tipo) =>
      'You cannot put null in "$nome", which is of type $tipo.';
  @override
  String naoAceitaNullDica(String tipo) =>
      'If this value can be missing, declare it as $tipo? — the question mark '
      'is what allows null.';
  @override
  String tipoIncompativel(String nome, String tipo, String recebido) =>
      'The variable "$nome" is of type $tipo, but got $recebido.';
  @override
  String get tipoIncompativelDica =>
      'Check the type of the value, or change the variable annotation.';
  @override
  String variavelNaoDefinida(String nome) =>
      'The variable "$nome" was never defined.';
  @override
  String variavelNaoDefinidaDica(String nome) =>
      'Check the spelling (Dart is case sensitive) or declare it before use: '
      'final $nome = ...;';
  @override
  String get thisForaDeClasse => '"this" only exists inside a class method.';
  @override
  String get menosSoNumeros => 'You can only use "-" on numbers.';
  @override
  String get naoSoBool => 'You can only use "!" on a bool.';
  @override
  String get bangEmNull => 'Null check operator used on a null value.';
  @override
  String get bangEmNullDica =>
      'The "!" promised the value was not null — and it was. Swap it for `?.` '
      'with `??`, or check with if (x != null).';
  @override
  String operadorSoNumeros(String operador) =>
      'You can only use $operador on numbers.';
  @override
  String get espalharNull => 'You cannot spread (...) a null value.';
  @override
  String get espalharNullDica => 'Use ...? to skip it when the list is null.';
  @override
  String get espalharSoListas => 'You can only spread lists and sets.';
  @override
  String get forNaListaPrecisaLista =>
      'The for inside the list needs a list to walk.';
  @override
  String somarTextoCom(String tipo) => 'You cannot add text to $tipo.';
  @override
  String get somarTextoComDica =>
      'Use interpolation: \'text \$value\' — or convert with .toString().';
  @override
  String operadorComNull(String op) =>
      'You cannot use "$op" with a null value.';
  @override
  String get operadorComNullDica =>
      'Handle the null first, with ?? or with if (x != null).';
  @override
  String operadorSoEntreNumeros(String op, String esquerda, String direita) =>
      'The "$op" operator only works between numbers here '
      '(got $esquerda and $direita).';
  @override
  String get divisaoPorZero => 'Division by zero.';
  @override
  String get divisaoPorZeroDica => 'Check the divisor before dividing.';
  @override
  String get divisaoInteiraPorZero => 'Integer division by zero.';
  @override
  String get restoPorZero => 'Remainder of a division by zero.';
  @override
  String operadorDesconhecido(String op) => 'Unknown operator: "$op".';
  @override
  String get colchetesEmNull => 'You cannot use [] on a null value.';
  @override
  String get colchetesEmNullDica =>
      'Check that the list or map was created before use.';
  @override
  String get indiceListaPrecisaInt => 'A list index has to be an int.';
  @override
  String rangeErrorLista(int indice, int tamanho) =>
      'RangeError: invalid index $indice — the list has $tamanho items.';
  @override
  String get listaVaziaDica => 'The list is empty.';
  @override
  String indicesValidos(int ultimo) => 'Valid indexes run from 0 to $ultimo.';
  @override
  String get indiceTextoPrecisaInt => 'A string index has to be an int.';
  @override
  String rangeErrorTexto(int tamanho) =>
      'RangeError: the string has $tamanho characters.';
  @override
  String get naoAceitaColchetes => 'This value does not accept [].';
  @override
  String acessoEmNull(String nome) =>
      'You tried to access "$nome" on a null value.';
  @override
  String get acessoEmNullDica =>
      'Use `?.` for safe access, or handle the null with an if first.';
  @override
  String classeNaoTem(String classe, String nome) =>
      'The class $classe has no "$nome".';
  @override
  String get classeNaoTemDica => 'Check the field or method name.';
  @override
  String chamadaEmNull(String nome) => 'You called "$nome()" on a null value.';
  @override
  String get chamadaEmNullDica =>
      'Use `?.` to call it only when it is not null.';
  @override
  String classeNaoTemMetodo(String classe, String metodo) =>
      'The class $classe has no method "$metodo".';
  @override
  String get chamouAlgoNulo => 'You tried to call something that is null.';
  @override
  String get chamouAlgoNuloDica => 'Does the function exist? Check the name.';
  @override
  String get naoEhFuncao => 'This is not a function and cannot be called.';
  @override
  String poucosArgumentos(String contexto, int esperados, int recebidos) =>
      '$contexto needs $esperados argument(s), but got $recebidos.';
  @override
  String get poucosArgumentosDica => 'Check the function signature.';
  @override
  String muitosArgumentos(String contexto, int recebidos, int esperados) =>
      '$contexto got too many arguments ($recebidos for $esperados).';
  @override
  String faltouArgumentoNomeado(String nome, String contexto) =>
      'The required argument "$nome" is missing in $contexto.';
  @override
  String faltouArgumentoNomeadoDica(String contexto, String nome) =>
      'Parameters marked `required` have to be passed: $contexto($nome: ...).';
  @override
  String semParametroChamado(String contexto, String nome) =>
      '$contexto has no parameter called "$nome".';
  @override
  String construtorSemArgumentos(String classe) =>
      'The class $classe has no constructor taking arguments.';
  @override
  String variavelNaoDeclarada(String nome) =>
      'The variable "$nome" was never declared.';
  @override
  String variavelNaoDeclaradaDica(String nome) =>
      'Declare it before use: var $nome = ...;';
  @override
  String variavelFinalJaTemValor(String nome) =>
      'The variable "$nome" is final and already has a value.';
  @override
  String get variavelFinalDica =>
      'A `final` variable takes a value exactly once. If it needs to change, '
      'declare it with `var`.';
  @override
  String naoDaParaAlterar(String nome) =>
      'You cannot change "$nome" on this value.';
  @override
  String rangeErrorAtribuicao(int tamanho) =>
      'RangeError: invalid index for a list of $tamanho items.';
  @override
  String get naoAceitaAtribuicaoColchetes =>
      'This value does not accept assignment through [].';
  @override
  String get naoDaParaAtribuirValor => 'You cannot assign a value to this.';

  @override
  String get listaVaziaFirst => 'The list is empty: there is no "first".';
  @override
  String get listaVaziaFirstDica =>
      'Check with isNotEmpty first, or use firstOrNull.';
  @override
  String get listaVaziaLast => 'The list is empty: there is no "last".';
  @override
  String get conjuntoVazio => 'The set is empty.';
  @override
  String tipoNaoTemMetodo(String tipo, String nome) =>
      'The type $tipo has no method "$nome".';
  @override
  String get tipoNaoTemMetodoDica =>
      'Check the spelling — names in Dart are case sensitive.';
  @override
  String intParseFalhou(String texto) =>
      'int.parse could not read "$texto" as a whole number.';
  @override
  String get intParseFalhouDica =>
      'Use int.tryParse to get null instead of an error.';
  @override
  String doubleParseFalhou(String texto) =>
      'double.parse could not read "$texto".';
  @override
  String get numParseFalhou => 'num.parse failed.';
  @override
  String enumNaoTem(String enumerado, String nome) =>
      '$enumerado has no "$nome" in the mini-editor.';
  @override
  String substringForaIntervalo(int tamanho) =>
      'substring out of range: the string has $tamanho characters.';
  @override
  String get reduceListaVazia => 'reduce does not work on an empty list.';
  @override
  String get reduceListaVaziaDica => 'Use fold, which takes an initial value.';
  @override
  String get firstWhereNaoEncontrou => 'firstWhere found no element.';
  @override
  String get firstWhereNaoEncontrouDica =>
      'Pass orElse: () => ..., or use where(...).firstOrNull.';
}
