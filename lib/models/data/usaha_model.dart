class UsahaModel {
  String? namaUsaha;
  String? alamat;
  String? noTelp;
  String? userName;
  String? password;

  UsahaModel(
      {this.namaUsaha, this.alamat, this.noTelp, this.userName, this.password});

  factory UsahaModel.fromMap(Map<String, dynamic> map) => UsahaModel(
      namaUsaha: map['nama_usaha'],
      alamat: map['alamat'],
      noTelp: map['no_telp'],
      userName: map['user_name'],
      password: map['password']);

  Map<String, dynamic> toMap() => {
        "nama_usaha": namaUsaha,
        "alamat": alamat,
        "no_telp": noTelp,
        "user_name": userName,
        "password": password
      };
}
