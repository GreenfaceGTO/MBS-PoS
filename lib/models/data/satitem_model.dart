class SatitemModel {
  int? id;
  String? satuan;
  int? isi;
  String? tipe;
  String? barcode;
  double? margin;
  double? potongan;

  SatitemModel(
      {this.id,
      this.satuan,
      this.isi,
      this.tipe,
      this.barcode,
      this.margin,
      this.potongan});

  factory SatitemModel.fromMap(Map<String, dynamic> map) => SatitemModel(
      id: map['id'],
      satuan: map['satuan'],
      isi: map['isi'],
      tipe: map['tipe'],
      barcode: map['barcode'],
      margin: map['margin'],
      potongan: map['potongan']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "satuan": satuan,
        "isi": isi,
        "tipe": tipe,
        "barcode": barcode,
        "margin": margin,
        "potongan": potongan
      };
}
