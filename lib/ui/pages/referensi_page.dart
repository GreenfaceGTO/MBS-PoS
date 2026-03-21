import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/providers/ref_provider.dart';
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

  @override
  void initState() {
    provider = Provider.of<RefProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider.init();
    });
    super.initState();
  }

  // ---------------------------------------
  /// metode saat tombol floating di tekan
  // ---------------------------------------
  void onFloatinButtonTap() {
    if (provider.lstRefPage.indexOf(provider.selectedRef) < 3) {
      //  Tampilkan jendela input referensi
      showRefForm(title: provider.selectedRef);
    } else {
      log("Input mitra");
      // tampilkan jendela input mitra
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                children: prov.lstRefPage.map((pg) {
                  return Padding(
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

class MitraRefWidget extends StatefulWidget {
  const MitraRefWidget({super.key});

  @override
  State<MitraRefWidget> createState() => _MitraRefWidgetState();
}

class _MitraRefWidgetState extends State<MitraRefWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.red,
      child: Center(
        child: Text("Ref Element"),
      ),
    ));
  }
}
