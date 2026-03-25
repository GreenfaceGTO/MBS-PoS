import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/providers/ref_provider.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:mbspos/utils/extension.dart';
import 'package:mbspos/utils/global_enums.dart';
import 'package:provider/provider.dart';

class MitraRefWidget extends StatefulWidget {
  const MitraRefWidget({super.key});

  @override
  State<MitraRefWidget> createState() => _MitraRefWidgetState();
}

class _MitraRefWidgetState extends State<MitraRefWidget> {
  late RefProvider provider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    super.initState();
  }

  void onButtonEditTapped(MitraModel mitra) {
    final duplData = mitra.copyWith();
    Navigator.pushNamed(context, '/mitraform',
        arguments: ArgsModel(
            formMode: FormMode.update,
            tipe: provider.selectedRef,
            data: duplData));
  }

  void onDelete(MitraModel mitra) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (ctx) {
        String tipe = mitra.tipe!.capitalizeFirst();
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: Text(
              "Yakin data $tipe ${mitra.nama!.toUpperCase()} ini akan dihapus?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx, true);
                },
                child: const Text("HAPUS")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("BATAL"))
          ],
        );
      },
    );

    if (confirm != null && confirm) {
      provider.delMitra(mitra.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SizedBox(
      child: Consumer<RefProvider>(builder: (context, prov, _) {
        return prov.lstMitra.isEmpty
            ? EmptydataElement(
                caption: "Belum ada data ${prov.selectedRef}",
              )
            : ListView(
                children: prov.lstMitra.map((mtr) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      shape: const RoundedRectangleBorder(),
                      contentPadding: const EdgeInsets.only(left: 12, right: 8),
                      onTap: () {
                        log(mtr.toMap().toString());
                      },
                      title: Text(mtr.nama!),
                      subtitle: (mtr.alamat == null || mtr.noTelp == null)
                          ? null
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (mtr.alamat != null) Text(mtr.alamat!),
                                if (mtr.noTelp != null) Text(mtr.noTelp!)
                              ],
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                onButtonEditTapped(mtr);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                              )),
                          IconButton(
                              onPressed: () {
                                onDelete(mtr);
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                size: 18,
                              )),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
      }),
    ));
  }
}
