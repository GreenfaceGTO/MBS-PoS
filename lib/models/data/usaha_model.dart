class UsahaModel {
  String? namaUsaha;
  String? alamat;
  String? noTelp;
  String? userName;
  String? password;
  String? email;

  UsahaModel(
      {this.namaUsaha,
      this.alamat,
      this.noTelp,
      this.userName,
      this.password,
      this.email});

  factory UsahaModel.fromMap(Map<String, dynamic> map) => UsahaModel(
      namaUsaha: map['nama_usaha'],
      alamat: map['alamat'],
      noTelp: map['no_telp'],
      email: map['email'],
      userName: map['user_name'],
      password: map['password']);

  Map<String, dynamic> toMap() => {
        "nama_usaha": namaUsaha,
        "alamat": alamat,
        "no_telp": noTelp,
        "email": email,
        "user_name": userName,
        "password": password
      };
}
