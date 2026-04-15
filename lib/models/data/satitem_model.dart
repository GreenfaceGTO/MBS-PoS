class SatitemModel {
  int? id;
  String? satuan;
  int? isi;
  String? tipe;
  double? hargaPokok;
  double? hargaJual;
  double? margin;
  int minStok;
  double? potongan;
  String? barcode;

  SatitemModel({
    this.id,
    this.satuan,
    this.isi,
    this.tipe,
    this.hargaPokok,
    this.hargaJual,
    this.margin,
    this.minStok = 0,
    this.potongan,
    this.barcode,
  });

  factory SatitemModel.fromMap(Map<String, dynamic> map) => SatitemModel(
      id: map['id'],
      satuan: map['satuan'],
      isi: map['isi'],
      tipe: map['tipe'],
      hargaPokok: map['harga_pokok'],
      hargaJual: map['harga_jual'],
      minStok: map['min_stok'],
      barcode: map['barcode'],
      margin: map['margin'],
      potongan: map['potongan']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "satuan": satuan,
        "isi": isi,
        "tipe": tipe,
        "harga_pokok": hargaPokok,
        "harga_jual": hargaJual,
        "barcode": barcode,
        "min_stok": minStok,
        "margin": margin,
        "potongan": potongan
      };

  Map<String, dynamic> toDb() => {
        "id": id,
        "satuan": satuan,
        "isi": isi,
        "tipe": tipe,
        "harga_pokok": hargaPokok,
        "harga_jual": hargaJual,
        "barcode": barcode,
        "margin": margin,
        "potongan": potongan
      };
}
