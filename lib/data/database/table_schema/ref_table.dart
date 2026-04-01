class RefTable {
  static const table = "tb_ref";

  static const create = '''CREATE TABLE $table (
    nama_ref TEXT NOT NULL,
    tipe     TEXT DEFAULT 'satuan'
                  CHECK (tipe IN ('satuan', 'merek', 'kategori') ),
    PRIMARY KEY (
        nama_ref
    )
);
''';
}
