import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../pages/pagina_privacidade.dart';

/// O bloco de privacidade do perfil: o caminho para ler a política e o botão
/// que apaga o progresso guardado no aparelho.
class SecaoPrivacidade extends StatelessWidget {
  const SecaoPrivacidade({super.key});

  Future<void> _apagar(BuildContext context) async {
    final textos = context.textos;
    final progresso = EscopoApp.de(context).controladorProgresso;

    final confirmou = await showCupertinoDialog<bool>(
      context: context,
      builder: (dialogo) => CupertinoAlertDialog(
        title: Text(textos.apagarDadosConfirmaTitulo),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(textos.apagarDadosConfirmaTexto),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogo).pop(false),
            child: Text(textos.cancelar),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(dialogo).pop(true),
            child: Text(textos.apagarDadosConfirmaBotao),
          ),
        ],
      ),
    );

    if (confirmou != true || !context.mounted) return;

    final apagou = await progresso.apagarDados();
    if (!context.mounted) return;

    await showCupertinoDialog<void>(
      context: context,
      builder: (dialogo) => CupertinoAlertDialog(
        title: Text(
          apagou
              ? textos.apagarDadosProntoTitulo
              : textos.apagarDadosFalhouTitulo,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            apagou
                ? textos.apagarDadosProntoTexto
                : textos.apagarDadosFalhouTexto,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(dialogo).pop(),
            child: Text(textos.fechar),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Cartao(
          aoTocar: () => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (_) => const PaginaPrivacidade(),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.lock_shield,
                size: 19,
                color: CoresApp.azulDart,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textos.privacidadeCartaoTitulo,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: paleta.texto,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      textos.privacidadeCartaoTexto,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: paleta.textoSuave,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                CupertinoIcons.chevron_forward,
                size: 15,
                color: paleta.textoSuave,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Cartao(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textos.apagarDadosTexto,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: paleta.textoSuave,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  borderRadius: BorderRadius.circular(12),
                  color: CoresApp.erro.withValues(alpha: 0.12),
                  onPressed: () => _apagar(context),
                  child: Text(
                    textos.apagarDadosBotao,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CoresApp.erro,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
