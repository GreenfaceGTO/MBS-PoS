import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/providers/produk_provider.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:mbspos/utils/global_enums.dart';
import 'package:provider/provider.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late ProdukProvider provider;
  @override
  void initState() {
    provider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.getAllProduk();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Master Produk"),
        actions: [
          IconButton(
              tooltip: "Import dari file",
              onPressed: () {},
              icon: const Icon(Icons.upload_file_sharp))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/produkform",
              arguments: ArgsModel(formMode: FormMode.input));
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ProdukProvider>(builder: (context, prov, _) {
        return prov.lstProduk.isEmpty ? const EmptydataElement() : Container();
      }),
    );
  }
}
