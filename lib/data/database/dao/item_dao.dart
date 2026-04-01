import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/item_table.dart';
import 'package:mbspos/models/data/item_model.dart';

class ItemDao {
  final dbManager = Dbhelper();

  // -------------------------------
  /// Menyimpan data produk
  // -------------------------------
  Future<int> saveProduk(ItemModel data) async {
    final db = await Dbhelper.database;
    final id = await db.insert(ItemTable.table, data.toMap());

    final String sku = "SKU-${id.toString().padLeft(4, '0')}";

    await db.update(ItemTable.table, {"no_sku": sku},
        where: "id=?", whereArgs: [id]);
    return id;
  }

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
