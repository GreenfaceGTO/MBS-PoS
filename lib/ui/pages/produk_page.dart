import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:mbspos/service/utils/global_enums.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Master Produk"),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
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
            ];
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/produkform",
              arguments: ArgsModel(formMode: FormMode.input));
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<MasterProvider>(builder: (context, prov, _) {
        return prov.daftarProduk.isEmpty
            ? const EmptydataElement()
            : ProdukElement(prov: prov);
      }),
    );
  }
}
