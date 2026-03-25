import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/database/dao/item_dao.dart';
import 'package:mbspos/database/dao/ref_dao.dart';
import 'package:mbspos/models/data/item_model.dart';

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
}
