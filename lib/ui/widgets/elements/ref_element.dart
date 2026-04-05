import 'package:flutter/material.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:provider/provider.dart';

class RefWidget extends StatefulWidget {
  const RefWidget({super.key});

  @override
  State<RefWidget> createState() => _RefWidgetState();
}

class _RefWidgetState extends State<RefWidget> {
  // -------------------------------------------------
  /// Menampilkan jendela konfirmasi hapus referensi
  // -------------------------------------------------
  void deleteConfirm(BuildContext context,
      {required String tipe, required String title}) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Konfirmasi"),
            content:
                Text("Yakin $tipe ${title.toUpperCase()} ini akan dihapus?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    context.read<MasterProvider>().deleteRef(tipe, title);
                    Navigator.pop(ctx);
                  },
                  child: const Text("HAPUS")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("BATAL"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MasterProvider>();
    return Expanded(
        child: prov.tabIndex == 0
            ? _satuanWidget(prov)
            : (prov.tabIndex == 1
                ? _kategoriWidget(prov)
                : _merekWidget(prov)));
  }

  SizedBox _satuanWidget(MasterProvider prov) {
    return SizedBox(
      child: prov.daftarSatuan.isEmpty
          ? EmptydataElement(
              caption: "Belum ada data ${prov.selectedRef}",
            )
          : ListView(
              children: prov.daftarSatuan.map((sat) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 10),
                  title: Text(sat),
                  trailing: IconButton(
                      onPressed: () async {
                        deleteConfirm(context, tipe: "satuan", title: sat);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 18,
                      )),
                );
              }).toList(),
            ),
    );
  }

  SizedBox _kategoriWidget(MasterProvider prov) {
    return SizedBox(
      child: prov.daftarKategori.isEmpty
          ? EmptydataElement(
              caption: "Belum ada data ${prov.selectedRef}",
            )
          : ListView(
              children: prov.daftarKategori.map((kat) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 10),
                  title: Text(kat),
                  trailing: IconButton(
                      onPressed: () {
                        deleteConfirm(context, tipe: "kategori", title: kat);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 18,
                      )),
                );
              }).toList(),
            ),
    );
  }

  SizedBox _merekWidget(MasterProvider prov) {
    return SizedBox(
      child: prov.daftarMerek.isEmpty
          ? EmptydataElement(
              caption: "Belum ada data ${prov.selectedRef}",
            )
          : ListView(
              children: prov.daftarMerek.map((merek) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 10),
                  title: Text(merek),
                  trailing: IconButton(
                      onPressed: () {
                        deleteConfirm(context, tipe: 'merek', title: merek);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 18,
                      )),
                );
              }).toList(),
            ),
    );
  }
}
