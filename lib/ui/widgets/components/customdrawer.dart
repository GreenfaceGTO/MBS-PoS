import 'package:flutter/material.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/ui/widgets/elements/drawerheader_element.dart';
import 'package:mbspos/utils/cachemanager.dart';
import 'package:mbspos/utils/constant.dart';

class Customdrawer extends StatefulWidget with CacheManager {
  Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  bool isMasterExpand = false;
  bool isPembelianExpand = false;
  bool isPenjualanExpand = false;
  bool isPersediaanExpand = false;
  bool isLaporanExpand = false;
  @override
  void initState() {
    isMasterExpand = widget.menuMasterStatus;
    isPembelianExpand = widget.menuPembelianStatus;
    isPenjualanExpand = widget.menuPenjualanStatus;
    isPersediaanExpand = widget.menuPersediaanStatus;
    isLaporanExpand = widget.menuLaporanStatus;

    super.initState();
  }

  void onMasterMenuTap(int menuId) {
    switch (menuId) {
      case 1:
        Navigator.pushNamed(context, '/referensi');
        break;
      case 2:
        Navigator.pushNamed(context, "/produk");
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              // mainAxisSize: MainAxisSize.min,
              children: [
                ExpansionTile(
                  initiallyExpanded: isMasterExpand,
                  onExpansionChanged: widget.onMenuMasterExpandChange,
                  title: const Text("Master Data"),
                  children: lstMaster.map((mst) {
                    return ListTile(
                      onTap: () {
                        onMasterMenuTap(mst.id);
                      },
                      leading: Icon(mst.icon),
                      title: Text(mst.title),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  initiallyExpanded: isPembelianExpand,
                  onExpansionChanged: widget.onMenuPembelianExpandChange,
                  title: const Text("Pembelian"),
                  children: lstPembelian.map((pbl) {
                    return ListTile(
                      leading: Icon(pbl.icon),
                      title: Text(pbl.title),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  initiallyExpanded: isPenjualanExpand,
                  onExpansionChanged: widget.onMenuPenjualanExpandChange,
                  title: const Text("Penjualan"),
                  children: lstPenjualan.map((pjl) {
                    return ListTile(
                      leading: Icon(pjl.icon),
                      title: Text(pjl.title),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  initiallyExpanded: isPersediaanExpand,
                  onExpansionChanged: widget.onMenuPersediaanExpandChange,
                  title: const Text("Persediaan"),
                  children: lstPersediaan.map((stok) {
                    return ListTile(
                      leading: Icon(stok.icon),
                      title: Text(stok.title),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  initiallyExpanded: isLaporanExpand,
                  onExpansionChanged: widget.onMenuLaporanExpandChange,
                  title: const Text("Laporan"),
                  children: lstLaporan.map((rpt) {
                    return ListTile(
                      leading: Icon(rpt.icon),
                      title: Text(rpt.title),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
