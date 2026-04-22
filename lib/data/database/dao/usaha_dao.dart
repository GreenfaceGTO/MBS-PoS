import 'dart:developer';

import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/usaha_table.dart';
import 'package:mbspos/models/data/usaha_model.dart';

class UsahaDao {
  // -----------------------
  /// Mengambil data usaha
  // -----------------------
  // static Future<List<UsahaModel>?> getDataUsaha() async {
  Future<UsahaModel?> getDataUsaha() async {
    final db = await Dbhelper.database;
    try {
      final result = await db.query(UsahaTable.table, limit: 1);

      if (result.isEmpty) {
        return null;
      } else {
        return UsahaModel.fromMap(result[0]);
      }
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // -----------------------
  // Menyimpan data usaha
  // -----------------------
  static Future<void> saveDataUsaha({required UsahaModel data}) async {
    final db = await Dbhelper.database;
    try {
      final result = await db.insert(UsahaTable.table, data.toMap());
      log(result.toString());
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }

  // --------------------------
  // Menghapus data usaha
  // --------------------------
  static Future<bool> delDataUsaha() async {
    final db = await Dbhelper.database;
    try {
      return await db.delete(UsahaTable.table) > 0;
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }
}
