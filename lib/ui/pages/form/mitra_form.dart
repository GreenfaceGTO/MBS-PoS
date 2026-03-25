import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/providers/ref_provider.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/utils/global_enums.dart';
import 'package:provider/provider.dart';

class MitraForm extends StatefulWidget {
  const MitraForm({super.key, required this.args});
  final ArgsModel args;

  @override
  State<MitraForm> createState() => _MitraFormState();
}

class _MitraFormState extends State<MitraForm> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();
  TextEditingController txtNoTelp = TextEditingController();
  TextEditingController txtKet = TextEditingController();

  final formKey = GlobalKey<FormState>();
  // late Map<dynamic, dynamic> args;
  MitraModel? data;

  @override
  void initState() {
    if (widget.args.formMode == FormMode.update) {
      if (widget.args.data != null) {
        data = widget.args.data;
        txtNama.text = data!.nama!;
        txtAlamat.text = data!.alamat ?? "";
        txtNoTelp.text = data!.noTelp ?? "";
        txtKet.text = data!.keterangan ?? "";
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    txtAlamat.dispose();
    txtKet.dispose();
    txtNama.dispose();
    txtNoTelp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool formSupplier = widget.args.tipe == 'supplier';
    bool modeInput = widget.args.formMode == FormMode.input;

    return Scaffold(
      appBar: AppBar(
        title: modeInput
            ? Text("Input Data ${widget.args.tipe}")
            : Text("Edit Data ${widget.args.tipe}"),
      ),
      body: Consumer<RefProvider>(builder: (context, prov, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  controller: txtNama,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: "Nama"),
                  validator: (val) {
                    if (val!.isEmpty) return "Wajib diisi";
                    return null;
                  },
                ),
                spasi(),
                TextFormField(
                  controller: txtAlamat,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(hintText: "Alamat"),
                  maxLines: 3,
                ),
                spasi(),
                TextFormField(
                  controller: txtNoTelp,
                  keyboardType: TextInputType.phone,
                  textInputAction: formSupplier
                      ? TextInputAction.next
                      : TextInputAction.done,
                  decoration: const InputDecoration(hintText: "No. Telp"),
                ),
                spasi(),
                TextFormField(
                  controller: txtKet,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(hintText: "Keterangan"),
                  maxLines: 5,
                ),
                spasi(jarak: 30),
                CustomButton(
                  width: 200,
                  caption: "SIMPAN",
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      MitraModel newMitra = MitraModel(
                          id: modeInput ? null : data!.id,
                          nama: txtNama.text,
                          alamat:
                              txtAlamat.text.isNotEmpty ? txtAlamat.text : null,
                          noTelp:
                              txtNoTelp.text.isNotEmpty ? txtNoTelp.text : null,
                          tipe: prov.selectedRef.toLowerCase(),
                          keterangan:
                              txtKet.text.isNotEmpty ? txtKet.text : null,
                          createdAt: DateTime.now().toString());
                      if (modeInput) {
                        prov.saveMitra(newMitra);
                      } else {
                        prov.updateMitra(newMitra);
                      }
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
