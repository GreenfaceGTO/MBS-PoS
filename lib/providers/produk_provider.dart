import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/data/database/dao/item_dao.dart';
import 'package:mbspos/data/database/dao/mitra_dao.dart';
import 'package:mbspos/data/database/dao/ref_dao.dart';
import 'package:mbspos/data/repository/masterdata_repo.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/service/utils/global_enums.dart';

class ProdukProvider with ChangeNotifier {
  final MasterdataRepo _masterdataRepo = MasterdataRepo(
      refDao: RefDao(), mitraDao: MitraDao(), itemDao: ItemDao());

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
      final result = await _masterdataRepo.getAllProduk();
      _lstProduk = result;
      notifyListeners();
    } catch (e) {
      log("$runtimeType : ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // ------------------------------------
  /// variabel daftar referensi merek
  // ------------------------------------
  List<String> _lstMerek = [];

  // --------------------------------------
  /// setter daftar referensi merek
  // --------------------------------------
  Future<void> fetchMerek() async {
    setLoading(true);
    try {
      log("$runtimeType : fetching merek...");
      final result = await RefDao.getRefByTipe("merek");
      _lstMerek = result;
      notifyListeners();
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // ----------------------------------
  /// getter daftar referensi merek
  // ----------------------------------
  List<String> get lstMerek => _lstMerek;

  // -----------------------------
  /// variabel daftar kategori
  // -----------------------------
  List<String> _lstKategori = [];

  // --------------------------------------
  /// setter daftar referensi kategori
  // --------------------------------------
  Future<void> fetchKategori() async {
    setLoading(true);
    try {
      log("$runtimeType : fetching kategori...");
      final result = await RefDao.getRefByTipe("kategori");
      _lstKategori = result;

      notifyListeners();
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // -------------------------
  /// getter daftar kategori
  // -------------------------
  List<String> get lstKategori => _lstKategori;

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

  // -------------------------------------------
  /// Menampilkan form input referensi baru
  // -------------------------------------------
  Future<void> addNewRef(BuildContext context,
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
        bool done =
            await _masterdataRepo.addNewRef(tipeRef.toLowerCase(), result) > 0;
        RefDao.saveRef(tipeRef.toLowerCase(), result);
        if (done) {
          if (tipeRef.toLowerCase() == "merek") {
            _lstMerek.add(result);
          }
          notifyListeners();
        }
      } catch (e) {
        if (context.mounted) {
          showMessage(context, message: e.toString(), mode: MessageMode.error);
        }
      }
    }
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
