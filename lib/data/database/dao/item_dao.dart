import 'dart:developer';

import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/item_table.dart';
import 'package:mbspos/data/database/table_schema/itemsat_table.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/satitem_model.dart';

class ItemDao {
  final dbManager = Dbhelper();

  // -------------------------------
  /// Menyimpan data produk
  // -------------------------------
  static Future<int> simpanProduk(ItemModel data) async {
    final db = await Dbhelper.database;
    try {
      return db.transaction<int>((txn) async {
        // insert data produk (Header)
        final itemId = await txn.insert(ItemTable.table, data.toDb());

        // insert data satuan dasar
        for (final satuan in data.satuan) {
          satuan.idProduk = itemId;
          log(satuan.toMap().toString());
          await txn.insert(ItemSatTable.table, satuan.toDb());
        }

        return itemId;
      });
    } catch (e) {
      throw Exception("DAO error : $e");
    }
  }

  /// ==========Mengambil daftar produk==========
  static Future<List<ItemModel>?> getAllProduk() async {
    final db = await Dbhelper.database;
    try {
      final result = await db.query(ItemTable.table);
      if (result.isEmpty) {
        return null;
      }
      List<ItemModel> lstItem =
          result.map((e) => ItemModel.fromMap(e)).toList();
      for (var item in lstItem) {
        final satuan = await getSatuanById(item.id!);
        if (satuan.isNotEmpty) {
          item.satuan = satuan;
        }
      }

      return lstItem;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// =============Mengambil daftar satuan berdasarkan id produk=============
  static Future<List<SatitemModel>> getSatuanById(int produkId) async {
    final db = await Dbhelper.database;
    log("Id produk : $produkId");
    try {
      final satuan = await db.query(ItemSatTable.table,
          where: 'id_produk=?', whereArgs: [produkId], orderBy: 'tipe');
      List<SatitemModel> result =
          satuan.map((sat) => SatitemModel.fromMap(sat)).toList();
      log(result.map((e) => e.toMap()).toList().toString());
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
