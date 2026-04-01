import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/models/data/satitem_model.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/service/utils/extension.dart';

class SatkonversiForm extends StatefulWidget {
  const SatkonversiForm({super.key, required this.args});
  final ArgsModel args;

  @override
  State<SatkonversiForm> createState() => _SatkonversiFormState();
}

class _SatkonversiFormState extends State<SatkonversiForm> {
  TextEditingController txtIsi = TextEditingController();
  TextEditingController txtHpokok = TextEditingController();
  TextEditingController txtMargin = TextEditingController();
  TextEditingController txtHargaJual = TextEditingController();
  TextEditingController txtBarcode = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    txtIsi.dispose();
    txtHpokok.dispose();
    txtMargin.dispose();
    txtBarcode.dispose();
    super.dispose();
  }

  void hitungHarga({required String dari}) {
    double hPokok = 0;
    double margin = 0;
    double hJual = 0;
    double hasil = 0;

    switch (dari) {
      case "pokok":
        if (txtHpokok.text.isNotEmpty) {
          hPokok = double.parse(txtHpokok.text);
          if (txtMargin.text.isNotEmpty) {
            margin = double.parse(txtMargin.text);
            hasil = hPokok + (hPokok * (margin / 100));
          } else {
            hasil = hPokok;
          }
        }
        setState(() {
          txtHargaJual.text = hasil.toStringAsFixed(2);
        });
        break;
      case 'margin':
        if (txtMargin.text.isNotEmpty) {
          if (txtHpokok.text.isNotEmpty) {
            hPokok = double.parse(txtHpokok.text);
          }
          margin = double.parse(txtMargin.text);
          hasil = hPokok + (hPokok * (margin / 100));
        }
        setState(() {
          txtHargaJual.text = hasil.toStringAsFixed(2);
        });
        break;
      case "hargajual":
        if (txtHpokok.text.isNotEmpty) {
          hPokok = double.parse(txtHpokok.text);
        }

        if (txtHargaJual.text.isNotEmpty) {
          hJual = double.parse(txtHargaJual.text);
        }

        if (hPokok > 0) {
          hasil = ((hJual - hPokok) / hPokok) * 100;
        }

        setState(() {
          txtMargin.text = hasil.toStringAsFixed(2);
        });
        break;
    }
  }

  // -----------------------------------------
  /// Menampilkan jendela info margin profit
  // -----------------------------------------
  void showInfoMargiProfit() {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            title: Text("Margin Profit"),
            content: Text.rich(TextSpan(
                text:
                    "Nilai persentase keuntungan dari harga pokok satuan yang ingin diperoleh dari penjualan produk.",
                children: [
                  TextSpan(
                      text: "\n\nTips :",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500)),
                  TextSpan(
                      text:
                          "\nPraktek terbaik dalam menentukan margin adalah fokus pada volume penjualan, bukan pada besar keuntungan yang bisa didapatkan dari penjualan satu produk. "),
                  TextSpan(
                      text:
                          "Harga murah dapat meningkatkan potensi penjualan serta mengurangi resiko penurunan kualitas produk."),
                ])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Detail Satuan ${widget.args.tipe.toString().capitalizeFirst()}"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: txtIsi,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: const InputDecoration(
                        hintText: "Isi", label: Text("Isi")),
                    validator: (val) {
                      if (val!.isEmpty) return "Wajib diisi";
                      return null;
                    },
                  ),
                ),
              ),
              spasi(),
              TextFormField(
                controller: txtHpokok,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    hintText: "Harga Pokok", label: Text("Harga Pokok")),
                onChanged: (val) {
                  hitungHarga(dari: 'pokok');
                },
                validator: (val) {
                  if (val!.isEmpty) return "Wajib diisi";
                  return null;
                },
              ),
              spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      controller: txtMargin,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        hitungHarga(dari: 'margin');
                      },
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).nextFocus();
                      },
                      decoration: const InputDecoration(
                          hintText: "Margin Profit",
                          label: Text("Margin Profit")),
                      validator: (val) {
                        if (val!.isEmpty) return "Wajib diisi";
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showInfoMargiProfit();
                      },
                      icon: const Icon(
                        Icons.help,
                        size: 15,
                        color: Colors.teal,
                      ))
                ],
              ),
              spasi(),
              TextFormField(
                controller: txtHargaJual,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(label: Text("Harga Jual")),
                onChanged: (val) {
                  hitungHarga(dari: 'hargajual');
                },
                validator: (val) {
                  if (val!.isEmpty) return "Wajib diisi";
                  return null;
                },
              ),
              spasi(),
              TextFormField(
                controller: txtBarcode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: "Barcode",
                    label: const Text("Barcode"),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final barcode = await scanBarcode(context);
                          if (barcode != null) {
                            setState(() {
                              txtBarcode.text = barcode;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.barcode_reader,
                          size: 18,
                        ))),
              ),
              spasi(jarak: 30),
              CustomButton(
                width: 180,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    SatitemModel retVal = SatitemModel(
                        satuan: widget.args.tipe,
                        isi: int.parse(txtIsi.text),
                        tipe: widget.args.tipe,
                        hargaPokok: double.parse(txtHpokok.text),
                        margin: double.parse(txtMargin.text),
                        barcode: txtBarcode.text);
                    Navigator.pop(context, retVal);
                  }
                },
                caption: "OK",
              )
            ],
          ),
        ),
      ),
    );
  }
}
