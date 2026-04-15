import 'package:mbspos/data/database/table_schema/itemsat_table.dart';

class ItemTable {
  static const tableSatuan = ItemSatTable.table;
  static const table = 'tb_item';

  static const create = '''CREATE TABLE $table (
    id          INTEGER        PRIMARY KEY AUTOINCREMENT,
    no_sku      TEXT,
    nama_produk TEXT,
    merek       TEXT,
    kategori    TEXT,
    supplier    TEXT,
    stok        INTEGER        DEFAULT 0,
    min_stok    INTEGER        DEFAULT 0,
    aktif       INTEGER (1, 1) DEFAULT (1) 
);
''';
}
