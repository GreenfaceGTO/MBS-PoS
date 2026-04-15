import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/models/data/satitem_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:mbspos/service/utils/textformatter.dart';
import 'package:mbspos/ui/pages/form/dialog_helper.dart';
import 'package:mbspos/ui/pages/form/detailsatuan_form.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/customstepper.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:provider/provider.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({super.key, required this.args});
  final ArgsModel args;

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final formKey = GlobalKey<FormState>();

  int currentStep = 0;

  List<String> lstStepTitle = [
    "Data Umum",
    "Kategori",
    "Satuan & Harga",
    "Preview"
  ];

  // =========properti data umum= (step1)========
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtSupplier = TextEditingController();
  String? selectedMerek;
  MitraModel? selectedSupplier;
  SatitemModel? selectedSatDasar;
  // ==========end of properti data umum==========

// =============properti data kategori (step2)=============
  List<String> selectedKategori = [];
// =============end of properti data kategori (step2)=============

// =============properti data satuan (step3)=============
  TextEditingController txtIsi = TextEditingController();
  TextEditingController txtHpokok = TextEditingController();
  TextEditingController txtMargin = TextEditingController();
  TextEditingController txtHjual = TextEditingController();
  TextEditingController txtBarcode = TextEditingController();

  List<SatitemModel> lstSatuan = [];
// =============end of properti data satuan (step3)=============

  void increaseStep() {
    setState(() {
      currentStep++;
    });
  }

  void decreaseStep() {
    setState(() {
      currentStep--;
    });
  }

