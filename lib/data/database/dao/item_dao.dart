import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/item_table.dart';
import 'package:mbspos/models/data/item_model.dart';

class ItemDao {
  final dbManager = Dbhelper();

  // -------------------------------
  /// Menyimpan data produk
  // -------------------------------
  // Future<int> simpanProduk(ItemModel data) async {
  //   final db = await Dbhelper.database;
  //   return db.transaction<int>((txn) async {
  //     final itemId=await txn.insert(ItemTable.table, values)
  //   });
  // }

  // ----------------------------
  /// Mengambil daftar produk
  // ----------------------------
  static Future<List<ItemModel>?> getAllProduk() async {
    final db = await Dbhelper.database;

    final result = await db.query(ItemTable.table);
    if (result.isEmpty) {
      return null;
    }
    return result.map((e) => ItemModel.fromMap(e)).toList();
  }
}
