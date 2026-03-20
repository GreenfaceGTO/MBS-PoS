import 'package:flutter/material.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/ui/widgets/elements/drawerheader_element.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  @override
  Widget build(BuildContext context) {
    TextTheme tema = TextTheme.of(context);
    List<String> lstMaster = [
      'Ref. Satuan',
      "Ref. Kategori",
      "Ref. Merek",
      "Ref. Supplier",
      "Ref. Pelanggan",
      "Produk"
    ];
    List<String> lstPembelian = [
      "Saran Order",
      "Pesanan Pembelian",
      "Pembelian"
    ];

    List<String> lstPenjualan = ["Pesanan Penjualan", "Penjualan Kredit"];
    return Drawer(
        child: Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: DrawerHeader(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [appLogo(width: 150), const DrawerheaderElement()],
          )),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Master Data"),
                // trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: lstMaster.map((mst) {
              //     return ListTile(
              //       title: Text(mst),
              //     );
              //   }).toList(),
              // ),
              const Divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: lstPembelian.map((pbl) {
                  return ListTile(
                    title: Text(pbl),
                  );
                }).toList(),
              ),
              const Divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: lstPenjualan.map((pjl) {
                  return ListTile(
                    title: Text(pjl),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
