// ------------------------------------------
/// Query create tabel master nama item
// ------------------------------------------
const String qryCreateTbItem = '''
CREATE TABLE tb_item (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    no_sku      TEXT,
    nama_produk TEXT,
    merek       TEXT,
    kategori    TEXT,
    stok        INTEGER DEFAULT 0,
    min_stok    INTEGER DEFAULT 0
)
''';

// -------------------------------------------------
/// Query create tabel item satuan dan konversi
// -------------------------------------------------
const String qryCreateTbItemSat = '''CREATE TABLE tb_itemsat (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_produk   INTEGER,
    satuan      TEXT,
    isi         INTEGER DEFAULT 1,
    tipe        TEXT    DEFAULT 'D',
    barcode     TEXT,
    harga_pokok REAL    DEFAULT 0,
    margin      REAL    DEFAULT 0,
    potongan    REAL    DEFAULT 0,
    FOREIGN KEY (
        id_produk
    )
    REFERENCES tb_item (id) ON DELETE CASCADE
);''';

// --------------------------------------------------------------
/// Query create tabel mitra (pelanggan ataupun supplier)
// --------------------------------------------------------------
const String qryCreateTbMitra = '''CREATE TABLE tb_mitra (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nama TEXT,
  alamat TEXT,
  no_telp TEXT,
  tipe TEXT CHECK(tipe IN ('pelanggan','supplier')) DEFAULT 'pelanggan',
  keterangan TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
)''';

// --------------------------------------
/// Query create tabel mutasi item
// --------------------------------------
const String qryCreateTbMutasiItem = '''CREATE TABLE tb_mutasiitem (
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

// ---------------------------------------------------------------------------------
/// Query create tabel referensi yang akan memuat satuan, kategori atau merek
// ---------------------------------------------------------------------------------
const String qryCreateTbRef = '''CREATE TABLE tb_ref (
    nama_ref TEXT NOT NULL,
    tipe TEXT DEFAULT 'satuan'
        CHECK (tipe IN ('satuan','merek','kategori')),
    PRIMARY KEY (nama_ref)
)''';

// ----------------------------------
/// Query create tabel saldo app
// ----------------------------------
const String qryCreateTbSaldoApp = '''CREATE TABLE tb_saldoapp (
    id         INTEGER  PRIMARY KEY AUTOINCREMENT,
    tanggal    DATETIME DEFAULT CURRENT_TIMESTAMP,
    keterangan TEXT,
    pos        TEXT     DEFAULT 'debet'
                        CHECK (pos IN ('debet', 'kredit') ),
    jumlah     REAL     DEFAULT 0
);
''';

// -----------------------------------------------------------------------------
/// Query create tabel detail untuk semua transaksi baik pembelian, penjualan,
/// stok opname, item masuk atau keluar
// -----------------------------------------------------------------------------
const String qryCreateTbTrxDtl = '''CREATE TABLE tb_trxdtl (
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

// -----------------------------------------------------------------------------
/// Query create tabel header untuk semua transaksi baik pembelian, penjualan,
/// stok opname, item masuk atau keluar
// -----------------------------------------------------------------------------
const String qryCreateTbTrxHd = '''CREATE TABLE tb_trxhd (
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
);''';

// -----------------------------------------------------------------------------
/// Query create tabel usaha untuk menampung identitas usaha, tabel ini hanya
/// akan berisi 1 data
// -----------------------------------------------------------------------------
const String qryCreateTbUsaha = '''CREATE TABLE tb_usaha (
    nama_usaha TEXT,
    alamat     TEXT,
    no_telp    TEXT,
    email      TEXT,
    user_name  TEXT,
    password   TEXT
);
''';
