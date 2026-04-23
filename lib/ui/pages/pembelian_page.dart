import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/providers/mutasimasuk_provider.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:provider/provider.dart';

class PembelianPage extends StatefulWidget {
  const PembelianPage({super.key});

  @override
  State<PembelianPage> createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log("$runtimeType : fetch data pembelian...");
      context.read<MutasimasukProvider>().getAllPembelian();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pembelian"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, rtPembelianForm,
              arguments: ArgsModel(formMode: FormMode.input));
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<MutasimasukProvider>(builder: (context, prov, _) {
        return prov.daftarTransaksi.isEmpty
            ? const Center(
                child: EmptydataElement(),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: prov.daftarTransaksi.map((pbl) {
                    return ListTile(
                      title: Text(pbl.noBukti!),
                    );
                  }).toList(),
                ),
              );
      }),
    );
  }
}
