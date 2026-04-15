import 'package:flutter/material.dart';
import 'package:mbspos/service/utils/textformatter.dart';

class DialogHelper {
  /// =============Jendela konfirmasi delete=============
  static Future<bool?> confirmDelete(BuildContext context,
      {required String content}) async {
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Konfirmasi"),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx, true);
                  },
                  child: const Text("HAPUS")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx, false);
                  },
                  child: const Text("BATAL"))
            ],
          );
        });
  }

  /// ==============Form input referensi==============
  static Future<String?> showRefForm(BuildContext context,
      {required String title}) async {
    TextEditingController txtRef = TextEditingController();
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: TextFormField(
              controller: txtRef,
              autofocus: true,
              inputFormatters: [CapitalizeEachWord()],
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (txtRef.text.isNotEmpty) {
                      Navigator.pop(ctx, txtRef.text);
                    }
                  },
                  child: const Text("SIMPAN"))
            ],
          );
        },
        barrierDismissible: true);
  }

  // =============info satuan konversi=============
  static void showInfoSatuan(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            title: Text("Satuan Lainnya"),
            content: Text.rich(TextSpan(
                text:
                    "Umumnya produk memiliki satuan kemasan lain yang isinya lebih banyak.",
                children: [
                  TextSpan(
                      text: "\n\nContoh :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "\nProduk Mie"),
                  TextSpan(text: "\n- 1 Lusin berisi 12 Bks"),
                  TextSpan(text: "\n- 1 Dus berisi 48 Bks"),
                  TextSpan(
                      text: "\n\nPada contoh di atas, satuan dasarnya adalah"),
                  TextSpan(
                      text: " Bks",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " dan satuan lainnya"),
                  TextSpan(
                      text: " Lusin",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " dan "),
                  TextSpan(
                      text: " Dus",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ])),
          );
        });
  }

  // =============Info deskripsi minimum stok=============
  static void showInfoStokMin(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            title: Text("Stok Minimum"),
            content: Text.rich(TextSpan(
              text:
                  "Adalah ambang batas minimal barang yang wajib tersedia di pajangan sebagai pengaman persediaan, yaitu untuk meminimalisir kemungkinan terjadinya permintaan yang tidak terlayani.",
            )),
          );
        });
  }
}
