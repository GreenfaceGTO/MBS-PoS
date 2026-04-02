import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/data/database/dao/item_dao.dart';
import 'package:mbspos/data/database/dao/mitra_dao.dart';
import 'package:mbspos/data/database/dao/ref_dao.dart';
import 'package:mbspos/data/repository/masterdata_repo.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/service/utils/cachemanager.dart';

class MasterProvider with ChangeNotifier, CacheManager {
  final _masterdataRepo = MasterdataRepo(
      refDao: RefDao(), mitraDao: MitraDao(), itemDao: ItemDao());

  // ---------------------------------
  // inisialisasi loading indicator
  // ---------------------------------
  bool _isLoading = false;

  // ------------------------------
  /// inisialisasi awal tab index
  // ------------------------------
  String _selectedRef = "Satuan";

  // ------------------------------------------------------------
  /// deklarasi variabel daftar untuk menampung data ref yang
  /// diloading dari db
  // ------------------------------------------------------------
  List<String> _lstRef = [];

  // ------------------------------------------------------------
  /// deklarasi variabel daftar untuk menampung data supplier
  /// atau pelanggan
  // ------------------------------------------------------------
  List<MitraModel> _lstMitra = [];

  // -------------------------------------------
  /// deklarasi variabel daftar nama tab menu
  // -------------------------------------------
  List<String> lstRefPage = [
    "Satuan",
    "Kategori",
    "Merek",
    "Supplier",
    "Pelanggan"
  ];

  // ---------------------------------------------------------
  /// metode untuk mengambil tab yang tersimpan saat pertama
  /// halaman yang menggunakan provider ini dibuka
  // ---------------------------------------------------------
  void init() {
    String? currentTab = selectedRefTabMenu;
    if (currentTab != null) {
      _selectedRef = currentTab;
      notifyListeners();
    }
  }

  // -------------------------
  /// getter tab menu index
  // -------------------------
  String get selectedRef => _selectedRef;

  // -----------------------------------------------
  /// Mengambil posisi index dari menu referensi
  // -----------------------------------------------
  int get tabIndex {
    int index = lstRefPage.indexOf(_selectedRef);
    if (index < 0) {
      return 0;
    }
    return index;
  }

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

  // -----------------------------
  /// getter daftar referensi
  // -----------------------------
  List<String> get lstRef => _lstRef;

  // ---------------------------
  /// getter daftar mitra
  // ---------------------------
  List<MitraModel> get lstMitra => _lstMitra;

  // ----------------------------
  /// setter saat tab dipilih
  // ----------------------------
  void onTabChange(String selectedPage) async {
    onRefTabSelected(selectedPage);
    _selectedRef = selectedPage;
    if (lstRefPage.indexOf(selectedPage) < 3) {
      await getRef();
    } else {
      await getMitra();
    }
    notifyListeners();
  }

  // ------------------------------------------------------
  /// Metode untuk mengambil data referensi menurut tipe
  // ------------------------------------------------------
  Future<void> getRef() async {
    String tipe = selectedRef.toLowerCase();
    log(tipe);
    final result = await _masterdataRepo.getAllRef(tipe);
    _lstRef.clear();
    _lstRef = result;
    _lstRef.sort(
      (a, b) => a.compareTo(b),
    );
    notifyListeners();
  }

  // -------------------------------
  /// Metode simpan data referensi
  // -------------------------------
  Future<void> saveRef(String namaRef) async {
    setLoading(true);
    try {
      int id =
          await _masterdataRepo.addNewRef(selectedRef.toLowerCase(), namaRef);

      if (id > 0) {
        lstRef.add(namaRef);
        notifyListeners();
      }
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // -------------------------------
  /// Metode hapus data referensi
  // -------------------------------
  Future<void> deleteRef(String namaRef) async {
    setLoading(true);
    try {
      bool done =
          await _masterdataRepo.delRef(selectedRef.toLowerCase(), namaRef);

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

  // ---------------------------
  /// Metode fetch data mitra
  // ---------------------------
  Future<void> getMitra() async {
    String tipe = selectedRef.toLowerCase();
    final result = await _masterdataRepo.getAllMitra(tipe);

    log(result.toString());
    _lstMitra.clear();
    if (result.isNotEmpty) {
      _lstMitra = result;
      _lstMitra.sort(
        (a, b) => a.nama!.compareTo(b.nama!),
      );
      notifyListeners();
    }
  }

  // ----------------------------
  /// Metode simpan data mitra
  // ----------------------------
  Future<void> saveMitra(MitraModel mitra) async {
    setLoading(true);
    try {
      int id = await _masterdataRepo.saveNewMitra(mitra);
      if (id > 0) {
        mitra.id = id;
        _lstMitra.add(mitra);
        notifyListeners();
      }
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // -----------------------------
  /// Metode update data mitra
  // -----------------------------
  Future<void> updateMitra(MitraModel data) async {
    setLoading(true);
    try {
      bool done = await _masterdataRepo.updateMitra(data);
      if (done) {
        log("refetching...");
        await getMitra();
      }
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  // ----------------------------
  /// Metode hapus data mitra
  // ----------------------------
  Future<void> delMitra(int id) async {
    setLoading(true);
    try {
      bool done = await _masterdataRepo.delMitra(id);

      if (done) {
        _lstMitra.removeWhere((e) => e.id == id);
        notifyListeners();
      }
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }
}
