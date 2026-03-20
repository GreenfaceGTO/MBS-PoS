import 'package:mbspos/database/dbhelper.dart';
import 'package:mbspos/database/table_schema/usaha_table.dart';
import 'package:mbspos/models/data/usaha_model.dart';

class UsahaDao {
  // -----------------------
  /// Mengambil data usaha
  // -----------------------
  static Future<List<UsahaModel>?> getDataUsaha() async {
    final db = await Dbhelper.database;
    final result = await db.query(UsahaTable.table, limit: 1);

    return result.map((e) => UsahaModel.fromMap(e)).toList();
  }

  // -----------------------
  // Menyimpan data usaha
  // -----------------------
  static Future<void> saveDataUsaha({required UsahaModel data}) async {
    final db = await Dbhelper.database;
    await db.insert(UsahaTable.table, data.toMap());
  }
}
