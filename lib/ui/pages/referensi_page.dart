import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/providers/ref_provider.dart';
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
    super.initState();
  }

  void onFloatinButtonTapp() {
    String selectedRef = provider.lstRefPage[provider.selectedRef];
    log(selectedRef);
    if (provider.selectedRef < 3) {
      //  Tampilkan jendela input referensi
    } else {
      // tampilkan jendela input mitra
    }
  }

  @override
  Widget build(BuildContext context) {
    // TextTheme tema = TextTheme.of(context);
    return Consumer<RefProvider>(builder: (context, prov, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Data Pendukung"),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: prov.lstRefPage[prov.selectedRef],
          onPressed: onFloatinButtonTapp,
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
                        int idx = prov.lstRefPage.indexOf(pg);
                        prov.onTabChange(idx);
                      },
                      label: Text(pg),
                      padding: const EdgeInsets.all(12),
                      selected: prov.lstRefPage.indexOf(pg) == prov.selectedRef,
                    ),
                  );
                }).toList(),
              ),
            ),
            prov.selectedRef < 3 ? const RefWidget() : const MitraRefWidget()
          ],
        ),
      );
    });
  }
}

class RefWidget extends StatefulWidget {
  const RefWidget({super.key});

  @override
  State<RefWidget> createState() => _RefWidgetState();
}

class _RefWidgetState extends State<RefWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        SizedBox(child: Consumer<RefProvider>(builder: (context, prov, _) {
      return prov.lstRef.isEmpty
          ? Center(
              child:
                  Text("Belum ada Data ${prov.lstRefPage[prov.selectedRef]}"),
            )
          : ListView(
              children: prov.lstRef.map((ref) {
                return ListTile(
                  title: Text(ref),
                );
              }).toList(),
            );
    })));
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
