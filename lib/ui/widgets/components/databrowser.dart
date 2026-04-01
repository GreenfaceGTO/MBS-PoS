import 'package:flutter/material.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/providers/produk_provider.dart';
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
  List<String>? dataRef = [];
  List<MitraModel> dataMitra = [];
  late ProdukProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<ProdukProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.tipeRef == 'supplier' || widget.tipeRef == 'pelanggan') {
        dataMitra = await provider.getMitra(tipe: widget.tipeRef);
      } else {
        dataRef = await provider.getReferensi(tipe: widget.tipeRef);
      }
      setState(() {});
    });
  }

  void onFloatinButtonTapped() async {
    if (widget.tipeRef == 'kategori') {
      await provider.addNewRef(context, tipeRef: "Kategori");
      // if (newKat != null) {
      //   setState(() {
      //     dataRef!.add(newKat);
      //     dataRef!.sort((a, b) => a.compareTo(b));
      //   });
      // }
    } else if (widget.tipeRef == 'satuan') {
      // final String? newSat =
      await provider.addNewRef(context, tipeRef: "Satuan");
      // if (newSat != null) {
      //   setState(() {
      //     dataRef!.add(newSat);
      //     dataRef!.sort((a, b) => a.compareTo(b));
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Daftar ${widget.tipeRef.capitalizeFirst()}"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onFloatinButtonTapped,
          child: const Icon(Icons.add),
        ),
        body: widget.tipeRef == 'supplier' || widget.tipeRef == 'pelanggan'
            ? _daftarMitra()
            : _daftarRef(context));
  }

  Widget _daftarMitra() {
    return dataMitra.isEmpty
        ? const EmptydataElement()
        : ListView(
            children: dataMitra.map((mtr) {
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

  Widget _daftarRef(BuildContext context) {
    return dataRef!.isEmpty || dataRef == null
        ? const EmptydataElement()
        : ListView(
            children: dataRef!.map((dt) {
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
