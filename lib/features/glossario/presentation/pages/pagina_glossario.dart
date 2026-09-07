import 'package:flutter/cupertino.dart';

import '../../../../app/escopo_app.dart';
import '../../../../core/i18n/escopo_textos.dart';
import '../../../../core/i18n/idioma.dart';
import '../../../../core/tema/cores_app.dart';
import '../../../../core/tema/tema_app.dart';
import '../../../../core/widgets/cartao.dart';
import '../../../../core/widgets/etiqueta.dart';
import '../../domain/entities/item_glossario.dart';

class PaginaGlossario extends StatefulWidget {
  const PaginaGlossario({super.key});

  @override
  State<PaginaGlossario> createState() => _PaginaGlossarioState();
}

class _PaginaGlossarioState extends State<PaginaGlossario> {
  final TextEditingController _busca = TextEditingController();

  List<ItemGlossario> _itens = const [];
  CategoriaGlossario? _categoria;
  Idioma? _idiomaCarregado;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textos = context.textos;
    if (_idiomaCarregado == textos.idioma) return;
    _idiomaCarregado = textos.idioma;
    _carregar();
  }

  @override
  void dispose() {
    _busca.dispose();
    super.dispose();
  }

  Future<void> _carregar() async {
    final resultado = await EscopoApp.de(
      context,
    ).buscarNoGlossario(context.textos, _busca.text);
    if (!mounted) return;
    setState(() => _itens = resultado.valorOuNulo ?? const []);
  }

  List<ItemGlossario> get _visiveis {
    final categoria = _categoria;
    if (categoria == null) return _itens;
    return _itens.where((i) => i.categoria == categoria).toList();
  }

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;
    final textos = context.textos;
    final visiveis = _visiveis;

    return CupertinoPageScaffold(
      backgroundColor: paleta.fundo,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(textos.glossarioTitulo),
              border: null,
              backgroundColor: const Color(0x00000000),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: CupertinoSearchTextField(
                  controller: _busca,
                  placeholder: textos.glossarioBuscaPlaceholder,
                  onChanged: (_) => _carregar(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _Chip(
                      texto: textos.glossarioTudo,
                      ativo: _categoria == null,
                      aoTocar: () => setState(() => _categoria = null),
                    ),
                    for (final c in CategoriaGlossario.values)
                      _Chip(
                        texto: c.rotulo(textos),
                        ativo: _categoria == c,
                        aoTocar: () => setState(() => _categoria = c),
                      ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            if (visiveis.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      textos.glossarioNadaEncontrado(_busca.text),
                      style: TextStyle(color: paleta.textoSuave),
                    ),
                  ),
                ),
              )
            else
              SliverList.separated(
                itemCount: visiveis.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, i) => Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    i == visiveis.length - 1
                        ? 28 + MediaQuery.paddingOf(context).bottom
                        : 0,
                  ),
                  child: _CartaoTermo(item: visiveis[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.texto,
    required this.ativo,
    required this.aoTocar,
  });

  final String texto;
  final bool ativo;
  final VoidCallback aoTocar;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        onPressed: aoTocar,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: ativo ? CoresApp.azulDart : paleta.superficie,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ativo ? CoresApp.azulDart : paleta.borda),
          ),
          child: Text(
            texto,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ativo ? CupertinoColors.white : paleta.textoSuave,
            ),
          ),
        ),
      ),
    );
  }
}

class _CartaoTermo extends StatelessWidget {
  const _CartaoTermo({required this.item});

  final ItemGlossario item;

  @override
  Widget build(BuildContext context) {
    final paleta = context.paleta;

    return Cartao(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.termo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    color: paleta.texto,
                  ),
                ),
              ),
              Etiqueta(
                item.categoria.rotulo(context.textos),
                cor: CoresApp.azulDart,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: paleta.fundoCodigo,
              borderRadius: BorderRadius.circular(9),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                item.sintaxe,
                style: const TextStyle(
                  fontFamily: TemaApp.fonteMono,
                  fontSize: 13,
                  color: CoresApp.synTipo,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.significado,
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: paleta.textoSuave,
            ),
          ),
        ],
      ),
    );
  }
}
