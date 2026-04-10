import 'package:flutter/material.dart';
import 'package:mbspos/service/utils/textformatter.dart';

class DialogHelper {
  // -----------------------------
  /// Form input referensi
  // -----------------------------
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

  // static void showInfoMargiProfit(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (ctx) {
  //         return const AlertDialog(
  //           title: Text("Margin Profit"),
  //           content: Text.rich(TextSpan(
  //               text:
  //                   "Adalah nilai persentase keuntungan berdasarkan harga pokok produk.",
  //               children: [
  //                 TextSpan(
  //                     text:
  //                         "\n\nHarga pokok adalah akumulasi dari harga perolehan produk, yaitu :"),
  //                 TextSpan(text: "\n-. Harga produk."),
  //                 TextSpan(text: "\n-. Biaya pengiriman."),
  //                 TextSpan(text: "\n-. Pajak pembelian (jika ada)."),
  //                 TextSpan(
  //                     text: "\n\nTips :",
  //                     style: TextStyle(
  //                         color: Colors.red, fontWeight: FontWeight.w500)),
  //                 TextSpan(
  //                     text:
  //                         "\nPraktek terbaik dalam menentukan margin adalah fokus pada volume penjualan, bukan pada besar keuntungan yang bisa didapatkan dari penjualan satu produk. "),
  //                 TextSpan(
  //                     text:
  //                         "Harga produk yang terlalu mahal beresiko lama laku atau bahkan tidak laku."),
  //               ])),
  //         );
  //       });
  // }

  static void showInfoSatuan(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            title: Text("Satuan Lainnya"),
            content: Text.rich(TextSpan(
                text:
                    "Produk umumnya memiliki satuan kemasan lain yang isinya lebih banyak.",
                children: [
                  TextSpan(
                      text: "\n\nContoh :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "\nProduk Mie"),
                  TextSpan(text: "\n- 1 Lusin isi 12 Bks"),
                  TextSpan(text: "\n- 1 Dus isi 48 Bks"),
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
