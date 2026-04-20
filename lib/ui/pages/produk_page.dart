import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:mbspos/ui/widgets/components/customsearchfield.dart';
import 'package:mbspos/ui/widgets/elements/produk_element.dart';
import 'package:provider/provider.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();
    return Consumer<MasterProvider>(builder: (context, prov, _) {
      return PopScope(
        onPopInvokedWithResult: (bool didPop, result) {
          if (!didPop) {
            setState(() {
              txtSearch.text = '';
            });
            prov.searchProduk('');
            prov.onSearchModeChange();
          }
        },
        canPop: !prov.produkSearchMode,
        child: Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading: !prov.produkSearchMode,
              title: prov.produkSearchMode
                  ? Customsearchfield(
                      autoFocus: true,
                      hintText: "Cari",
                      textController: txtSearch,
                      onChange: prov.searchProduk,
                      onClear: () {
                        setState(() {
                          txtSearch.text = '';
                        });
                        prov.searchProduk('');
                      })
                  : const Text("Data Master Produk"),
              actions: [if (!prov.produkSearchMode) _popMenu(prov)],
            ),
            floatingActionButton: prov.produkSearchMode
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/produkform",
                          arguments: ArgsModel(formMode: FormMode.input));
                    },
                    child: const Icon(Icons.add),
                  ),
            body: const ProdukElement()),
      );
    });
  }

  void onPopupMenuSelect(MasterProvider prov, String value) {
    switch (value) {
      // TODO : Lengkapi fitur lainnya
      case "/import":
        break;
      case "/export":
        break;
      case "/search":
        prov.onSearchModeChange();
        break;
    }
  }

  PopupMenuButton<String> _popMenu(MasterProvider prov) {
    return PopupMenuButton<String>(onSelected: (val) {
      onPopupMenuSelect(prov, val);
    }, itemBuilder: (context) {
      return const [
        PopupMenuItem(
            value: "/import",
            child: ListTile(
              leading: Icon(
                Icons.download_sharp,
                size: 18,
              ),
              title: Text("Import File"),
            )),
        PopupMenuItem(
            value: "/export",
            child: ListTile(
              leading: Icon(
                Icons.file_upload,
                size: 18,
              ),
              title: Text("Export File"),
            )),
        PopupMenuDivider(),
        PopupMenuItem(
            value: "/search",
            child: ListTile(
              leading: Icon(
                Icons.search,
                size: 18,
              ),
              title: Text("Pencarian"),
            )),
      ];
    });
  }
}
