import 'package:mbspos/database/dbhelper.dart';
import 'package:mbspos/database/table_schema/ref_table.dart';

class RefDao {
  // ----------------------------------------
  // Mengambil data referensi menurut tipe
  // ----------------------------------------
  Future<List<String>?> getRefByTipe(String tipe) async {
    final db = await Dbhelper.database;
    final result =
        await db.query(RefTable.table, where: "tipe=?", whereArgs: [tipe]);

    if (result.isEmpty) {
      return null;
    }
    return result.map((e) => e['nama_ref'] as String).toList();
  }
}
