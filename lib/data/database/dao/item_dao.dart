import 'dart:developer';

import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/item_table.dart';
import 'package:mbspos/data/database/table_schema/itemsat_table.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/satitem_model.dart';

class ItemDao {
  final dbManager = Dbhelper();

  /// =============Update Status=============
  static Future<bool> updateStatus(int idProduk, bool status) async {
    final db = await Dbhelper.database;
    try {
      return await db.update(ItemTable.table, {"aktif": status ? 1 : 0}) > 0;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// ==============Update Stok==============
  static Future<bool> updateStok(int idProduk, int newStok) async {
    final db = await Dbhelper.database;
    try {
      return await db.update(ItemTable.table, {"stok": newStok},
              where: "id=?", whereArgs: [idProduk]) >
          0;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// ==============Menyimpan update data produk==============
  static Future<bool> updateProduk(ItemModel updatedData) async {
    final db = await Dbhelper.database;
    try {
      // update header
      await db.update(ItemTable.table, updatedData.toDb(),
          where: "id=?", whereArgs: [updatedData.id]);

      // looping satuan untuk insert baru atau update yang lama
      for (var sat in updatedData.satuan) {
        await db.rawInsert('''INSERT INTO satuan (
              id_produk,
              satuan,
              isi,
              tipe,
              barcode,
              harga_pokok,
              harga_jual,
              potongan
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ON CONFLICT(id_produk, satuan) DO UPDATE SET
              isi = excluded.isi,
              tipe = excluded.tipe,
              barcode = excluded.barcode,
              harga_pokok = excluded.harga_pokok,
              harga_jual = excluded.harga_jual,
              potongan = excluded.potongan
          ''', [
          sat.id,
          sat.idProduk,
          sat.isi,
          sat.tipe,
          sat.barcode,
          sat.hargaPokok,
          sat.hargaJual,
          sat.potongan
        ]);
      }
      // // hapus semua detail
      // await db.delete(ItemSatTable.table,
      //     where: "id_produk=?", whereArgs: [updatedData.id]);

      // for (var sat in updatedData.satuan) {
      //   await db.insert(ItemSatTable.table, sat.toDb());
      // }
      return true;
    } catch (e) {
      throw Exception("DAO Error : Gagal mengupdate data [$e]");
    }
  }

  /// ==========Menyimpan data produk==========
  static Future<ItemModel> simpanProduk(ItemModel data) async {
    final db = await Dbhelper.database;
    try {
      return db.transaction<ItemModel>((txn) async {
        // insert data produk (Header)
        final itemId = await txn.insert(ItemTable.table, data.toDb());

        // generate nomor SKU
        data.noSku = 'SKU-${itemId.toString().padLeft(6, '0')}';

        //  update kembali untuk menyimpan nomor sku
        await txn.update(ItemTable.table, {"no_sku": data.noSku},
            where: "id=?", whereArgs: [itemId]);

        // insert data satuan dasar
        for (final satuan in data.satuan) {
          satuan.idProduk = itemId;
          log(satuan.toMap().toString());
          final satId = await txn.insert(ItemSatTable.table, satuan.toDb());
          satuan.id = satId;
        }

        return data;
      });
    } catch (e) {
      throw Exception("DAO error : $e");
    }
  }

  /// ==========Mengambil daftar produk==========
  static Future<List<ItemModel>?> getAllProduk() async {
    final db = await Dbhelper.database;
    try {
      final result = await db.query(ItemTable.table);
      if (result.isEmpty) {
        return null;
      }
      List<ItemModel> lstItem =
          result.map((e) => ItemModel.fromMap(e)).toList();
      for (var item in lstItem) {
        final satuan = await getSatuanById(item.id!);
        if (satuan.isNotEmpty) {
          item.satuan = satuan;
        }
      }

      return lstItem;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// =============Mengambil daftar satuan berdasarkan id produk=============
  static Future<List<SatitemModel>> getSatuanById(int produkId) async {
    final db = await Dbhelper.database;
    log("Id produk : $produkId");
    try {
      final satuan = await db.query(ItemSatTable.table,
          where: 'id_produk=?', whereArgs: [produkId], orderBy: 'tipe');
      List<SatitemModel> result =
          satuan.map((sat) => SatitemModel.fromMap(sat)).toList();
      log(result.map((e) => e.toMap()).toList().toString());
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // ==================Menghapus data produk==================
  static Future<bool> deleteProduk(int produkId) async {
    final db = await Dbhelper.database;
    try {
      return await db
              .delete(ItemTable.table, where: "id=?", whereArgs: [produkId]) >
          0;
    } catch (e) {
      throw Exception(e);
    }
  }
}
