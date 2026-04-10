class SatitemModel {
  int? id;
  String? satuan;
  int? isi;
  String? tipe;
  int? stokMin;
  double? hargaPokok;
  double? margin;
  double? hargaJual;
  double? potongan;
  String? barcode;

  SatitemModel({
    this.id,
    this.satuan,
    this.isi,
    this.tipe,
    this.stokMin,
    this.hargaPokok,
    this.hargaJual,
    this.margin,
    this.potongan,
    this.barcode,
  });

  factory SatitemModel.fromMap(Map<String, dynamic> map) => SatitemModel(
      id: map['id'],
      satuan: map['satuan'],
      isi: map['isi'],
      tipe: map['tipe'],
      stokMin: map['stok_min'],
      hargaPokok: map['harga_pokok'],
      hargaJual: map['harga_jual'],
      barcode: map['barcode'],
      margin: map['margin'],
      potongan: map['potongan']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "satuan": satuan,
        "isi": isi,
        "tipe": tipe,
        "stok_min": stokMin,
        "harga_pokok": hargaPokok,
        "harga_jual": hargaJual,
        "barcode": barcode,
        "margin": margin,
        "potongan": potongan
      };
}
