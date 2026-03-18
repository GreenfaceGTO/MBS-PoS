class TransHeaderTable {
  static const table = 'tb_trxheader';

  static const create = '''CREATE TABLE $table (
    id          INTEGER  PRIMARY KEY AUTOINCREMENT,
    tanggal     DATETIME,
    no_bukti    TEXT,
    tipe        TEXT     DEFAULT 'pembelian'
                         CHECK (tipe IN ('pembelian', 'penjualan', 'opname', 'keluar', 'masuk') ),
    id_mitra    INTEGER,
    total       REAL     DEFAULT 0,
    pot_faktur  REAL     DEFAULT 0,
    total_akhir REAL     DEFAULT 0,
    jenis_bayar TEXT     DEFAULT 'tunai'
                         CHECK (jenis_bayar IN ('tunai', 'kredit', 'qris', 'transfer') ),
    keterangan  TEXT,
    FOREIGN KEY (
        id_mitra
    )
    REFERENCES tb_mitra (id) ON DELETE CASCADE
);
''';
}
