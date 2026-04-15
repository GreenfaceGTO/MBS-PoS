import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:mbspos/service/utils/global_enums.dart';
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
      body: Consumer<MasterProvider>(builder: (context, prov, _) {
        return prov.daftarProduk.isEmpty
            ? const EmptydataElement()
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Column(
                  children: prov.daftarProduk.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.black38, width: 0.3),
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.namaProduk!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  const Text("Kategori : "),
                                  spasi(
                                      mode: OrientationMode.horizontal,
                                      jarak: 4),
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    children: item.kategori!.map((kat) {
                                      return Text(kat);
                                    }).toList(),
                                  ),
                                ],
                              ),
                              spasi(jarak: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text("H. Pokok : "),
                                      spasi(
                                          mode: OrientationMode.horizontal,
                                          jarak: 4),
                                      Text(toRupiah
                                          .format(item.satuan[0].hargaPokok))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("H. Jual : "),
                                      spasi(
                                          mode: OrientationMode.horizontal,
                                          jarak: 4),
                                      Text(toRupiah
                                          .format(item.satuan[0].hargaJual))
                                    ],
                                  )
                                ],
                              ),
                              Text("Stok : ${item.stok}")
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
      }),
    );
  }
}
