class UsahaTable {
  static const table = 'tb_usaha';

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
