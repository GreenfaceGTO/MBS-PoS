import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/utils/global_enums.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({super.key, required this.args});
  final ArgsModel args;

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  late bool inputMode;
  final formKey = GlobalKey<FormState>();

  TextEditingController txtNama = TextEditingController();
  TextEditingController txtMerek = TextEditingController();
  TextEditingController txtKategori = TextEditingController();
  TextEditingController txtSupplier = TextEditingController();
  TextEditingController txtMinStok = TextEditingController();

  @override
  void initState() {
    inputMode = widget.args.formMode == FormMode.input;

    super.initState();
  }

  Future<String?> browseRef({required String tipeData}) async {
    final result = await Navigator.pushNamed(context, '/browser',
        arguments: {'tipe': tipeData});
    return result as String?;
  }

  @override
  void dispose() {
    txtKategori.dispose();
    txtMerek.dispose();
    txtNama.dispose();
    txtMinStok.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(inputMode ? "Tambah Produk" : "Edit produk"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: "Nama Produk"),
                    ),
                    spasi(),
                    TextFormField(
                      controller: txtMerek,
                      decoration: InputDecoration(
                          hintText: "Merek",
                          suffixIcon: IconButton(
                              onPressed: () async {
                                String? result =
                                    await browseRef(tipeData: "merek");
                                if (result != null) {
                                  txtMerek.text = result;
                                  setState(() {});
                                }
                              },
                              icon: const Icon(
                                Icons.library_books_sharp,
                                size: 18,
                              ))),
                    ),
                    spasi(),
                    TextFormField(
                      controller: txtKategori,
                      decoration: InputDecoration(
                          hintText: "Kategori",
                          suffixIcon: IconButton(
                              onPressed: () async {
                                String? result =
                                    await browseRef(tipeData: "kategori");
                                if (result != null) {
                                  txtKategori.text = result;
                                  setState(() {});
                                }
                              },
                              icon: const Icon(
                                Icons.library_books_sharp,
                                size: 18,
                              ))),
                    ),
                    spasi(),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: "Supplier",
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.library_books_sharp,
                                size: 18,
                              ))),
                    ),
                    spasi(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 150,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Min. Stok"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              height: 55,
              child: CustomButton(
                mode: ButtonMode.elevated,
                onPress: () {},
                caption: "SIMPAN",
              ),
            )
          ],
        ),
      ),
    );
  }
}
