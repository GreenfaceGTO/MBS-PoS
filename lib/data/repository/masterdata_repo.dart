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

// ============REFERENSI============

  // Menghapus data referensi
  // ---------------------------
  Future<bool> delRef(String tipe, String namaRef) async {
    return await RefDao.delRef(tipe, namaRef);
  }

  // -----------------------------
  // Menyimpan data referensi
  // -----------------------------
  Future<int> addNewRef(String tipe, String data) async {
    return await RefDao.saveRef(tipe, data);
  }

  // -----------------------------------------
  // Mengambil data referensi menurut tipe
  // -----------------------------------------
  Future<List<String>> getAllRef(String tipe) async {
    return await RefDao.getRefByTipe(tipe);
  }

  // =========MITRA=========

  // ------------------------------
  // Mengambil seluruh data mitra
  // ------------------------------
  Future<List<MitraModel>> getAllMitra(String tipe) async {
    return await MitraDao.getAllMitra(tipe);
  }

  // ---------------------------
  // Menambah data mitra baru
  // ---------------------------
  Future<int> addNewMitra(MitraModel data) async {
    return await MitraDao.saveMitra(data);
  }

  // -------------------------
  // Mengupdate data mitra
  // -------------------------
  Future<bool> updateMitra(MitraModel data) async {
    return await MitraDao.updateMitra(data);
  }

  // ----------------------
  // Menghapus data mitra
  // ----------------------
  Future<bool> delMitra(int id) async {
    return await MitraDao.delMitraById(id);
  }

  // ============PRODUK====================

  // ----------------------------------
  // Mengambil seluruh data produk
  // ----------------------------------
  Future<List<ItemModel>> getAllProduk() async {
    return await ItemDao.getAllProduk() ?? [];
  }
}
