import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/utils/extension.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

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

  @override
  void dispose() {
    txtIsi.dispose();
    txtHpokok.dispose();
    txtMargin.dispose();
    txtBarcode.dispose();
    super.dispose();
  }

  Future<void> hitungHargaJual() async {
    double hPokok = 0;
    double margin = 0;
    double hasil = 0;

    if (txtHpokok.text.isNotEmpty) {
      hPokok = double.parse(txtHpokok.text);
    }
    if (margin == 0) {
      if (hPokok > 0) {
        hasil = hPokok;
      }
    } else {
      hasil = hPokok + (hPokok * (margin / 100));
    }

    setState(() {
      txtHargaJual.text = toRupiah.format(hasil);
    });
  }

  Future<void> scanBarcode() async {
    String? result = await SimpleBarcodeScanner.scanBarcode(context,
        barcodeAppBar: const BarcodeAppBar(
            appBarTitle: "Scan barcode",
            centerTitle: false,
            enableBackButton: true,
            backButtonIcon: Icon(Icons.chevron_left)),
        isShowFlashIcon: true,
        delayMillis: 500,
        cameraFace: CameraFace.back,
        scanFormat: ScanFormat.ONLY_BARCODE);

    if (result != null) {
      setState(() {
        txtBarcode.text = result;
      });
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
                      text: "\n\nCatatan Penting :",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500)),
                  TextSpan(
                      text:
                          "\nPraktek terbaik dalam menentukan margin adalah fokus pada volume penjualan, bukan besar keuntungan yang bisa didapatkan dari penjualan satu produk."),
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
      body: Padding(
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
                      hitungHargaJual;
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
              readOnly: true,
              decoration: const InputDecoration(label: Text("Harga Jual")),
            ),
            spasi(),
            TextFormField(
              controller: txtBarcode,
              decoration: InputDecoration(
                  hintText: "Barcode",
                  label: const Text("Barcode"),
                  suffixIcon: IconButton(
                      onPressed: () {
                        scanBarcode();
                      },
                      icon: const Icon(
                        Icons.barcode_reader,
                        size: 18,
                      ))),
            ),
            spasi(jarak: 30),
            CustomButton(
              width: 180,
              onPress: () {},
              caption: "OK",
            )
          ],
        ),
      ),
    );
  }
}
