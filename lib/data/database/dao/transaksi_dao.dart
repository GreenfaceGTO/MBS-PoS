import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/transheader_table.dart';
import 'package:mbspos/models/data/transaksi_model.dart';

class TransaksiDao {
  // ======Mengambil daftar transaksi menurut tipe======
  Future<List<TransaksiModel>> getTransaksi(String tipe) async {
    final db = await Dbhelper.database;
    try {
      final result = await db
          .query(TransHeaderTable.table, where: 'tipe=?', whereArgs: [tipe]);
      return result.map((e) => TransaksiModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
