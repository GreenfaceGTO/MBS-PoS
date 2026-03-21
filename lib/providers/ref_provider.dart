import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/database/dao/ref_dao.dart';
import 'package:mbspos/utils/cachemanager.dart';

class RefProvider with ChangeNotifier, CacheManager {
  // ---------------------------------
  // inisialisasi loading indicator
  // ---------------------------------
  bool _isLoading = false;

  // ------------------------------
  /// inisialisasi awal tab index
  // ------------------------------
  String _selectedRef = "Satuan";

  // ---------------------------------------------------
  /// inisialisasi untuk mengambil tab yang tersimpan
  // ---------------------------------------------------
  void init() {
    String? currentTab = selectedRefTabMenu;

    if (currentTab != null) {
      _selectedRef = currentTab;
      notifyListeners();
      getRef();
    }
  }

  // -------------------------
  /// getter tab menu index
  // -------------------------
  String get selectedRef => _selectedRef;

  // ----------------------------------
  /// setter loading indicator status
  // ----------------------------------
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ----------------------------------
  /// getter loading indicator status
  // ----------------------------------
  bool get isLoading => _isLoading;

  // ------------------------
  /// daftar nama tab menu
  // ------------------------
  List<String> lstRefPage = [
    "Satuan",
    "Kategori",
    "Merek",
    "Supplier",
    "Pelanggan"
  ];

  // ----------------------------
  /// setter saat tab dipilih
  // ----------------------------
  void onTabChange(String selectedPage) async {
    onRefTabSelected(selectedPage);
    _selectedRef = selectedPage;
    if (lstRefPage.indexOf(selectedPage) < 3) {
      await getRef();
    }
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  /// variabel daftar untuk menampung data ref yang diloading dari db
  // ---------------------------------------------------------------------
  List<String> _lstRef = [];

  // -----------------------------
  /// getter daftar referensi
  // -----------------------------
  List<String> get lstRef => _lstRef;

  // -----------------------------------------
  /// Mengambil data referensi menurut tipe
  // -----------------------------------------
  Future<void> getRef() async {
    String tipe = selectedRef.toLowerCase();
    log(tipe);
    final result = await RefDao.getRefByTipe(tipe);
    log("result : ${result.toString().toString()}");
    _lstRef.clear();
    if (result != null) {
      _lstRef = result;
      _lstRef.sort(
        (a, b) => a.compareTo(b),
      );

      notifyListeners();
    }
  }

  // -----------------------------
  /// Menyimpan data referensi
  // -----------------------------
  Future<void> saveRef(String namaRef) async {
    setLoading(true);
    try {
      bool done = await RefDao.saveRef(selectedRef.toLowerCase(), namaRef);
      if (done) {
        lstRef.add(namaRef);
        notifyListeners();
      }
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // ----------------------------
  /// Menghapus data referensi
  // ----------------------------
  Future<void> deleteRef(String namaRef) async {
    setLoading(true);
    try {
      bool done = await RefDao.delRef(selectedRef.toLowerCase(), namaRef);

      if (done) {
        lstRef.removeWhere((e) => e == namaRef);
        notifyListeners();
      }
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }
}
