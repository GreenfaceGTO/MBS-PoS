import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/data/database/dao/item_dao.dart';
import 'package:mbspos/data/database/dao/mitra_dao.dart';
import 'package:mbspos/data/database/dao/ref_dao.dart';
import 'package:mbspos/data/repository/masterdata_repo.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/service/utils/cachemanager.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';

class MasterProvider with ChangeNotifier, CacheManager {
  final _masterdataRepo = MasterdataRepo(
      refDao: RefDao(), mitraDao: MitraDao(), itemDao: ItemDao());

  // ===========marking inisialisasi provider===========
  bool _isInitialized = false;

  // ==============deklarasi variabel==============
  List<String> _daftarMerek = [];
  List<String> _daftarKategori = [];
  List<String> _daftarSatuan = [];
  List<ItemModel> _daftarProduk = [];
  List<ItemModel> _lstFilterProduk = [];
  List<MitraModel> _daftarSupplier = [];
  List<MitraModel> _daftarPelanggan = [];
  String _selectedRef = "Satuan";

  // ================getter================
  List<String> get daftarMerek => _daftarMerek;
  List<String> get daftarKategori => _daftarKategori;
  List<String> get daftarSatuan => _daftarSatuan;
  List<ItemModel> get daftarProduk => _daftarProduk;
  List<ItemModel> get lstFilterProduk => _lstFilterProduk;
  List<MitraModel> get daftarSupplier => _daftarSupplier;
  List<MitraModel> get daftarPelanggan => _daftarPelanggan;

  String get selectedRef => _selectedRef;

  int get tabIndex {
    return lstRefPage.indexOf(_selectedRef);
  }

  // ===================Setter===================
  void selectTab(String tabName) {
    _selectedRef = tabName;
    notifyListeners();
  }

