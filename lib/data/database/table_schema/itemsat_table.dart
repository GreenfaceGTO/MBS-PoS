class ItemSatTable {
  static const table = 'tb_itemsat';

  static const create = '''CREATE TABLE tb_itemsat (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_produk   INTEGER,
    satuan      TEXT,
    isi         INTEGER DEFAULT 1,
    tipe        TEXT    DEFAULT 'D',
    barcode     TEXT,
    harga_pokok REAL    DEFAULT 0,
    harga_jual  REAL    DEFAULT (0),
    margin      REAL    DEFAULT 0,
    potongan    REAL    DEFAULT 0,
    FOREIGN KEY (
        id_produk
    )
    REFERENCES tb_item (id) ON DELETE CASCADE
);
''';
}
