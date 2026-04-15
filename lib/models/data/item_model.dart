import 'dart:convert';

import 'package:mbspos/models/data/satitem_model.dart';

class ItemModel {
  int? id;
  String? noSku;
  String? namaProduk;
  String? merek;
  List<String>? kategori;
  int stok;
  int minStok;
  String? supplier;
  int aktif;
  List<SatitemModel> satuan;

  ItemModel(
      {this.id,
      this.noSku,
      this.namaProduk,
      this.merek,
      this.kategori,
      this.supplier,
      this.stok = 0,
      this.minStok = 0,
      this.aktif = 1,
      this.satuan = const []});

  factory ItemModel.fromMap(Map<String, dynamic> map) => ItemModel(
      id: map['id'],
      noSku: map['no_sku'],
      namaProduk: map['nama_produk'],
      merek: map['merek'],
      kategori: List.from(jsonDecode(map['kategori'])),
      stok: map['stok'],
      minStok: map['min_stok'],
      supplier: map['supplier'],
      aktif: map['aktif'],
      satuan: map['satuan'] != null
          ? List.from(map['satuan'].map((e) => SatitemModel.fromMap(e)))
          : []);

  Map<String, dynamic> toMap() => {
        "id": id,
        "no_sku": noSku,
        "nama_produk": namaProduk,
        "merek": merek,
        "kategori": jsonEncode(kategori),
        "stok": stok,
        "min_stok": minStok,
        "supplier": supplier,
        "aktif": aktif,
        "satuan": jsonEncode(satuan.map((e) => e.toMap()).toList())
      };

  Map<String, dynamic> toDb() => {
        "id": id,
        "no_sku": noSku,
        "nama_produk": namaProduk,
        "merek": merek,
        "kategori": jsonEncode(kategori),
        "stok": stok,
        "min_stok": minStok,
        "supplier": supplier,
        "aktif": aktif,
      };
}
