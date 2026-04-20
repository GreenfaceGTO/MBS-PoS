import 'dart:developer';

import 'package:mbspos/data/database/dao/item_dao.dart';
import 'package:mbspos/data/database/dao/mitra_dao.dart';
import 'package:mbspos/data/database/dao/ref_dao.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/mitra_model.dart';

class MasterdataRepo {
  final RefDao refDao;
  final MitraDao mitraDao;
  final ItemDao itemDao;

  MasterdataRepo(
      {required this.refDao, required this.mitraDao, required this.itemDao});

  // ---------------------------------
  // DATA REFERENSI
  // ---------------------------------

  // =============Menghapus data referensi=============
  Future<bool> delRef(String tipe, String namaRef) async {
    try {
      return await RefDao.delRef(tipe, namaRef);
    } catch (e) {
      throw Exception('Gagal menghapus data $tipe');
    }
  }

  // ===========Menyimpan data referensi===========
  Future<int> addNewRef(String tipe, String data) async {
    try {
      return await RefDao.saveRef(tipe, data);
    } catch (e) {
      throw Exception('Gagal menyimpan data $tipe');
    }
  }

  // ============Mengambil data referensi menurut tipe============
  Future<List<String>> getAllRef(String tipe) async {
    try {
      return await RefDao.getRefByTipe(tipe);
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
      return await MitraDao.getAllMitra(tipe);
    } catch (e) {
      throw Exception('Gagal mengambil data mitra $tipe');
    }
  }

  // =============Menambah data mitra baru=============
  Future<int> addNewMitra(MitraModel data) async {
    try {
      return await MitraDao.saveMitra(data);
    } catch (e) {
      log(e.toString());
      throw Exception('Gagal menyimpan data ${data.tipe}');
    }
  }

  // ============Mengupdate data mitra============
  Future<bool> updateMitra(MitraModel data) async {
    try {
      return await MitraDao.updateMitra(data);
    } catch (e) {
      throw Exception('Gagal mengupdate data ${data.tipe}');
    }
  }

  // ==========Menghapus data mitra==========
  Future<bool> delMitra(int id) async {
    try {
      return await MitraDao.delMitraById(id);
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
      return await ItemDao.updateStatus(id, newStatus);
    } catch (e) {
      throw Exception(e);
    }
  }

  // ============Update Stok============
  Future<bool> updateStok(int id, int stok) async {
    try {
      return await ItemDao.updateStok(id, stok);
    } catch (e) {
      throw Exception(e);
    }
  }

  // ===============Mengambil seluruh data produk===============
  Future<List<ItemModel>> getAllProduk() async {
    try {
      return await ItemDao.getAllProduk() ?? [];
    } catch (e) {
      throw Exception('Gagal mengambil daftar produk ${e.toString()}');
    }
  }

  // ===============Menyimpan data produk===============
  Future<ItemModel> saveNewProduk(ItemModel data) async {
    try {
      return await ItemDao.simpanProduk(data);
    } catch (e) {
      throw Exception('Gagal menyimpan: ${e.toString()}');
    }
  }

  // ==============Menghapus produk dari master data==============
  Future<bool> delProduk(int id) async {
    try {
      return await ItemDao.deleteProduk(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  // ============Menyimpan update data produk============
  Future<ItemModel> updateProduk(ItemModel item) async {
    try {
      return await ItemDao.updateProduk(item);
    } catch (e) {
      throw Exception(e);
    }
  }
}
