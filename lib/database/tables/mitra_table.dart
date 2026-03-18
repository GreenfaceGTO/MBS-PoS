class MitraTable {
  static const table = 'tb_mitra';

  static const create = '''CREATE TABLE $table (
    id         INTEGER  PRIMARY KEY AUTOINCREMENT,
    nama       TEXT,
    alamat     TEXT,
    no_telp    TEXT,
    tipe       TEXT     CHECK (tipe IN ('pelanggan', 'supplier') ) 
                        DEFAULT 'pelanggan',
    keterangan TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
''';
}
