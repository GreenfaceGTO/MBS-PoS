import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';

class SatkonversiForm extends StatefulWidget {
  const SatkonversiForm({super.key, required this.args});
  final ArgsModel args;

  @override
  State<SatkonversiForm> createState() => _SatkonversiFormState();
}

class _SatkonversiFormState extends State<SatkonversiForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satuan ${widget.args.tipe}"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                size: 18,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            TextFormField(
              decoration:
                  const InputDecoration(hintText: "Isi", label: Text("Isi")),
            ),
            spasi(),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Harga Pokok", label: Text("Harga Pokok")),
            ),
            spasi(),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Margin Profit",
                        label: Text("Margin Profit")),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.help,
                      size: 15,
                      color: Colors.teal,
                    ))
              ],
            ),
            spasi(),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Barcode",
                  label: const Text("Barcode"),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.barcode_reader,
                        size: 18,
                      ))),
            ),
            // spasi(jarak: 30),
            // CustomButton(
            //   width: 180,
            //   onPress: () {},
            //   caption: "OK",
            // )
          ],
        ),
      ),
    );
  }
}
