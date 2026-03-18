class TransDetailTable {
  static const table = 'tbl_trxdetail';

  static const create = '''CREATE TABLE $table (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_header INTEGER,
    id_item   INTEGER,
    jumlah    INTEGER,
    harga     REAL    DEFAULT 0,
    potongan  REAL    DEFAULT 0,
    FOREIGN KEY (
        id_item
    )
    REFERENCES tb_itemsat (id) ON DELETE CASCADE,
    FOREIGN KEY (
        id_header
    )
    REFERENCES tb_trxhd (id) ON DELETE CASCADE
);
''';
}
