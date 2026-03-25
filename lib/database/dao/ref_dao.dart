import 'dart:developer';

import 'package:mbspos/database/dbhelper.dart';
import 'package:mbspos/database/table_schema/ref_table.dart';

/// Akses ke tabel referensi
class RefDao {
  // ---------------------------
  // Menghapus data referensi
  // ---------------------------
  static Future<bool> delRef(String tipe, String namaRef) async {
    final db = await Dbhelper.database;
    final result = await db.delete(RefTable.table,
        where: "nama_ref=? and tipe=?", whereArgs: [namaRef, tipe]);
    return result > 0;
  }

  // -------------------------
  // Menyimpan data referensi
  // -------------------------
  static Future<bool> saveRef(String tipe, String namaRef) async {
    final db = await Dbhelper.database;
    Map<String, String> data = {"nama_ref": namaRef, "tipe": tipe};
    log(data.toString());
    return await db.insert(RefTable.table, data) > 0;
  }

  // ----------------------------------------
  // Mengambil data referensi menurut tipe
  // ----------------------------------------
  static Future<List<String>?> getRefByTipe(String tipe) async {
    final db = await Dbhelper.database;
    final result = await db.query(RefTable.table,
        where: "tipe=?", whereArgs: [tipe], orderBy: 'nama_ref ASC');

    if (result.isEmpty) {
      return null;
    }
    return result.map((e) => e['nama_ref'] as String).toList();
  }
}
