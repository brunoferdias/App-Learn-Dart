import 'package:flutter/cupertino.dart';

import '../core/i18n/escopo_textos.dart';
import '../core/tema/tema_app.dart';
import '../features/exercicios/presentation/pages/pagina_praticar.dart';
import '../features/glossario/presentation/pages/pagina_glossario.dart';
import '../features/licoes/presentation/pages/pagina_licoes.dart';
import '../features/playground/presentation/pages/pagina_playground.dart';
import '../features/progresso/presentation/pages/pagina_perfil.dart';

class Abas extends StatelessWidget {
  const Abas({super.key});

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;

    return CupertinoTabScaffold(
      key: ValueKey(textos.idioma),
      tabBar: CupertinoTabBar(
        backgroundColor: paleta.superficie.withValues(alpha: 0.94),
        border: Border(top: BorderSide(color: paleta.borda)),
        inactiveColor: paleta.textoSuave,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.book),
            activeIcon: const Icon(CupertinoIcons.book_fill),
            label: textos.abaAprender,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.checkmark_shield),
            activeIcon: const Icon(CupertinoIcons.checkmark_shield_fill),
            label: textos.abaPraticar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.chevron_left_slash_chevron_right),
            label: textos.abaEditor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.book_circle),
            activeIcon: const Icon(CupertinoIcons.book_circle_fill),
            label: textos.abaSintaxe,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.chart_bar),
            activeIcon: const Icon(CupertinoIcons.chart_bar_fill),
            label: textos.abaProgresso,
          ),
        ],
      ),
      tabBuilder: (context, indice) => CupertinoTabView(
        builder: (context) => switch (indice) {
          0 => const PaginaLicoes(),
          1 => const PaginaPraticar(),
          2 => const PaginaPlayground(),
          3 => const PaginaGlossario(),
          _ => const PaginaPerfil(),
        },
      ),
    );
  }
}
