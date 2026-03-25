import 'package:flutter/material.dart';
import 'package:mbspos/providers/produk_provider.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:provider/provider.dart';

class Databrowser extends StatefulWidget {
  const Databrowser({super.key, required this.tipeRef});
  final String tipeRef;

  @override
  State<Databrowser> createState() => _DatabrowserState();
}

class _DatabrowserState extends State<Databrowser> {
  List<String>? data = [];
  late ProdukProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      data = await provider.getReferensi(tipe: widget.tipeRef);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Browser"),
        ),
        body: data!.isEmpty || data == null
            ? const EmptydataElement()
            : ListView(
                children: data!.map((dt) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, dt);
                    },
                    title: Text(dt),
                  );
                }).toList(),
              ));
  }
}
