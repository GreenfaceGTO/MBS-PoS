import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/providers/produk_provider.dart';
import 'package:mbspos/ui/dummy_page.dart';
import 'package:mbspos/ui/widgets/components/customstepper.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:provider/provider.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({super.key, required this.args});
  final ArgsModel args;

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final provider = ProdukProvider();
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  List<String> lstStepTitle = [
    "Data Umum",
    "Kategori",
    "Satuan dan Harga",
    "Preview"
  ];

  // -----------------------
  // properti data umum
  // -----------------------
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtSupplier = TextEditingController();
  String? selectedMerek;
  MitraModel? selectedSupplier;
  // -----------------------------
  // end of properti data umum
  // -----------------------------

  bool validateDataUmum() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  // ------------------------------------------------
  /// Menampilkan browser untuk memilih supplier
  // ------------------------------------------------
  Future<MitraModel?> browseMitra({required String tipeMitra}) async {
    final result = await Navigator.pushNamed(context, "/browser",
        arguments: {'tipe': tipeMitra});
    if (result == null) {
      return null;
    }
    return result as MitraModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              color: Colors.indigo.shade400,
              child: Customstepper(
                  currentStep: currentStep,
                  steps: lstStepTitle,
                  onStepTapped: (val) {}),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: _stepPage(),
            )),
            _buttonNavigation()
          ],
        ),
      ),
    );
  }

  Widget _stepPage() {
    switch (currentStep) {
      case 0:
        return _dataUmum();
      case 1:
        return _kategori();
      case 2:
        return _satuan();
      default:
        return _preview();
    }
  }

  Widget _preview() {
    return const DummyPage(caption: "Preview");
  }

  Widget _dataUmum() {
    return Column(
      children: [
        TextFormField(
          controller: txtNama,
          decoration: const InputDecoration(
              hintText: "Cth. Mie Goreng", label: Text("Nama Produk")),
          validator: (val) {
            if (val!.isEmpty) return "Wajib diisi!";
            return null;
          },
        ),
        spasi(),
        Consumer<ProdukProvider>(builder: (context, prov, _) {
          return Row(
            children: [
              Expanded(
                  child: DropdownButtonFormField<String>(
                      menuMaxHeight: 500,
                      decoration: const InputDecoration(label: Text("Merek")),
                      hint: const Text(
                        "Merek",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                      items: prov.lstMerek.map((mrk) {
                        return DropdownMenuItem(value: mrk, child: Text(mrk));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedMerek = val;
                        });
                      })),
              IconButton(
                  onPressed: () async {
                    await prov.addNewRef(context, tipeRef: "Merek");
                  },
                  icon: const Icon(Icons.add_circle))
            ],
          );
        }),
        spasi(),
        TextFormField(
          controller: txtSupplier,
          readOnly: true,
          decoration: InputDecoration(
              hintText: "Pilih Supplier",
              label: const Text("Supplier"),
              suffixIcon: IconButton(
                  onPressed: () async {
                    final mitra = await browseMitra(tipeMitra: "supplier");
                    if (mitra != null) {
                      setState(() {
                        selectedSupplier = mitra;
                        txtSupplier.text = mitra.nama!;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.library_books_sharp,
                    size: 18,
                  ))),
        )
      ],
    );
  }

  Widget _kategori() {
    return ListView(
      children: List.generate(10, (idx) {
        return ListTile(
          title: Text("Kategori $idx"),
        );
      }),
    );
  }

  Widget _satuan() {
    return const SizedBox(
      child: Center(
        child: Text("Satuan dan Harga"),
      ),
    );
  }

  Padding _buttonNavigation() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentStep > 0
              ? SizedBox(
                  height: 40,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    iconAlignment: IconAlignment.start,
                    onPressed: () {
                      if (currentStep > 0) {
                        setState(() {
                          currentStep--;
                        });
                      }
                    },
                    label: const Text("Sebelumnya"),
                    icon: const Icon(Icons.chevron_left),
                  ),
                )
              : const SizedBox(),
          SizedBox(
            height: 40,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              iconAlignment: IconAlignment.end,
              onPressed: () {
                if (currentStep < lstStepTitle.length - 1) {
                  bool next = false;
                  if (currentStep == 0) {
                    next = validateDataUmum();
                  }

                  if (next) {
                    setState(() {
                      currentStep++;
                    });
                  }
                }
              },
              label: const Text("Selanjutnya"),
              icon: const Icon(Icons.chevron_right),
            ),
          )
        ],
      ),
    );
  }
}
