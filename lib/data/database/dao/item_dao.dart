import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/item_table.dart';
import 'package:mbspos/data/database/table_schema/itemsat_table.dart';
import 'package:mbspos/models/data/item_model.dart';

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
          await txn.insert(ItemSatTable.table, satuan.toDb());
        }

        return itemId;
      });
    } catch (e) {
      throw Exception("DAO error : $e");
    }
  }

  // ----------------------------
  /// Mengambil daftar produk
  // ----------------------------
  static Future<List<ItemModel>?> getAllProduk() async {
    final db = await Dbhelper.database;
    try {
      final result = await db.query(ItemTable.table);
      if (result.isEmpty) {
        return null;
      }
      return result.map((e) => ItemModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception('DAO error : $e');
    }
  }
}
