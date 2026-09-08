import '../../../domain/entities/documento_legal.dart';

const DocumentoLegal documentoLegalPt = DocumentoLegal(
  atualizadoEm: '7 de setembro de 2026',
  contato: 'brudiasapp@outlook.com',
  resumo:
      'O Aprenda Dart não coleta, não transmite e não vende nenhum dado seu. '
      'Tudo o que o app guarda fica dentro do seu aparelho, e some quando '
      'você desinstala.',
  partes: [
    ParteLegal(
      titulo: 'Política de Privacidade',
      clausulas: [
        ClausulaLegal(
          numero: 1,
          titulo: 'Que dados o app coleta',
          paragrafos: [
            '**Nenhum.**',
            'O app não pede conta, não pede e-mail, não pede login, não pede '
                'telefone, não pede localização, não acessa contatos, fotos, '
                'câmera, microfone nem agenda. Não há anúncios, não há '
                'rastreadores, não há ferramentas de análise de uso e não há '
                'qualquer identificador de publicidade.',
            'O app não abre conexão de internet por conta própria: todo o '
                'conteúdo — as lições, os exercícios, o glossário e o '
                'interpretador de Dart — já vem embutido e funciona offline.',
          ],
        ),
        ClausulaLegal(
          numero: 2,
          titulo: 'Que informações ficam no seu aparelho',
          paragrafos: [
            'Para o app se lembrar de onde você parou, algumas preferências '
                'são gravadas no armazenamento local do próprio aparelho '
                '(`SharedPreferences`, que no iOS é o `NSUserDefaults`):',
          ],
          itens: [
            'o idioma escolhido (português ou inglês);',
            'o tema escolhido (sistema, claro ou escuro);',
            'se você já viu a apresentação inicial;',
            'seu progresso de estudo: quais lições você marcou como '
                'concluídas e quantas respostas certas e erradas você deu nos '
                'exercícios;',
            'contadores usados para decidir se e quando o app pode perguntar, '
                'uma única vez, se você quer avaliá-lo na App Store.',
          ],
        ),
        ClausulaLegal(
          numero: 3,
          titulo: 'Nada disso identifica você',
          paragrafos: [
            'Não há nome, e-mail, número, apelido nem identificador de '
                'aparelho. São contadores, datas e preferências.',
            'Essas informações **não** são enviadas para nós nem para '
                'ninguém. Não existe servidor do Aprenda Dart, não existe '
                'banco de dados nosso e não existe conta para onde esses '
                'dados pudessem ir.',
          ],
        ),
        ClausulaLegal(
          numero: 4,
          titulo: 'O código que você escreve no editor',
          paragrafos: [
            'O editor de Dart do app roda um interpretador escrito em Dart, '
                'dentro do próprio aplicativo. O código que você digita é '
                'processado apenas na memória do seu aparelho, não é gravado '
                'em servidor nenhum e não é enviado para lugar algum.',
          ],
        ),
        ClausulaLegal(
          numero: 5,
          titulo: 'Backup do aparelho',
          paragrafos: [
            'Se você tiver o backup do iCloud ou o backup local ativado, o '
                'iOS pode incluir as preferências do app (item 2) no backup '
                'do seu aparelho, junto com as de todos os outros apps. Esse '
                'backup é feito pela Apple, sob a política de privacidade da '
                'Apple, e nós não temos acesso a ele. Você controla isso nos '
                'ajustes do seu aparelho.',
          ],
        ),
        ClausulaLegal(
          numero: 6,
          titulo: 'Avaliação na App Store',
          paragrafos: [
            'O app pode, em momentos específicos e no máximo duas vezes, '
                'mostrar a caixa de avaliação padrão do iOS '
                '(`SKStoreReviewController`). Existe também um botão nesta '
                'aba para você avaliar quando quiser.',
            'Essa caixa é da Apple, não nossa: nós não vemos a nota que você '
                'dá, não vemos o que você escreve e não recebemos nenhum dado '
                'por causa dela. Se você tocar no botão e for levado à App '
                'Store, valem a política de privacidade e os termos da Apple.',
          ],
        ),
        ClausulaLegal(
          numero: 7,
          titulo: 'Serviços de terceiros',
          paragrafos: [
            'O app não usa serviços de análise, publicidade, notificação ou '
                'nuvem. Os únicos componentes de terceiros são bibliotecas de '
                'código aberto que rodam localmente e não coletam dados, '
                'entre elas as bibliotecas usadas para gravar preferências no '
                'aparelho e para chamar a caixa de avaliação da Apple.',
          ],
        ),
        ClausulaLegal(
          numero: 8,
          titulo: 'Crianças',
          paragrafos: [
            'Como o app não coleta nenhum dado pessoal de ninguém, ele também '
                'não coleta dados de crianças. Não há chat, não há conteúdo '
                'enviado por usuários, não há compras e não há links de '
                'publicidade.',
          ],
        ),
        ClausulaLegal(
          numero: 9,
          titulo: 'Como apagar seus dados',
          paragrafos: [
            'O botão **Apagar dados salvos**, aqui mesmo nesta aba, remove do '
                'aparelho as lições concluídas e a contagem de acertos e '
                'erros. É imediato e não tem como desfazer.',
            'Desinstalar o app apaga tudo o que foi gravado no aparelho, '
                'inclusive as preferências de idioma e tema. Não há nada em '
                'outro lugar para pedir que seja apagado. Como não guardamos '
                'dado nenhum, não temos como identificar você para atender a '
                'pedidos de acesso, correção ou exclusão — simplesmente não há '
                'o que acessar.',
          ],
        ),
        ClausulaLegal(
          numero: 10,
          titulo: 'Seus direitos (LGPD e GDPR)',
          paragrafos: [
            'A Lei Geral de Proteção de Dados (Lei 13.709/2018) e o GDPR '
                'europeu tratam do tratamento de dados pessoais. Como o '
                'Aprenda Dart não realiza tratamento de dados pessoais — não '
                'coleta, não armazena fora do seu aparelho, não compartilha e '
                'não transfere — não há operação de tratamento sobre a qual '
                'esses direitos possam ser exercidos. Ainda assim, se você '
                'tiver qualquer dúvida, escreva para o contato no topo desta '
                'página.',
          ],
        ),
        ClausulaLegal(
          numero: 11,
          titulo: 'Mudanças nesta política',
          paragrafos: [
            'Se esta política mudar, a data de “última atualização” no topo '
                'muda junto, e a versão nova passa a valer a partir da '
                'publicação. Se alguma mudança futura passar a envolver '
                'coleta de dados, isso será dito aqui de forma clara e '
                'destacada antes de acontecer.',
          ],
        ),
      ],
    ),
    ParteLegal(
      titulo: 'Termos de Uso',
      clausulas: [
        ClausulaLegal(
          numero: 1,
          titulo: 'Aceitação',
          paragrafos: [
            'Ao instalar ou usar o Aprenda Dart, você concorda com estes '
                'Termos. Se não concordar, basta não usar o app e '
                'desinstalá-lo.',
          ],
        ),
        ClausulaLegal(
          numero: 2,
          titulo: 'O que o app é',
          paragrafos: [
            'O Aprenda Dart é um app educacional independente para aprender a '
                'linguagem de programação Dart. Ele é gratuito, funciona '
                'offline, não tem anúncios, não tem compras dentro do app e '
                'não tem assinatura.',
          ],
        ),
        ClausulaLegal(
          numero: 3,
          titulo: 'Projeto independente — sem vínculo com o Google',
          paragrafos: [
            'Este é um projeto de estudo independente. **Não** é um produto '
                'oficial do Google e não tem vínculo, patrocínio, aprovação '
                'nem revisão do Google LLC.',
            'Dart, Flutter e seus logotipos são marcas do Google LLC, usadas '
                'aqui apenas para se referir à linguagem e ao framework, de '
                'forma descritiva. A documentação oficial da linguagem fica '
                'em `dart.dev`.',
          ],
        ),
        ClausulaLegal(
          numero: 4,
          titulo: 'Conteúdo educacional, não consultoria',
          paragrafos: [
            'As lições, exercícios, explicações e exemplos são material de '
                'estudo, escrito com cuidado, mas sem garantia de que estejam '
                'completos, atualizados ou livres de erro. A linguagem Dart '
                'evolui, e a documentação oficial em `dart.dev` sempre tem '
                'precedência sobre o que estiver escrito aqui.',
            'Não use o conteúdo do app como única base para decisões '
                'técnicas, profissionais ou comerciais.',
          ],
        ),
        ClausulaLegal(
          numero: 5,
          titulo: 'O editor e seus limites',
          paragrafos: [
            'O editor do app não é o compilador do Dart. Um aplicativo já '
                'compilado não consegue compilar Dart em tempo de execução, '
                'então o editor traz um interpretador próprio, escrito em '
                'Dart, que roda um subconjunto da linguagem: variáveis, '
                'tipos, null safety, funções, closures, laços, coleções, '
                'classes, `try/catch` e vários arquivos entre si.',
            'Ele não roda `async/await`, herança, mixins nem pacotes '
                'externos. Um código pode, portanto, se comportar de maneira '
                'diferente aqui e no Dart de verdade. Para a linguagem '
                'completa, use o SDK oficial ou o DartPad em `dartpad.dev`.',
          ],
        ),
        ClausulaLegal(
          numero: 6,
          titulo: 'Uso permitido',
          paragrafos: [
            'Você pode usar o app livremente para estudar, inclusive em sala '
                'de aula, e usar os trechos de código dos exemplos nos seus '
                'próprios projetos.',
            'Você não pode: redistribuir o app como se fosse seu, vendê-lo, '
                'remover os avisos de projeto independente, nem usar o nome '
                'ou a identidade visual do app para sugerir vínculo, endosso '
                'ou parceria que não existem.',
          ],
        ),
        ClausulaLegal(
          numero: 7,
          titulo: 'Propriedade intelectual',
          paragrafos: [
            'O texto das lições, dos exercícios e do glossário é de autoria '
                'do desenvolvedor do app. As marcas de terceiros citadas '
                'pertencem a seus respectivos donos.',
          ],
        ),
        ClausulaLegal(
          numero: 8,
          titulo: 'Sem garantias',
          paragrafos: [
            'O app é fornecido “como está”, sem garantia de qualquer tipo, '
                'expressa ou implícita, incluindo garantias de adequação a '
                'uma finalidade específica, de funcionamento ininterrupto ou '
                'de ausência de erros.',
          ],
        ),
        ClausulaLegal(
          numero: 9,
          titulo: 'Limitação de responsabilidade',
          paragrafos: [
            'Na máxima extensão permitida pela lei aplicável, o '
                'desenvolvedor não se responsabiliza por perdas ou danos '
                'diretos, indiretos, incidentais ou consequentes decorrentes '
                'do uso ou da impossibilidade de uso do app, incluindo perda '
                'de dados ou prejuízos ligados a decisões técnicas tomadas '
                'com base no conteúdo educacional.',
          ],
        ),
        ClausulaLegal(
          numero: 10,
          titulo: 'Disponibilidade e mudanças',
          paragrafos: [
            'O app pode ser atualizado, alterado ou descontinuado a qualquer '
                'momento. A distribuição é feita pela App Store, e a '
                'disponibilidade depende também das regras e dos serviços da '
                'Apple.',
          ],
        ),
        ClausulaLegal(
          numero: 11,
          titulo: 'Alterações nestes Termos',
          paragrafos: [
            'Estes Termos podem mudar. A data de “última atualização” no topo '
                'indica a versão vigente. Continuar usando o app depois de '
                'uma mudança significa aceitar a versão nova.',
          ],
        ),
        ClausulaLegal(
          numero: 12,
          titulo: 'Lei aplicável',
          paragrafos: [
            'Estes Termos são regidos pelas leis da República Federativa do '
                'Brasil, e fica eleito o foro do domicílio do usuário para '
                'dirimir eventuais controvérsias.',
          ],
        ),
        ClausulaLegal(
          numero: 13,
          titulo: 'Contato',
          paragrafos: [
            'Dúvidas sobre a privacidade ou sobre estes Termos: escreva para '
                '`brudiasapp@outlook.com`.',
          ],
        ),
      ],
    ),
  ],
);