  // --------------------------
  // Metode
  // --------------------------
  // =============inisialisasi=============
  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;
    _daftarMerek = await _masterdataRepo.getAllRef("merek");
    _daftarKategori = await _masterdataRepo.getAllRef("kategori");
    _daftarSatuan = await _masterdataRepo.getAllRef("satuan");
    _daftarProduk = await _masterdataRepo.getAllProduk();
    _lstFilterProduk.addAll(_daftarProduk);
    _daftarSupplier = await _masterdataRepo.getAllMitra("supplier");
    _daftarPelanggan = await _masterdataRepo.getAllMitra("pelanggan");
    notifyListeners();
  }

  // ==========Menambahkan data referensi==========
  Future<void> addNewRef(
      BuildContext context, String tipe, String namaRef) async {
    try {
      int result = await _masterdataRepo.addNewRef(tipe.toLowerCase(), namaRef);
      log("add new result : ${result.toString()}");
      if (result > 0) {
        switch (tipe.toLowerCase()) {
          case "satuan":
            log("$runtimeType: refreshing satuan list...");
            _daftarSatuan.add(namaRef);
            _daftarSatuan.sort((a, b) => a.compareTo(b));
          case "kategori":
            log("$runtimeType : refreshing kategori list...");
            _daftarKategori.add(namaRef);
            _daftarKategori.sort((a, b) => a.compareTo(b));
          case "merek":
            log("$runtimeType : refreshing merek list...");
            _daftarMerek.add(namaRef);
            _daftarMerek.sort((a, b) => a.compareTo(b));
        }
        notifyListeners();
        log(_daftarSatuan.toString());
      }
    } catch (e) {
      showMessage(message: msgSafeFail, mode: MessageMode.error);
    }
  }

  // ============Menghapus data referensi============
  Future<void> deleteRef(String tipe, String namaRef) async {
    bool done = await _masterdataRepo.delRef(tipe, namaRef);
    if (done) {
      switch (tipe.toLowerCase()) {
        case 'satuan':
          _daftarSatuan
              .removeWhere((e) => e.toLowerCase() == namaRef.toLowerCase());

          break;
        case "kategori":
          _daftarKategori
              .removeWhere((e) => e.toLowerCase() == namaRef.toLowerCase());

        case "merek":
          _daftarMerek
              .removeWhere((e) => e.toLowerCase() == namaRef.toLowerCase());
      }
      notifyListeners();
    }
  }

  // ========Menambah data mitra baru baik supplier maupun pelanggan========
  Future<void> addNewMitra(String tipe, MitraModel data) async {
    int id = await _masterdataRepo.addNewMitra(data);
    if (id > 0) {
      data.id = id;
      switch (data.tipe!.toLowerCase()) {
        case "supplier":
          log("$runtimeType : Updating supplier on local...");

          _daftarSupplier.add(data);
          _daftarSupplier.sort((a, b) => a.nama!.compareTo(b.nama!));
        case "pelanggan":
          log("$runtimeType : Updating pelanggan on local...");
          _daftarPelanggan.add(data);
          _daftarPelanggan.sort((a, b) => a.nama!.compareTo(b.nama!));
      }
      notifyListeners();
    }
  }

  // =======Menghapus mitra baik supplier atau pelanggan=======
  Future<void> updateMitra(MitraModel data) async {
    bool done = await _masterdataRepo.updateMitra(data);
    if (done) {
      switch (data.tipe!.toLowerCase()) {
        case "supplier":
          _daftarSupplier.removeWhere((e) => e.id == data.id);
          _daftarSupplier.add(data);
          _daftarSupplier.sort((a, b) => a.nama!.compareTo(b.nama!));
        case "pelanggan":
          _daftarPelanggan.removeWhere((e) => e.id == data.id);
          _daftarPelanggan.add(data);
          _daftarPelanggan.sort((a, b) => a.nama!.compareTo(b.nama!));
      }

      notifyListeners();
    }
  }

  // ==========Menghapus mitra baik supplier maupun pelanggan==========
  Future<void> delMitra(MitraModel data) async {
    bool done = await _masterdataRepo.delMitra(data.id!);
    if (done) {
      switch (data.tipe!.toLowerCase()) {
        case 'supplier':
          _daftarSupplier.removeWhere((e) => e.id == data.id);
        case 'pelanggan':
          _daftarPelanggan.removeWhere((e) => e.id == data.id);
      }
      notifyListeners();
    }
  }

  // ==============Menyimpan produk baru==============
  Future<bool> addNewProduk(ItemModel newItem) async {
    log(newItem.toMap().toString());
    var result = await _masterdataRepo.saveNewProduk(newItem);

    _daftarProduk.add(result);
    notifyListeners();
    _rebuildFilterList();
    return true;
  }

  // ==============memperbaharui [lstFilterProduk] saat ada perubahan di [daftarProduk]
  void _rebuildFilterList() async {
    _lstFilterProduk.clear();
    _lstFilterProduk.addAll(_daftarProduk);
    notifyListeners();
  }

  // ==========Menghapus data produk==========
  Future<void> deleteProduk(int id) async {
    bool done = await _masterdataRepo.delProduk(id);
    if (done) {
      _daftarProduk.removeWhere((e) => e.id == id);
      notifyListeners();
      _rebuildFilterList();
    }
  }

  // ===========Menyimpan update produk===========
  Future<bool> updateProduk(ItemModel updatedData) async {
    try {
      final result = await _masterdataRepo.updateProduk(updatedData);
      int idx = daftarProduk.indexWhere((e) => e.id == result.id);
      _daftarProduk[idx] = result;
      notifyListeners();
      _rebuildFilterList();
      return true;
    } catch (e) {
      log(e.toString());
      showMessage(message: "Gagal ${e.toString()}");
    }
    return false;
  }

  // =============Menyimpan update stok=============
  Future<void> updateStok(int idProduk, int newStok) async {
    try {
      if (await _masterdataRepo.updateStok(idProduk, newStok)) {
        int idx = daftarProduk.indexWhere((e) => e.id == idProduk);
        _daftarProduk[idx].stok = newStok;
        notifyListeners();
        _rebuildFilterList();
      }
    } catch (e) {
      showMessage(message: "Gagal ${e.toString()}");
    }
  }

  // ==============Update Status Item==============
  Future<void> updateStatusItem(int idProduk, bool newStatus) async {
    try {
      if (await _masterdataRepo.updateStatus(idProduk, newStatus)) {
        int idx = daftarProduk.indexWhere((e) => e.id == idProduk);
        log(newStatus.toString());
        _daftarProduk[idx].aktif = newStatus ? 1 : 0;

        notifyListeners();
        _rebuildFilterList();
      } else {}
    } catch (e) {
      showMessage(message: "Gagal ${e.toString()}");
    }
  }

  // ==========Fiture pencarian item==========
  void searchProduk(String query) {
    String kunci = query.toLowerCase();
    if (kunci.isNotEmpty) {
      var result = _daftarProduk.where((e) {
        final nama = e.namaProduk!.toLowerCase();
        final merek = e.merek!.toLowerCase();
        return nama.contains(kunci) ||
            merek.contains(kunci) ||
            e.kategori!.contains(kunci);
      });
      _lstFilterProduk.clear();
      _lstFilterProduk.addAll(result);
    } else {
      _lstFilterProduk.clear();
      _lstFilterProduk.addAll(daftarProduk);
    }
    notifyListeners();
  }
}
