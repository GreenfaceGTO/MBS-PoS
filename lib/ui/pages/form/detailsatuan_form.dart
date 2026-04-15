import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/models/data/satitem_model.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/ui/pages/form/dialog_helper.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:provider/provider.dart';
// import 'package:mbspos/ui/widgets/elements/xdetailsatuan_element.oldart';

class DetailsatuanForm extends StatefulWidget {
  const DetailsatuanForm({super.key, this.satDasar, required this.namaProduk});
  final SatitemModel? satDasar;
  final String namaProduk;

  @override
  State<DetailsatuanForm> createState() => _DetailsatuanFormState();
}

class _DetailsatuanFormState extends State<DetailsatuanForm> {
  TextEditingController txtIsi = TextEditingController();
  TextEditingController txtHpokok = TextEditingController();
  TextEditingController txtHjual = TextEditingController();
  TextEditingController txtBarcode = TextEditingController();
  TextEditingController txtStokMin = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? selectedSatuan;
  double profit = 0;

  @override
  void initState() {
    if (widget.satDasar == null) {
      txtIsi.text = "1";
    }
    super.initState();
  }

  void hitungHarga({required String dari}) {
    double hPokok = 0;
    double hJual = 0;

    switch (dari) {
      case 'pokok':
        if (txtHpokok.text.isNotEmpty) {
          hPokok = double.parse(txtHpokok.text);
          if (txtHjual.text.isNotEmpty) {
            hJual = double.parse(txtHjual.text);
          }
        }
        setState(() {
          profit = hJual - hPokok;
        });
        break;

      case "hargajual":
        if (txtHpokok.text.isNotEmpty) {
          hPokok = double.parse(txtHpokok.text);
        }

        if (txtHjual.text.isNotEmpty) {
          hJual = double.parse(txtHjual.text);
        }

        setState(() {
          profit = hJual - hPokok;
        });
        break;
      case "isi":
        if (txtIsi.text.isNotEmpty) {
          double hppDasar = widget.satDasar!.hargaPokok!;
          double hpjDasar = widget.satDasar!.hargaJual!;
          int isi = int.parse(txtIsi.text);
          hPokok = isi * hppDasar;
          txtHpokok.text = hPokok.toStringAsFixed(2);
          txtHjual.text = (isi * hpjDasar).toStringAsFixed(2);
          hJual = double.parse(txtHjual.text);
        }
        setState(() {
          profit = hJual - hPokok;
        });
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MasterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: widget.satDasar == null
            ? const Text("Detail Satuan")
            : const Text("Detail Satuan Konversi"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text("Nama Produk :"),
                    spasi(mode: OrientationMode.horizontal, jarak: 4),
                    Text(
                      widget.namaProduk,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      softWrap: true,
                      maxLines: 2,
                    )
                  ],
                ),
                spasi(),
                Row(
                  children: [
                    Expanded(
                        child: DropdownButtonFormField(
                            hint: const Text("Pilih Satuan"),
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                            value: selectedSatuan,
                            items: prov.daftarSatuan.map((sat) {
                              return DropdownMenuItem(
                                  value: sat,
                                  child: Text(
                                    sat,
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ));
                            }).toList(),
                            onChanged: (val) {
                              log(val.toString());
                              setState(() {
                                selectedSatuan = val;
                              });
                            })),
                    IconButton(
                        onPressed: () async {
                          String? newSat = await DialogHelper.showRefForm(
                              context,
                              title: "Satuan");
                          if (newSat != null) {
                            if (context.mounted) {
                              await context
                                  .read<MasterProvider>()
                                  .addNewRef(context, "satuan", newSat);
                              setState(() {
                                selectedSatuan = newSat;
                              });
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          size: 20,
                        ))
                  ],
                ),
                if (selectedSatuan != null)
                  Column(
                    children: [
                      spasi(),
                      if (widget.satDasar != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: defaultPadding),
                            child: SizedBox(
                              width: 120,
                              child: TextFormField(
                                controller: txtIsi,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (va) {
                                  hitungHarga(dari: "isi");
                                },
                                decoration:
                                    const InputDecoration(label: Text("Isi")),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Wajib diisi";
                                  } else {
                                    if (int.parse(val) < 2) {
                                      return "Harus lebih dari 1";
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      TextFormField(
                        controller: txtHpokok,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(label: Text("Harga Pokok")),
                        onChanged: (val) {
                          hitungHarga(dari: "pokok");
                        },
                        validator: (val) {
                          if (val!.isEmpty) return "Wajib diisi";
                          return null;
                        },
                      ),
                      spasi(),
                      TextFormField(
                        controller: txtHjual,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onChanged: (va) {
                          hitungHarga(dari: "hargajual");
                        },
                        decoration:
                            const InputDecoration(label: Text("Harga Jual")),
                      ),
                      spasi(),
                      Row(
                        children: [
                          const Text("Keuntungan : "),
                          spasi(mode: OrientationMode.horizontal),
                          Text(
                            toRupiah.format(profit),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: profit < 0 ? Colors.red : Colors.teal),
                          ),
                          Text(" /$selectedSatuan")
                        ],
                      ),
                      spasi(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: txtBarcode,
                              textInputAction: widget.satDasar == null
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                              onFieldSubmitted: (val) {
                                FocusScope.of(context).nextFocus();
                              },
                              decoration:
                                  const InputDecoration(label: Text("Barcode")),
                            ),
                          ),
                          IconButton(
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
                                size: 20,
                              ))
                        ],
                      ),
                      spasi(),
                      if (widget.satDasar == null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  controller: txtStokMin,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                      label: Text("Stok Minimum")),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Wajib diisi";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    DialogHelper.showInfoStokMin(context);
                                  },
                                  icon: const Icon(
                                    Icons.info,
                                    color: Colors.teal,
                                    size: 18,
                                  ))
                            ],
                          ),
                        ),
                      spasi(jarak: 30),
                      CustomButton(
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            SatitemModel satProduk = SatitemModel(
                                satuan: selectedSatuan,
                                isi: int.parse(txtIsi.text),
                                tipe: widget.satDasar == null ? "D" : "K",
                                minStok: widget.satDasar == null
                                    ? int.parse(txtStokMin.text)
                                    : 0,
                                hargaJual: double.parse(txtHjual.text),
                                hargaPokok: double.parse(txtHpokok.text),
                                barcode: txtBarcode.text);

                            Navigator.pop(context, satProduk);
                          }
                        },
                        caption: "KONFIRMASI",
                        width: 220,
                      )
                    ],
                  ),
              ],
            ),
          )),
    );
  }
}
