class MitraModel {
  int? id;
  String? nama;
  String? alamat;
  String? noTelp;
  String? tipe;
  String? keterangan;
  String? createdAt;

  MitraModel(
      {this.id,
      this.nama,
      this.alamat,
      this.noTelp,
      this.tipe,
      this.keterangan,
      this.createdAt});

  factory MitraModel.fromMap(Map<String, dynamic> map) => MitraModel(
      id: map['id'],
      nama: map['nama'],
      alamat: map['alamat'],
      noTelp: map['no_telp'],
      tipe: map['tipe'],
      keterangan: map['keterangan'],
      createdAt: map['created_at']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
        "no_telp": noTelp,
        "tipe": tipe,
        "keterangan": keterangan,
        "created_at": createdAt
      };
}
