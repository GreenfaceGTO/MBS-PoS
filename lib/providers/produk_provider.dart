import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/database/dao/item_dao.dart';
import 'package:mbspos/database/dao/mitra_dao.dart';
import 'package:mbspos/database/dao/ref_dao.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/utils/global_enums.dart';

class ProdukProvider with ChangeNotifier {
  // --------------------------------
  /// deklarasi variabel loading
  // --------------------------------
  bool _isLoading = false;

  // ------------------------
  /// getter status loading
  // ------------------------
  bool get isLoading => _isLoading;

  // ------------------------------
  /// setter indicator loading
  // ------------------------------
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // ---------------------------------
  /// deklarasi variabel lokal produk
  // ---------------------------------
  List<ItemModel> _lstProduk = [];

  // ------------------------
  /// getter daftar produk
  // ------------------------
  List<ItemModel> get lstProduk => _lstProduk;

  // ------------------------------
  /// metode fetch daftar produk
  // ------------------------------
  Future<void> getAllProduk() async {
    setLoading(true);
    try {
      log("$runtimeType : fetching produk...");
      final result = await ItemDao.getAllProduk();
      if (result != null) {
        _lstProduk = result;
      }
    } catch (e) {
      log("$runtimeType : ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // -------------------------------------------
  /// Menampilkan form input referensi baru
  // -------------------------------------------
  Future<String?> addNewRef(BuildContext context,
      {required String tipeRef}) async {
    String? result = await showDialog(
        context: context,
        builder: (ctx) {
          TextEditingController txtRef = TextEditingController();
          return AlertDialog(
            title: Text("$tipeRef Baru"),
            content: TextFormField(
              controller: txtRef,
              autofocus: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) return "Isi nama satuan baru";
                return null;
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (txtRef.text.isNotEmpty) {
                      Navigator.pop(ctx, txtRef.text);
                    }
                  },
                  child: const Text("SIMPAN")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("BATAL"))
            ],
          );
        });
    log(result.toString());
    if (result != null) {
      try {
        bool done = await RefDao.saveRef(tipeRef.toLowerCase(), result);
        if (done) {
          return result;
        }
      } catch (e) {
        if (context.mounted) {
          showMessage(context, message: e.toString(), mode: MessageMode.error);
        }
      }
    }
    return null;
  }

  // --------------------------------------------
  /// Metode untuk mengambil data referensi
  // --------------------------------------------
  Future<List<String>?> getReferensi({required String tipe}) async {
    setLoading(true);
    try {
      return await RefDao.getRefByTipe(tipe);
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
    return null;
  }

  Future<List<MitraModel>> getMitra({required String tipe}) async {
    setLoading(true);
    try {
      return await MitraDao.getAllMitra(tipe);
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
    return [];
  }
}
