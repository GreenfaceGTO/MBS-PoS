class TransaksiModel {
  int? id;
  String? tanggal;
  String? noBukti;
  String? tipe;
  int? idMitra;
  double? total;
  double? potFaktur;
  double? totalAkhir;
  String? caraBayar;
  String? keterangan;

  TransaksiModel(
      {this.id,
      this.tanggal,
      this.noBukti,
      this.tipe,
      this.idMitra,
      this.total,
      this.potFaktur,
      this.totalAkhir,
      this.caraBayar,
      this.keterangan});

  factory TransaksiModel.fromMap(Map<String, dynamic> map) => TransaksiModel(
      id: map['id'],
      tanggal: map['tanggal'],
      noBukti: map['no_bukti'],
      idMitra: map['id_mitra'],
      total: map['total'],
      potFaktur: map['pot_faktur'],
      totalAkhir: map['total_akhir'],
      caraBayar: map['jenis_bayar'],
      keterangan: map['keterangan']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "tanggal": tanggal,
        "no_bukti": noBukti,
        "tipe": tipe,
        "id_mitra": idMitra,
        "total": total,
        "pot_faktur": potFaktur,
        "total_akhir": totalAkhir,
        "jenis_bayar": caraBayar,
        "keterangan": keterangan
      };
}

class DetailTransModel {
  int? id;
  int? idHeader;
  int? idItem;
  int? jumlah;
  double? harga;
  double? potongan;

  DetailTransModel(
      {this.id,
      this.idHeader,
      this.idItem,
      this.jumlah,
      this.harga,
      this.potongan});

  factory DetailTransModel.fromMap(Map<String, dynamic> map) =>
      DetailTransModel(
          id: map['id'],
          idHeader: map['id_header'],
          idItem: map['id_item'],
          jumlah: map['jumlah'],
          harga: map['harga'],
          potongan: map['potongan']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_header": idHeader,
        "id_item": idItem,
        "jumlah": jumlah,
        "harga": harga,
        "potongan": potongan
      };
}
