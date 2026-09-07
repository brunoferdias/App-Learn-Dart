# 🎯 Aprenda Dart

App educacional em Flutter para aprender a **linguagem Dart** com foco em
**null safety** — e cujo **código-fonte também é material de estudo**.

Todo arquivo tem comentários explicando o recurso da linguagem que ele usa, e o
projeto inteiro segue **Clean Architecture**. O app é **bilíngue**
(português e inglês), funciona **inteiramente offline** e não pede conta.

> **Projeto independente.** Este app **não é um produto oficial do Google** e
> não tem vínculo, patrocínio nem aprovação do Google LLC. Dart, Flutter e seus
> logotipos são marcas do Google LLC, usadas aqui apenas para se referir à
> linguagem e ao framework. A documentação oficial fica em
> [dart.dev](https://dart.dev).

---

## O que tem dentro

| Aba | O que faz |
|-----|-----------|
| **Aprender** | 11 lições com exemplos comentados, saída do console, tabelas de referência e comparações "errado × certo" — incluindo o **Laboratório de Testes** interativo. |
| **Praticar** | 53 exercícios em 3 formatos, todos com explicação após a resposta. |
| **Editor** | Mini-editor de Dart em tela deitada, que **roda seu código de verdade** dentro do app. |
| **Sintaxe** | Glossário buscável com 35 termos, agrupados por categoria. |
| **Progresso** | Estatísticas, seletor de idioma, seletor de tema (Sistema / Claro / Escuro) e explicação da arquitetura. |

Na primeira abertura vem uma **apresentação de 5 passos** — com o exercício e o
editor funcionando de verdade dentro dela — que também é onde o aviso de
projeto independente aparece. Dá para revê-la quando quiser, na aba Progresso.

### As 11 lições

1. 🎯 **Como o Dart funciona** — `main()`, sintaxe básica, JIT × AOT
2. 📦 **Variáveis e tipos** — `var`, `final`, `const`, interpolação
3. 🛡️ **Null Safety** — `?`, `?.`, `??`, `??=`, `!`, `late`, promoção de tipo
4. ⚙️ **Funções de A a Z** — arrow, parâmetros posicionais/opcionais/nomeados,
   anônimas, closures, ordem superior, `typedef`, genéricas
5. 🔀 **Decisões e repetições** — `if`, ternário, laços, switch-expressão
6. 🗂️ **Listas, Sets e Maps** — `map`, `where`, `fold`, collection if/for
7. 🏗️ **Classes e objetos** — construtores, `factory`, getters, `mixin`, `extension`
8. ⏳ **Future, async e await** — `try/catch/finally`, `Stream`, `yield`
9. 💎 **Dart 3** — records, pattern matching, `sealed class`
10. 🧱 **Clean Architecture na prática** — como este app foi construído
11. 🧪 **Testes de widget** — finders, matchers, `pump` × `pumpAndSettle`, e um
    **laboratório interativo**: você monta `expect(finder, matcher)` tocando nas
    peças, roda, e vê quais widgets o finder pegou destacados na tela — com a
    saída real do `flutter test`

### Os 3 formatos de exercício

- **Certo ou errado?** — um trecho de código; você julga se compila e funciona
- **Múltipla escolha** — incluindo "qual é a saída deste código?"
- **Complete a lacuna** — o código tem `___` e você escolhe o que preenche

Toda resposta (certa ou errada) revela a explicação do *porquê*.

---

## O mini-editor (aba Editor)

Um app Flutter já compilado **não consegue compilar Dart em tempo de execução** —
não existe `eval` no AOT. Então o app traz um **mini-interpretador de Dart
escrito em Dart** (~3.600 linhas em `features/playground/data/interpretador/`),
com as quatro etapas clássicas:

```
seu código → lexer → tokens → parser → AST → interpretador → saída
```

**Facilidades do editor:**

- Tela deitada, com código de um lado e console do outro
- `void main()` já preenchido ao abrir
- Indentação automática (Enter mantém o nível, `{` avança, `}` recua)
- Fechamento automático de `( [ { ' "`, e digitar o par existente só avança
- Destaque de sintaxe: fundo escuro, palavras-chave, tipos, textos e números coloridos
- Números de linha alinhados (medidos com `TextPainter`, então batem mesmo com quebra)
- Erros com **linha destacada em vermelho**, mensagem em português e uma **dica de como corrigir**
- Análise ao vivo enquanto você digita (com debounce)
- **Abas de arquivos** que conversam entre si: compartilham o escopo global,
  então o que você declara em uma aba pode usar na outra
- Proteção contra laço infinito e excesso de saída — o app nunca trava

**O que roda:** variáveis e tipos, null safety completo (`?`, `?.`, `??`, `??=`,
`!`, `late`), funções (arrow, nomeadas, opcionais, anônimas, closures, recursão),
`if`/`for`/`while`/`do`/`switch`, `List`/`Set`/`Map` com `map`/`where`/`fold`,
spread e collection `if`/`for`, classes com construtor/métodos/getters/`toString`,
`try`/`catch`/`finally` e `throw`.

**O que ainda não roda:** `async`/`await` e Streams, herança, mixins, extensions,
records, sealed classes e pacotes do pub.dev. A própria tela do app lista isso —
nada de prometer o que não entrega.

O interpretador ainda verifica tipos em tempo de execução, então
`String nome = null;` dá o mesmo erro que daria no Dart real — com a dica de
usar `String?`.

---

## Design

Interface **Cupertino** (iOS) nativa, com tema **claro e escuro** completos.
Seguindo o ajuste do sistema por padrão, ou forçado pelo seletor na aba
Progresso. O destaque de sintaxe Dart foi escrito à mão em ~60 linhas
(`lib/core/widgets/visualizador_codigo.dart`) — sem nenhuma dependência externa.

**O app não usa nenhum pacote além do próprio Flutter.**

---

## Estrutura (Clean Architecture)

```
lib/
├── core/                      # compartilhado por todo o app
│   ├── i18n/                  # Idioma, Textos (pt/en), EscopoTextos
│   ├── preferencias/          # a única porta para o disco
│   ├── tema/                  # cores, tema claro/escuro, ModoTema
│   ├── utils/                 # Resultado<T> — sealed class de sucesso/falha
│   └── widgets/               # Cartao, Etiqueta, VisualizadorCodigo, TextoRico
│
├── features/                  # uma pasta por funcionalidade
│   ├── onboarding/            # splash, boas-vindas e a apresentação
│   ├── licoes/
│   │   ├── domain/            # Licao, BlocoConteudo, contratos, casos de uso
│   │   ├── data/
│   │   │   └── conteudo/      # pt/ e en/ — uma lição por arquivo
│   │   └── presentation/      # controlador + telas + widgets
│   ├── exercicios/
│   ├── playground/            # o mini-editor
│   │   ├── domain/            # ArquivoDart, Diagnostico, ResultadoExecucao
│   │   ├── data/
│   │   │   └── interpretador/ # lexer, parser, AST, interpretador, biblioteca
│   │   └── presentation/      # editor, abas, console
│   ├── glossario/
│   ├── progresso/
│   └── testes/                # o Laboratório de Testes
│       ├── domain/            # NoWidget, FinderSimulado, MatcherSimulado
│       ├── data/              # os 4 cenários
│       └── presentation/      # tela simulada, console, montador
│
├── store/                     # os textos de ASO da ficha da App Store
├── app/                       # injeção, CupertinoApp, portal e abas
└── main.dart
```

### A regra de ouro

```
presentation  ───▶  domain  ◀───  data
```

O `domain` é **Dart puro**: nenhum arquivo dele importa Flutter. É isso que
permite testar a regra de negócio sem subir nenhuma tela — veja
`test/domain/`.

### Sem pacotes de estado ou DI

- Estado: `ChangeNotifier` + `ListenableBuilder` (ambos nativos)
- Injeção: um objeto simples em `lib/app/injecao.dart`, montado à mão
- Acesso: `InheritedWidget` em `lib/app/escopo_app.dart`
- Única dependência de runtime: `shared_preferences`, para lembrar idioma,
  tema e se você já viu a apresentação

### Bilíngue sem pacote de i18n

`lib/core/i18n/textos.dart` é uma **classe abstrata com um getter por frase**, e
cada idioma é uma subclasse. Se alguém acrescentar uma frase e esquecer de
traduzi-la, **o projeto não compila** — o compilador vira a checklist de
tradução, em vez de o erro aparecer com o app na mão do usuário.

A tradução vai até o fim: as lições, os exercícios, o glossário, os cenários do
laboratório e até as mensagens de erro do mini-interpretador
(`data/interpretador/mensagens.dart`) existem nos dois idiomas. O conteúdo mora
em `conteudo/pt/` e `conteudo/en/`, com os mesmos `id` dos dois lados — é isso
que faz o seu progresso sobreviver a uma troca de idioma.

---

## Como rodar

```bash
flutter pub get
flutter run                 # escolha o dispositivo
flutter run -d macos        # ou direto no macOS
flutter run -d chrome       # ou no navegador
```

## Testes

```bash
flutter test
```

157 testes:

- **Domínio**: correção de exercícios, cálculo de progresso, serialização
- **Interpretador** (47): sintaxe, null safety, funções, closures, coleções,
  classes, erros, múltiplos arquivos e os limites de segurança
- **Editor**: indentação automática e fechamento de pares
- **Widget**: abrir lição, responder exercício, buscar no glossário, rodar
  código no editor, e uma verificação de que nenhuma tela estoura a 320px
- **Laboratório de Testes**: o motor de finders/matchers e o fluxo completo
  da tela, inclusive o caminho a partir da lição 11
- **Tradução** (`test/i18n_test.dart`): garante que os dois idiomas têm os
  mesmos ids, as mesmas respostas certas, nenhuma sobra de português dentro do
  conteúdo em inglês, e que até os erros do mini-interpretador mudam de idioma
- **Primeira abertura** (`test/onboarding_test.dart`): splash, boas-vindas,
  os 5 passos, a troca de idioma e o aviso de projeto independente
- **Ficha da loja** (`test/store/aso_test.dart`): mede os textos de ASO contra
  os limites de caracteres do App Store Connect
- `test/aula_widget_test.dart`: 17 testes comentados linha a linha — a versão
  longa da lição 11, feita para ser lida

---

## Por onde começar a ler o código

1. `lib/main.dart` — o ponto de entrada, com um mapa do projeto
2. `lib/app/injecao.dart` — como as peças se conectam
3. `lib/core/i18n/textos.dart` — o contrato de tradução verificado pelo compilador
4. `lib/core/utils/resultado.dart` — sealed class + generics + pattern matching
5. `lib/features/licoes/domain/` — regra de negócio em Dart puro
6. `lib/features/licoes/data/` — de onde vêm os dados
7. `lib/features/licoes/presentation/` — as telas