// =============metode validasi setiap halaman=============
  bool validateInput(BuildContext context) {
    switch (currentStep) {
      case 0:
        if (formKey.currentState!.validate()) {
          return true;
        }

      case 1:
        if (selectedKategori.isEmpty) {
          showMessage(
              message: "Setidaknya pilih 1 kategori.",
              mode: MessageMode.warning);
        } else {
          return true;
        }
      case 2:
        if (formKey.currentState!.validate()) {
          if (selectedSatDasar != null) {
            return true;
          } else {
            showMessage(
                message: "Satuan dasar belum dipilih",
                mode: MessageMode.warning);
          }
        }
    }

    return false;
  }

  // ==========membuka form detail satuan==========
  Future<SatitemModel?> openSatuanForm({required bool satDasar}) async {
    SatitemModel? satuan = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsatuanForm(
                  satDasar: selectedSatDasar,
                  namaProduk: txtNama.text,
                )));
    if (satuan != null) {
      return satuan;
    }
    return null;
  }

  // ========Menampilkan browser untuk memilih supplier========
  Future<MitraModel?> browseMitra(BuildContext context,
      {required String tipeMitra}) async {
    final result = await Navigator.pushNamed(context, rtBrowserData,
        arguments: {'tipe': tipeMitra});
    if (result == null) {
      return null;
    }
    return result as MitraModel;
  }

  double hargaJualSat(double hPokok, double margin) {
    return hPokok + (hPokok * (margin / 100));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Produk"),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: Customstepper(
                    currentStep: currentStep,
                    steps: lstStepTitle,
                    onStepTapped: (val) {}),
              ),
              Expanded(
                  child: Container(
                child: _stepPage(context),
              )),
              const Divider(),
              _buttonNavigation(context)
            ],
          ),
        ),
      ),
    );
  }

  // ================spliter halaman================
  Widget _stepPage(BuildContext context) {
    switch (currentStep) {
      case 0:
        return _dataUmum(context);
      case 1:
        return _kategori(context);
      case 2:
        return _satuan(context);

      default:
        return _preview();
    }
  }

  // ================Halaman satuan================
  Widget _satuan(
    BuildContext context,
  ) {
    // final prov = context.read<MasterProvider>();
    return selectedSatDasar == null
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 45,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final satDasar = await openSatuanForm(satDasar: true);
                      if (satDasar != null) {
                        setState(() {
                          selectedSatDasar = satDasar;
                        });
                      }
                    },
                    label: const Text("PILIH SATUAN DASAR"),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ),
                spasi(jarak: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info,
                      color: Colors.teal,
                    ),
                    spasi(jarak: 6, mode: OrientationMode.horizontal),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "Satuan dasar adalah satuan jual terkecil produk ${txtNama.text.trim()} ini di tempat Anda",
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Satuan Dasar :",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                spasi(jarak: 4),
                _rowFieldWidget("Kemasan", selectedSatDasar!.satuan!),
                _rowFieldWidget("Harga Pokok",
                    toRupiah.format(selectedSatDasar!.hargaPokok)),
                _rowFieldWidget(
                    "Harga Jual", toRupiah.format(selectedSatDasar!.hargaJual)),
                _rowFieldWidget(
                    "Stok. Min.", selectedSatDasar!.minStok.toString()),
                spasi(jarak: 10),
                if (lstSatuan.isEmpty)
                  Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 30,
                        child: CustomButton(
                          mode: ButtonMode.outlined,
                          caption: "GANTI",
                          onPress: () {
                            setState(() {
                              selectedSatDasar = null;
                            });
                          },
                        ),
                      )),
                spasi(jarak: 10),
                const Divider(),
                _satuanLainWidget()
              ],
            ),
          );
  }

  Widget _rowFieldWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Container _satuanLainWidget() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black38, width: 0.5)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12),
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Satuan Lainnya",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () {
                          DialogHelper.showInfoSatuan(context);
                        },
                        icon: const Icon(
                          Icons.info,
                          color: Colors.teal,
                          size: 18,
                        ))
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      final satKonv = await openSatuanForm(satDasar: false);
                      if (satKonv != null) {
                        if (satKonv.satuan!.toLowerCase() ==
                            selectedSatDasar!.satuan!.toLowerCase()) {
                          showMessage(
                              message:
                                  "Satuan konversi tidak boleh sama dengan satuan dasar",
                              mode: MessageMode.error);
                        } else {
                          setState(() {
                            lstSatuan.add(satKonv);
                          });
                        }
                        log("validasi");
                      }
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      size: 18,
                    ))
              ],
            ),
          ),
          lstSatuan.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: EmptydataElement(
                    iconSize: 30,
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: lstSatuan.map((satl) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 0.5),
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _rowFieldWidget(satl.satuan!,
                                    "${satl.isi} ${selectedSatDasar!.satuan!}"),
                                _rowFieldWidget("Harga Pokok",
                                    toRupiah.format(satl.hargaPokok)),
                                _rowFieldWidget("Harga Jual",
                                    toRupiah.format(satl.hargaJual)),
                              ],
                            ),
                          ),
                          spasi(mode: OrientationMode.horizontal, jarak: 4),
                          IconButton(
                              onPressed: () async {
                                bool? confirm = await DialogHelper.confirmDelete(
                                    context,
                                    content:
                                        "Satuan ${satl.satuan} ini ingin di hapus?");
                                if (confirm != null && confirm) {
                                  setState(() {
                                    lstSatuan.removeWhere(
                                        (e) => e.satuan == satl.satuan);
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: Colors.red,
                                size: 18,
                              ))
                        ],
                      ),
                    );
                  }).toList(),
                )
        ],
      ),
    );
  }

  Widget _preview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          // data umum
          sectionTitle(context, title: "Data Umum"),
          _rowFieldWidget("Nama Produk", txtNama.text),
          if (selectedMerek != null) _rowFieldWidget("Merek", selectedMerek!),
          if (selectedSupplier != null)
            _rowFieldWidget("Supplier", selectedSupplier!.nama!),
          _rowFieldWidget("Stok. Min.", selectedSatDasar!.minStok.toString()),
          spasi(),

          // kategori
          sectionTitle(context, title: "Kategori"),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: selectedKategori.map((kat) {
                return Text(kat);
              }).toList(),
            ),
          ),
          spasi(),

          // harga pokok
          sectionTitle(context, title: "Harga Pokok"),
          _rowFieldWidget("1 ${selectedSatDasar!.satuan}",
              toRupiah.format(selectedSatDasar!.hargaPokok)),
          if (lstSatuan.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: lstSatuan.map((satl) {
                return _rowFieldWidget("1 ${satl.satuan} (Isi: ${satl.isi})",
                    toRupiah.format(satl.hargaPokok));
              }).toList(),
            ),
          spasi(),

          // harga jual
          sectionTitle(context, title: "Harga Jual"),
          _rowFieldWidget("1 ${selectedSatDasar!.satuan!}",
              toRupiah.format(bulatkan(selectedSatDasar!.hargaJual!, 1000))),
          if (lstSatuan.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: lstSatuan.map((satl) {
                return _rowFieldWidget("1 ${satl.satuan}",
                    toRupiah.format(bulatkan(satl.hargaJual!, 1000)));
              }).toList(),
            ),
          spasi(),
          sectionTitle(context, title: "Profit"),
          _rowFieldWidget(
              "1 ${selectedSatDasar!.satuan}",
              toRupiah.format(selectedSatDasar!.hargaJual! -
                  selectedSatDasar!.hargaPokok!)),
          if (lstSatuan.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: lstSatuan.map((satl) {
                return _rowFieldWidget("1 ${satl.satuan}",
                    toRupiah.format(satl.hargaJual! - satl.hargaPokok!));
              }).toList(),
            ),
        ],
      ),
    );
  }

  /// === Halaman input data umum ===
  Widget _dataUmum(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          TextFormField(
            controller: txtNama,
            inputFormatters: [CapitalizeEachWord()],
            decoration: const InputDecoration(
                hintText: "Cth. Mie Goreng", label: Text("Nama Produk")),
            validator: (val) {
              if (val!.isEmpty) return "Wajib diisi!";
              return null;
            },
          ),
          spasi(),
          Consumer<MasterProvider>(builder: (context, prov, _) {
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
                        value: selectedMerek,
                        items: prov.daftarMerek.map((mrk) {
                          return DropdownMenuItem(value: mrk, child: Text(mrk));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedMerek = val;
                          });
                        })),
                IconButton(
                    onPressed: () async {
                      String? newMerek = await DialogHelper.showRefForm(context,
                          title: "Merek");
                      if (newMerek != null) {
                        if (context.mounted) {
                          await context
                              .read<MasterProvider>()
                              .addNewRef(context, "merek", newMerek);
                          setState(() {
                            selectedMerek = newMerek;
                          });
                        }
                      }
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
                      final mitra =
                          await browseMitra(context, tipeMitra: "supplier");
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
      ),
    );
  }

  /// =========Halaman pilih kategori=========
  Widget _kategori(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Consumer<MasterProvider>(builder: (context, prov, _) {
        return Column(
          children: [
            if (prov.daftarKategori.isNotEmpty)
              const Text(
                "Pilih satu atau beberapa kategori sekaligus",
                style: TextStyle(color: Colors.teal),
              ),
            spasi(jarak: 4),
            Expanded(
              child: prov.daftarKategori.isEmpty
                  ? const EmptydataElement(
                      caption: "Belum ada master kategori",
                    )
                  : ListView(
                      children: prov.daftarKategori.map((kat) {
                      return ListTile(
                        onTap: () {
                          bool check = selectedKategori.contains(kat);
                          if (!check) {
                            selectedKategori.add(kat);
                          } else {
                            selectedKategori.removeWhere((e) => e == kat);
                          }
                          setState(() {});
                        },
                        title: Text(kat),
                        trailing: selectedKategori.contains(kat)
                            ? const Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Colors.teal,
                              )
                            : null,
                      );
                    }).toList()),
            ),
            SizedBox(
              height: 45,
              width: 200,
              child: OutlinedButton.icon(
                onPressed: () async {
                  String? newKat = await DialogHelper.showRefForm(context,
                      title: "Kategori");
                  if (newKat != null) {
                    if (context.mounted) {
                      await context
                          .read<MasterProvider>()
                          .addNewRef(context, 'kategori', newKat);
                    }
                  }
                },
                label: const Text("KATEGORI BARU"),
                icon: const Icon(Icons.add),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buttonNavigation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8, top: 8),
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 40,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.yellow.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              iconAlignment: IconAlignment.start,
              onPressed: () {
                if (currentStep > 0) {
                  decreaseStep();
                } else {
                  Navigator.pop(context);
                }
              },
              label: currentStep == 0
                  ? const Text("Batal")
                  : const Text("Sebelumnya"),
              icon: currentStep == 0
                  ? const Icon(Icons.close)
                  : const Icon(Icons.arrow_back),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.yellow.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              iconAlignment: currentStep < (lstStepTitle.length - 1)
                  ? IconAlignment.end
                  : IconAlignment.start,
              onPressed: () async {
                if (currentStep < lstStepTitle.length - 1) {
                  bool next = validateInput(context);
                  false;

                  if (next) {
                    increaseStep();
                  }
                } else {
                  ItemModel newItem = ItemModel(
                      namaProduk: txtNama.text,
                      merek: selectedMerek?.trim(),
                      supplier: selectedSupplier?.nama!.trim(),
                      kategori: selectedKategori,
                      minStok: selectedSatDasar!.minStok,
                      satuan: [selectedSatDasar!]);
                  for (var sat in lstSatuan) {
                    newItem.satuan.add(sat);
                  }
                  // log(newItem.toDb().toString());
                  // log("======");
                  // log(newItem.toMap().toString());
                  bool sukses = await context
                      .read<MasterProvider>()
                      .addNewProduk(newItem);
                  if (sukses) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                }
              },
              label: currentStep < lstStepTitle.length - 1
                  ? const Text("Selanjutnya")
                  : const Text("SIMPAN"),
              icon: currentStep < lstStepTitle.length - 1
                  ? const Icon(Icons.arrow_forward)
                  : const Icon(Icons.save),
            ),
          )
        ],
      ),
    );
  }
}
