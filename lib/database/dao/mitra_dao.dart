import 'dart:developer';

import 'package:mbspos/database/dbhelper.dart';
import 'package:mbspos/database/table_schema/mitra_table.dart';
import 'package:mbspos/models/data/mitra_model.dart';

/// Akses ke tabel mitra
class MitraDao {
  // -----------------------------------------
  // Menghapus mitra berdasarkan id
  // -----------------------------------------
  static Future<bool> delMitraById(int id) async {
    final db = await Dbhelper.database;

    final result =
        await db.delete(MitraTable.table, where: "id=?", whereArgs: [id]);
    return result == 1;
  }

  // ---------------------------
  /// Mengupdate data mitra
  // ---------------------------
  static Future<bool> updateMitra(MitraModel data) async {
    final db = await Dbhelper.database;

    log("data ${data.toMap().toString()}");

    final result = await db.update(MitraTable.table, data.toMapForUpdate(),
        where: "id=?", whereArgs: [data.id]);
    log("result : ${result.toString()}");

    return result == 1;
  }

  // -------------------------------------
  /// Menghapus semua data tabel mitra
  // -------------------------------------
  static Future<void> delAllMitra() async {
    final db = await Dbhelper.database;
    await db.delete(MitraTable.table);
  }

  // -------------------------
  /// Menyimpan data mitra
  // -------------------------
  static Future<int?> saveMitra(MitraModel data) async {
    final db = await Dbhelper.database;

    return await db.insert(MitraTable.table, data.toMap());
  }

  // -----------------------------------------
  /// Mengambil daftar mitra menurut tipe
  // -----------------------------------------
  static Future<List<MitraModel>?> getAllMitra(String tipe) async {
    final db = await Dbhelper.database;
    final result =
        await db.query(MitraTable.table, where: "tipe=?", whereArgs: [tipe]);

    return result.map((e) => MitraModel.fromMap(e)).toList();
  }
}
