import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/ref_table.dart';

/// Akses ke tabel referensi
class RefDao {
  // ---------------------------
  // Menghapus data referensi
  // ---------------------------
  static Future<bool> delRef(String tipe, String namaRef) async {
    final db = await Dbhelper.database;
    try {
      final result = await db.delete(RefTable.table,
          where: "nama_ref=? and tipe=?", whereArgs: [namaRef, tipe]);
      return result > 0;
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // -------------------------
  // Menyimpan data referensi
  // -------------------------
  static Future<int> saveRef(String tipe, String namaRef) async {
    final db = await Dbhelper.database;
    Map<String, String> data = {"nama_ref": namaRef, "tipe": tipe};
    try {
      return await db.insert(RefTable.table, data);
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // ----------------------------------------
  // Mengambil data referensi menurut tipe
  // ----------------------------------------
  static Future<List<String>> getRefByTipe(String tipe) async {
    final db = await Dbhelper.database;
    try {
      final result = await db.query(RefTable.table,
          where: "tipe=?", whereArgs: [tipe], orderBy: 'nama_ref ASC');

      return result.map((e) => e['nama_ref'] as String).toList();
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }
}
