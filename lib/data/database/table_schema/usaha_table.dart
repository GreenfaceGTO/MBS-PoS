class UsahaTable {
  static const table = 'tb_usaha';

  // ---------------------
  // Query create table
  // ---------------------
  // TODO : Tambahkah field untuk kode reseler.
  static const create = '''CREATE TABLE $table (
    nama_usaha TEXT,
    alamat     TEXT,
    no_telp    TEXT,
    email      TEXT,
    user_name  TEXT,
    password   TEXT
);
''';
}
