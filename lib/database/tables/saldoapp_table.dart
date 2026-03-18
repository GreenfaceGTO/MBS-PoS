class SaldoAppTable {
  static const table = 'tb_saldoapp';

  static const create = '''CREATE TABLE $table (
    id         INTEGER  PRIMARY KEY AUTOINCREMENT,
    tanggal    DATETIME DEFAULT CURRENT_TIMESTAMP,
    keterangan TEXT,
    pos        TEXT     DEFAULT 'debet'
                        CHECK (pos IN ('debet', 'kredit') ),
    jumlah     REAL     DEFAULT 0
);
''';
}
