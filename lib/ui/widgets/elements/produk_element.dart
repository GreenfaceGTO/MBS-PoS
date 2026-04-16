import 'package:flutter/material.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/ui/pages/form/dialog_helper.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:provider/provider.dart';

class ProdukElement extends StatefulWidget {
  const ProdukElement({super.key, required this.prov});
  final MasterProvider prov;

  @override
  State<ProdukElement> createState() => _ProdukElementState();
}

class _ProdukElementState extends State<ProdukElement> {
  void onDeleteItem(ItemModel item) async {
    bool? confirmed = await DialogHelper.confirmDelete(context,
        content:
            "Yakin ingin menghapus produk ${item.namaProduk!.trim()} ini?");
    if (confirmed != null && confirmed) {
      if (mounted) {
        context.read<MasterProvider>().deleteProduk(item.id!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: TextFormField(
            decoration: const InputDecoration(label: Text("Cari...")),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Column(
              children: widget.prov.daftarProduk.map((item) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Material(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.black38, width: 0.3),
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.namaProduk!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              if (item.merek != null)
                                Text('Merek : ${item.merek}'),
                              Row(
                                children: [
                                  const Text("Kategori : "),
                                  Expanded(
                                      child: Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: item.kategori!.map((kat) {
                                      return Text(kat);
                                    }).toList(),
                                  ))
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(TextSpan(
                                            text: "H. Pokok : ",
                                            children: [
                                              TextSpan(
                                                  text: toRupiah.format(item
                                                      .satuan[0].hargaPokok),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ])),
                                        Text.rich(TextSpan(
                                            text: "H. Jual : ",
                                            children: [
                                              TextSpan(
                                                  text: toRupiah.format(
                                                      item.satuan[0].hargaJual),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ])),
                                        Text.rich(TextSpan(
                                            text: "Satuan : ",
                                            children: [
                                              TextSpan(
                                                  text: item.satuan[0].satuan,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ])),
                                        Text.rich(TextSpan(
                                            text: "Status : ",
                                            children: [
                                              TextSpan(
                                                  text: item.aktif == 1
                                                      ? "Aktif"
                                                      : "Discontinue",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: item.aktif == 1
                                                          ? Colors.teal
                                                          : Colors.red))
                                            ]))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 50),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black38, width: 0.3),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Stok"),
                                        spasi(jarak: 4),
                                        Text(
                                          item.stok.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  const Text("Satuan Lainnya : "),
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: item.satuan.skip(1).map((sat) {
                                      return Text(
                                        "[${sat.satuan!} isi ${sat.isi}]",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      );
                                    }).toList(),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    _popupMenu(item)
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _onPopupMenuSelected(String val, {required ItemModel item}) async {
    switch (val) {
      case "/hapus":
        onDeleteItem(item);
        break;
      case "/edit":
        break;

      default:
    }
  }

  Widget _popupMenu(ItemModel item) {
    return Positioned(
        right: 0,
        child: PopupMenuButton(onSelected: (val) {
          _onPopupMenuSelected(val, item: item);
        }, itemBuilder: (context) {
          return const [
            PopupMenuItem(
                value: "/edit",
                child: ListTile(
                  leading: Icon(
                    Icons.edit_document,
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
        }));
  }
}
