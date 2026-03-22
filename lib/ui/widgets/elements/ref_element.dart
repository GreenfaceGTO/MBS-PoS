import 'package:flutter/material.dart';
import 'package:mbspos/providers/ref_provider.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:provider/provider.dart';

class RefWidget extends StatefulWidget {
  const RefWidget({super.key});

  @override
  State<RefWidget> createState() => _RefWidgetState();
}

class _RefWidgetState extends State<RefWidget> {
  late RefProvider provider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    super.initState();
  }

  // -------------------------------------------------
  /// Menampilkan jendela konfirmasi hapus referensi
  // -------------------------------------------------
  void deleteConfirm({required String title}) async {
    bool? result = await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Konfirmasi"),
            content: Text(
                "Yakin data pendukung ${title.toUpperCase()} ini akan dihapus?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx, true);
                  },
                  child: const Text("HAPUS")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx, false);
                  },
                  child: const Text("BATAL"))
            ],
          );
        });

    if (result != null && result) {
      provider.deleteRef(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        SizedBox(child: Consumer<RefProvider>(builder: (context, prov, _) {
      return prov.lstRef.isEmpty
          ? EmptydataElement(
              caption: "Belum ada data ${prov.selectedRef}",
            )
          : ListView(
              children: prov.lstRef.map((ref) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 10),
                  title: Text(ref),
                  trailing: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        deleteConfirm(title: ref);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 18,
                      )),
                );
              }).toList(),
            );
    })));
  }
}
