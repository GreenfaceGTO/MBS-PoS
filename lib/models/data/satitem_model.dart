class SatitemModel {
  int? id;
  int? idProduk;
  String? satuan;
  int? isi;
  String? tipe;
  double? hargaPokok;
  double? hargaJual;
  int minStok;
  double? potongan;
  String? barcode;

  SatitemModel({
    this.id,
    this.idProduk,
    this.satuan,
    this.isi,
    this.tipe,
    this.hargaPokok,
    this.hargaJual,
    this.minStok = 0,
    this.potongan,
    this.barcode,
  });

  factory SatitemModel.fromMap(Map<String, dynamic> map) => SatitemModel(
      id: map['id'] ?? 0,
      idProduk: map['id_produk'],
      satuan: map['satuan'],
      isi: map['isi'] ?? 0,
      tipe: map['tipe'],
      hargaPokok: map['harga_pokok'],
      hargaJual: map['harga_jual'],
      minStok: map['min_stok'] ?? 0,
      barcode: map['barcode'],
      potongan: map['potongan'] ?? 0);

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_produk": idProduk,
        "satuan": satuan,
        "isi": isi,
        "tipe": tipe,
        "harga_pokok": hargaPokok,
        "harga_jual": hargaJual,
        "barcode": barcode,
        "min_stok": minStok,
        "potongan": potongan
      };

  Map<String, dynamic> toDb() => {
        "id": id,
        "id_produk": idProduk,
        "satuan": satuan,
        "isi": isi,
        "tipe": tipe,
        "harga_pokok": hargaPokok,
        "harga_jual": hargaJual,
        "barcode": barcode,
        "potongan": potongan
      };
}
