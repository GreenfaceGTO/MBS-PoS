class MutasiItemTable {
  static const table = 'tb_mutasiitem';

  static const create = '''CREATE TABLE $table (
    id         INTEGER  PRIMARY KEY AUTOINCREMENT,
    tanggal    DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_item    INTEGER,
    jumlah     INTEGER  DEFAULT 0,
    keterangan TEXT,
    FOREIGN KEY (
        id_item
    )
    REFERENCES tb_item (id) ON DELETE CASCADE
);
''';
}
