import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/ui/widgets/elements/mitra_element.dart';
import 'package:mbspos/ui/widgets/elements/ref_element.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:provider/provider.dart';

class ReferensiPage extends StatefulWidget {
  const ReferensiPage({super.key});

  @override
  State<ReferensiPage> createState() => _ReferensiPageState();
}

class _ReferensiPageState extends State<ReferensiPage>
    with SingleTickerProviderStateMixin {
  late MasterProvider provider;
  late List<GlobalKey> _keys;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // buat 5 globalkey sesuai dengan jumlah tab menu yang dideklarasikan di provider
    // untuk digunakan pada auto scrolling
    _keys = List.generate(5, (_) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider = Provider.of<MasterProvider>(context, listen: false);
      provider.init();
      log("selectedRef : ${provider.selectedRef}");
      log("tabIndex : ${provider.tabIndex}");

      _autoScrollToIndexTab(provider.tabIndex);
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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // ---------------------------------------
  /// metode saat tombol floating di tekan
  // ---------------------------------------
  void onFloatinButtonTap() {
    if (provider.tabIndex < 3) {
      //  Tampilkan jendela input referensi
      showRefForm(title: provider.selectedRef);
    } else {
      // tampilkan jendela input mitra
      Navigator.pushNamed(context, '/mitraform',
          arguments: ArgsModel(
            formMode: FormMode.input,
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
                      context
                          .read<MasterProvider>()
                          .addNewRef(title.toLowerCase(), txtRef.text);

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
    return Consumer<MasterProvider>(builder: (context, prov, _) {
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
                children: lstRefPage.map((pg) {
                  return Container(
                    key: _keys[lstRefPage.indexOf(pg)],
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      onSelected: (val) {
                        prov.selectTab(pg);
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
            prov.tabIndex < 3 ? const RefWidget() : const MitraRefWidget()
          ],
        ),
      );
    });
  }
}
