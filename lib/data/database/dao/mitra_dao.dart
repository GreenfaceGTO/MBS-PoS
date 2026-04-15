import 'dart:developer';

import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/mitra_table.dart';
import 'package:mbspos/models/data/mitra_model.dart';

/// Akses ke tabel mitra
class MitraDao {
  // -----------------------------------------
  // Menghapus mitra berdasarkan id
  // -----------------------------------------
  static Future<bool> delMitraById(int id) async {
    final db = await Dbhelper.database;
    try {
      final result =
          await db.delete(MitraTable.table, where: "id=?", whereArgs: [id]);
      return result == 1;
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // ---------------------------
  /// Mengupdate data mitra
  // ---------------------------
  static Future<bool> updateMitra(MitraModel data) async {
    final db = await Dbhelper.database;

    log("data ${data.toMap().toString()}");
    try {
      final result = await db.update(MitraTable.table, data.toMapForUpdate(),
          where: "id=?", whereArgs: [data.id]);
      log("result : ${result.toString()}");

      return result == 1;
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // -------------------------------------
  /// Menghapus semua data tabel mitra
  // -------------------------------------
  static Future<void> delAllMitra() async {
    final db = await Dbhelper.database;
    try {
      await db.delete(MitraTable.table);
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // -------------------------
  /// Menyimpan data mitra
  // -------------------------
  static Future<int> saveMitra(MitraModel data) async {
    final db = await Dbhelper.database;

    try {
      return await db.insert(MitraTable.table, data.toMap());
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // -----------------------------------------
  /// Mengambil daftar mitra menurut tipe
  // -----------------------------------------
  static Future<List<MitraModel>> getAllMitra(String tipe) async {
    final db = await Dbhelper.database;
    try {
      final result =
          await db.query(MitraTable.table, where: "tipe=?", whereArgs: [tipe]);

      return result.map((e) => MitraModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }
}
