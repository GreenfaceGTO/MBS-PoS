class ItemModel {
  int? id;
  String? noSku;
  String? namaProduk;
  String? merek;
  String? kategori;
  int stok;
  int minStok;
  String? supplier;
  bool aktif;

  ItemModel(
      {this.id,
      this.noSku,
      this.namaProduk,
      this.merek,
      this.kategori,
      this.supplier,
      this.stok = 0,
      this.minStok = 0,
      this.aktif = true});

  factory ItemModel.fromMap(Map<String, dynamic> map) => ItemModel(
      id: map['id'],
      noSku: map['no_sku'],
      namaProduk: map['nama_produk'],
      merek: map['merek'],
      kategori: map['kategori'],
      stok: map['stok'],
      minStok: map['min_stok'],
      supplier: map['supplier'],
      aktif: map['aktif']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "no_sku": noSku,
        "nama_produk": namaProduk,
        "merek": merek,
        "kategori": kategori,
        "stok": stok,
        "min_stok": minStok,
        "supplier": supplier,
        "aktif": aktif
      };
}
