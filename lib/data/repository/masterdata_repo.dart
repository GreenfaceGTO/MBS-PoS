import 'dart:developer';

import 'package:mbspos/data/database/dao/item_dao.dart';
import 'package:mbspos/data/database/dao/mitra_dao.dart';
import 'package:mbspos/data/database/dao/ref_dao.dart';
import 'package:mbspos/data/database/dao/usaha_dao.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';
import 'package:mbspos/models/data/usaha_model.dart';

class MasterdataRepo {
  final RefDao refDao;
  final MitraDao mitraDao;
  final ItemDao itemDao;
  final UsahaDao usahaDao;

  MasterdataRepo(
      {required this.refDao,
      required this.mitraDao,
      required this.itemDao,
      required this.usahaDao});

  // -----------------------------
  // DATA USAHA
  // -----------------------------
  // =============Mengambil data usaha=============
  Future<UsahaModel?> getDataUsaha() async {
    try {
      return await usahaDao.getDataUsaha();
    } catch (e) {
      throw Exception(e);
    }
  }

  // ---------------------------------
  // DATA REFERENSI
  // ---------------------------------

  // =============Menghapus data referensi=============
  Future<bool> delRef(String tipe, String namaRef) async {
    try {
      return await refDao.delRef(tipe, namaRef);
    } catch (e) {
      throw Exception('Gagal menghapus data $tipe');
    }
  }

  // ===========Menyimpan data referensi===========
  Future<int> addNewRef(String tipe, String data) async {
    try {
      return await refDao.saveRef(tipe, data);
    } catch (e) {
      throw Exception('Gagal menyimpan data $tipe');
    }
  }

  // ============Mengambil data referensi menurut tipe============
  Future<List<String>> getAllRef(String tipe) async {
    try {
      return await refDao.getRefByTipe(tipe);
    } catch (e) {
      throw Exception('Gagal mengambil data referensi $tipe');
    }
  }

  // -------------------------
  // DATA MITRA
  // -------------------------

  // ===============Mengambil seluruh data mitra===============
  Future<List<MitraModel>> getAllMitra(String tipe) async {
    try {
      return await mitraDao.getAllMitra(tipe);
    } catch (e) {
      throw Exception('Gagal mengambil data mitra $tipe');
    }
  }

  // =============Menambah data mitra baru=============
  Future<int> addNewMitra(MitraModel data) async {
    try {
      return await mitraDao.saveMitra(data);
    } catch (e) {
      log(e.toString());
      throw Exception('Gagal menyimpan data ${data.tipe}');
    }
  }

  // ============Mengupdate data mitra============
  Future<bool> updateMitra(MitraModel data) async {
    try {
      return await mitraDao.updateMitra(data);
    } catch (e) {
      throw Exception('Gagal mengupdate data ${data.tipe}');
    }
  }

  // ==========Menghapus data mitra==========
  Future<bool> delMitra(int id) async {
    try {
      return await mitraDao.delMitraById(id);
    } catch (e) {
      throw Exception('Gagal menghapus');
    }
  }

  // --------------------------------
  // DATA PRODUK
  // --------------------------------

  // ============Update Status============
  Future<bool> updateStatus(int id, bool newStatus) async {
    try {
      return await itemDao.updateStatus(id, newStatus);
    } catch (e) {
      throw Exception(e);
    }
  }

  // ============Update Stok============
  Future<bool> updateStok(int id, int stok) async {
    try {
      return await itemDao.updateStok(id, stok);
    } catch (e) {
      throw Exception(e);
    }
  }

  // ===============Mengambil seluruh data produk===============
  Future<List<ItemModel>> getAllProduk() async {
    try {
      return await itemDao.getAllProduk() ?? [];
    } catch (e) {
      throw Exception('Gagal mengambil daftar produk ${e.toString()}');
    }
  }

  // ===============Menyimpan data produk===============
  Future<ItemModel> saveNewProduk(ItemModel data) async {
    try {
      return await itemDao.simpanProduk(data);
    } catch (e) {
      throw Exception('Gagal menyimpan: ${e.toString()}');
    }
  }

  // ==============Menghapus produk dari master data==============
  Future<bool> delProduk(int id) async {
    try {
      return await itemDao.deleteProduk(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  // ============Menyimpan update data produk============
  Future<ItemModel> updateProduk(ItemModel item) async {
    try {
      return await itemDao.updateProduk(item);
    } catch (e) {
      throw Exception(e);
    }
  }
}
