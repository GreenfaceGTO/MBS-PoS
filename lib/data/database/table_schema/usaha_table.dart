class UsahaTable {
  static const table = 'tb_usaha';

  // ---------------------
  // Query create table
  // ---------------------
  static const create = '''CREATE TABLE tb_usaha (
    nama_usaha TEXT,
    alamat     TEXT,
    no_telp    TEXT,
    email      TEXT,
    user_name  TEXT,
    password   TEXT,
    kode_ref   TEXT (25) 
)
''';
}
