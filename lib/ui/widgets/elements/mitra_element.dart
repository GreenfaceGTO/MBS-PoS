import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:mbspos/service/utils/extension.dart';
import 'package:provider/provider.dart';

class MitraRefWidget extends StatefulWidget {
  const MitraRefWidget({super.key});

  @override
  State<MitraRefWidget> createState() => _MitraRefWidgetState();
}

class _MitraRefWidgetState extends State<MitraRefWidget> {
  void onButtonEditTapped(MitraModel mitra) {
    final duplData = mitra.copyWith();
    Navigator.pushNamed(context, '/mitraform',
        arguments: ArgsModel(
            formMode: FormMode.update,
            tipe: context.read<MasterProvider>().selectedRef,
            data: duplData));
  }

  void deleteConfirm(MitraModel mitra) async {
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
      if (mounted) {
        context.read<MasterProvider>().delMitra(mitra);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MasterProvider>();
    return Expanded(
        child: prov.tabIndex == 3
            ? _supplierWidget(prov)
            : _pelangganWidget(prov));
  }

  SizedBox _pelangganWidget(MasterProvider prov) {
    return SizedBox(
      child: prov.daftarPelanggan.isEmpty
          ? EmptydataElement(
              caption: "Belum ada data ${prov.selectedRef}",
            )
          : ListView.separated(
              itemBuilder: (context, idx) {
                MitraModel data = prov.daftarPelanggan[idx];
                return ListTile(
                  title: Text(data.nama!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _detailMitra(data),
                  ),
                  trailing: PopupMenuButton(onSelected: (val) {
                    if (val == "/hapus") {
                      // log(data.toMap().toString());
                      deleteConfirm(data);
                    } else {
                      onButtonEditTapped(data);
                    }
                  }, itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                          value: "/edit",
                          child: ListTile(
                            leading: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            title: Text("Edit"),
                          )),
                      PopupMenuItem(
                          value: "/hapus",
                          child: ListTile(
                            leading: Icon(
                              Icons.delete_forever,
                              size: 18,
                            ),
                            title: Text("Hapus"),
                          )),
                    ];
                  }),
                );
              },
              separatorBuilder: (context, idx) {
                return const Divider();
              },
              itemCount: prov.daftarPelanggan.length),
    );
  }

  SizedBox _supplierWidget(MasterProvider prov) {
    return SizedBox(
      child: prov.daftarSupplier.isEmpty
          ? EmptydataElement(
              caption: "Belum ada data ${prov.selectedRef}",
            )
          : ListView.separated(
              itemBuilder: (context, idx) {
                MitraModel data = prov.daftarSupplier[idx];
                return ListTile(
                  title: Text(data.nama!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _detailMitra(data),
                  ),
                  trailing: PopupMenuButton(onSelected: (val) {
                    if (val == "/hapus") {
                      // log(data.toMap().toString());
                      deleteConfirm(data);
                    } else {
                      onButtonEditTapped(data);
                    }
                  }, itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                          value: "/edit",
                          child: ListTile(
                            leading: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            title: Text("Edit"),
                          )),
                      PopupMenuItem(
                          value: "/hapus",
                          child: ListTile(
                            leading: Icon(
                              Icons.delete_forever,
                              size: 18,
                            ),
                            title: Text("Hapus"),
                          )),
                    ];
                  }),
                );
              },
              separatorBuilder: (context, idx) {
                return const Divider();
              },
              itemCount: prov.daftarSupplier.length),
    );
  }

  List<Widget> _detailMitra(MitraModel data) {
    return [
      spasi(jarak: 4),
      if (data.alamat != null)
        Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 12,
            ),
            spasi(mode: OrientationMode.horizontal, jarak: 4),
            Text(
              data.alamat!,
            ),
          ],
        ),
      if (data.noTelp != null)
        Row(
          children: [
            const Icon(
              Icons.phone,
              size: 12,
            ),
            spasi(jarak: 4, mode: OrientationMode.horizontal),
            Text(data.noTelp!),
          ],
        ),
      if (data.keterangan != null)
        Row(
          children: [
            const Icon(
              Icons.description,
              size: 12,
            ),
            spasi(jarak: 4, mode: OrientationMode.horizontal),
            Text(data.keterangan!),
          ],
        )
    ];
  }
}
