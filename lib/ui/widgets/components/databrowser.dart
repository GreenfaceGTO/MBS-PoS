import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:mbspos/service/utils/extension.dart';
import 'package:provider/provider.dart';

class Databrowser extends StatefulWidget {
  const Databrowser({super.key, required this.tipeRef});
  final String tipeRef;

  @override
  State<Databrowser> createState() => _DatabrowserState();
}

class _DatabrowserState extends State<Databrowser> {
  @override
  void initState() {
    super.initState();
  }

  void onFloatinButtonTapped() async {
    if (widget.tipeRef == 'supplier' || widget.tipeRef == 'pelanggan') {
      Navigator.pushNamed(context, rtMitraForm,
          arguments: ArgsModel(
            formMode: FormMode.input,
            tipe: widget.tipeRef,
          ));
    } else {
      // await context
      //     .read<MasterProvider>()
      //     .addNewRef(context, widget.tipeRef.toLowerCase(), widget.tipeRef);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MasterProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Daftar ${widget.tipeRef.capitalizeFirst()}"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onFloatinButtonTapped,
          child: const Icon(Icons.add),
        ),
        body: widget.tipeRef == 'supplier' || widget.tipeRef == 'pelanggan'
            ? _daftarMitra(prov)
            : _daftarRef(prov));
  }

  Widget _daftarMitra(MasterProvider prov) {
    late List<MitraModel> data;
    switch (widget.tipeRef.toLowerCase()) {
      case "supplier":
        data = prov.daftarSupplier;

      case "pelanggan":
        data = prov.daftarPelanggan;
    }

    return data.isEmpty
        ? const EmptydataElement()
        : ListView(
            children: data.map((mtr) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, mtr);
                },
                title: Text(mtr.nama!),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (mtr.alamat != null) Text(mtr.alamat!),
                    if (mtr.noTelp != null) Text(mtr.noTelp!)
                  ],
                ),
              );
            }).toList(),
          );
  }

  Widget _daftarRef(MasterProvider prov) {
    late List<String> data;

    switch (widget.tipeRef.toLowerCase()) {
      case "satuan":
        data = prov.daftarSatuan;
      case "kategori":
        data = prov.daftarKategori;
      case "merek":
        data = prov.daftarMerek;
    }

    return data.isEmpty
        ? const EmptydataElement()
        : ListView(
            children: data.map((dt) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, dt);
                },
                title: Text(dt),
              );
            }).toList(),
          );
  }
}
