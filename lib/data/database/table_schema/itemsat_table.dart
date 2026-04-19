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
    potongan    REAL    DEFAULT 0,
    FOREIGN KEY (
        id_produk
    )
    REFERENCES tb_item (id) ON DELETE CASCADE
);
''';

//   static const updateSatuan = '''
//   INSERT INTO $table
//   (id,id_produk,satuan,isi,tipe,barcode,harga_pokok,harga_jual,potongan)
//   VALUES(?,?,?,?,?,?,?,?,?)
//   ON CONFLICT DO UPDATE SET
//   id_produk = excluded.id_produk,
//   satuan = excluded.satuan,
//   isi = excluded.isi,
//   tipe = excluded.tipe,
//   barcode = excluded.barcode,
//   harga_pokok = excluded.harga_pokok,
//   harga_jual = excluded.harga_jual,
//   potongan = excluded.potongan
// ''';
}
