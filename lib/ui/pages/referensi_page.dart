import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/providers/ref_provider.dart';
import 'package:mbspos/ui/widgets/elements/mitra_element.dart';
import 'package:mbspos/ui/widgets/elements/ref_element.dart';
import 'package:provider/provider.dart';

class ReferensiPage extends StatefulWidget {
  const ReferensiPage({super.key});

  @override
  State<ReferensiPage> createState() => _ReferensiPageState();
}

class _ReferensiPageState extends State<ReferensiPage>
    with SingleTickerProviderStateMixin {
  late RefProvider provider;
  late List<GlobalKey> _keys;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // buat 5 globalkey sesuai dengan jumlah tab menu yang dideklarasikan di provider
    _keys = List.generate(5, (_) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider = Provider.of<RefProvider>(context, listen: false);
      provider.init();
      int tabIndex = provider.lstRefPage.indexOf(provider.selectedRef);
      _autoScrollToIndexTab(tabIndex);
    });
    super.initState();
  }

  // -------------------------------------------------------------------------
  /// Fungsi sroll otomatis ke posisi tab yang terpilih saat halaman dibuka
  /// agar terlihat oleh user
  // -------------------------------------------------------------------------
  void _autoScrollToIndexTab(int index) {
    final context = _keys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5);
    }
  }

  // ---------------------------------------
  /// metode saat tombol floating di tekan
  // ---------------------------------------
  void onFloatinButtonTap() {
    if (provider.lstRefPage.indexOf(provider.selectedRef) < 3) {
      //  Tampilkan jendela input referensi
      showRefForm(title: provider.selectedRef);
    } else {
      // tampilkan jendela input mitra
      Navigator.pushNamed(context, '/mitraform',
          arguments: ArgsModel(
            mode: "input",
            tipe: provider.selectedRef,
          ));
    }
  }

  // ------------------------------------
  /// Menampilkan form input referensi
  // ------------------------------------
  void showRefForm({required String title}) async {
    TextEditingController txtRef = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: TextFormField(
              controller: txtRef,
              autofocus: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (txtRef.text.isNotEmpty) {
                      provider.saveRef(txtRef.text);
                      provider.getRef();
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text("SIMPAN"))
            ],
          );
        },
        barrierDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RefProvider>(builder: (context, prov, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Data Pendukung"),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: prov.selectedRef,
          onPressed: onFloatinButtonTap,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                children: prov.lstRefPage.map((pg) {
                  return Container(
                    key: _keys[prov.lstRefPage.indexOf(pg)],
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      onSelected: (val) {
                        prov.onTabChange(pg);
                      },
                      label: Text(pg),
                      padding: const EdgeInsets.all(12),
                      selected:
                          pg.toLowerCase() == prov.selectedRef.toLowerCase(),
                    ),
                  );
                }).toList(),
              ),
            ),
            prov.lstRefPage.indexOf(prov.selectedRef) < 3
                ? const RefWidget()
                : const MitraRefWidget()
          ],
        ),
      );
    });
  }
}
