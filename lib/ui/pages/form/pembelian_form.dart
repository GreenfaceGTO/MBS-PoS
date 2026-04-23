import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/service/utils/global_enums.dart';

class PembelianForm extends StatefulWidget {
  const PembelianForm({super.key, required this.args});
  final ArgsModel args;

  @override
  State<PembelianForm> createState() => _PembelianFormState();
}

class _PembelianFormState extends State<PembelianForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.formMode == FormMode.input
            ? "Pembelian Baru"
            : "Update Pembelian"),
      ),
      body: Center(
        child: Text("Form Pembelian"),
      ),
    );
  }
}
