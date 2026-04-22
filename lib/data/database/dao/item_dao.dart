import 'dart:developer';

import 'package:mbspos/data/database/dbhelper.dart';
import 'package:mbspos/data/database/table_schema/item_table.dart';
import 'package:mbspos/data/database/table_schema/itemsat_table.dart';
import 'package:mbspos/models/data/item_model.dart';
import 'package:mbspos/models/data/satitem_model.dart';

class ItemDao {
  /// =============Update Status=============
  Future<bool> updateStatus(int idProduk, bool status) async {
    final db = await Dbhelper.database;
    try {
      return await db.update(ItemTable.table, {"aktif": status ? 1 : 0}) > 0;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// ==============Update Stok==============
  Future<bool> updateStok(int idProduk, int newStok) async {
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
  Future<ItemModel> updateProduk(ItemModel updatedData) async {
    final db = await Dbhelper.database;
    try {
      return db.transaction((txn) async {
        // update header
        await txn.update(ItemTable.table, updatedData.toDb(),
            where: "id=?", whereArgs: [updatedData.id]);

        // ambil semua id satuan di db untuk dibandingkan dengan yang di list
        final fromDb = await txn.query(ItemSatTable.table,
            columns: ['id'], where: "id_produk=?", whereArgs: [updatedData.id]);

        // ambil semua id satuan di list, untuk dibandingkan dengan yang dari db
        final fromList = updatedData.satuan
            .where((e) => e.id != null)
            .map((e) => e.id)
            .toList();

        // bandingkan kedua list, ambil yang harus dihapus dari db
        final toDelete = fromDb
            .map((e) => e['id'] as int)
            .where((id) => !fromList.contains(id))
            .toList();

        // hapus dari db yang sudah tidak ada di list
        for (var id in toDelete) {
          await txn.delete(ItemSatTable.table, where: "id=?", whereArgs: [id]);
        }
        // looping lagi satuan untuk insert baru atau update yang lama
        for (var sat in updatedData.satuan) {
          if (sat.id != null) {
            // Jika id satuan ada, update satuan
            await txn.update(
                ItemSatTable.table,
                {
                  "satuan": sat.satuan,
                  "isi": sat.isi,
                  "tipe": sat.tipe,
                  "barcode": sat.barcode,
                  "harga_pokok": sat.hargaPokok,
                  "harga_jual": sat.hargaJual
                },
                where: "id=?",
                whereArgs: [sat.id]);
          } else {
            // jika id satuan belum ada, insert
            sat.idProduk = updatedData.id;
            final idSat = await txn.insert(ItemSatTable.table, sat.toDb());
            sat.id = idSat;
          }
        }
        return updatedData;
      });

      // return updatedData;
    } catch (e) {
      throw Exception("DAO Error : Gagal mengupdate data [$e]");
    }
  }

  /// ==========Menyimpan data produk==========
  Future<ItemModel> simpanProduk(ItemModel data) async {
    final db = await Dbhelper.database;
    try {
      return db.transaction<ItemModel>((txn) async {
        // insert data produk (Header)
        final itemId = await txn.insert(ItemTable.table, data.toDb());

        data.id = itemId;
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
  Future<List<ItemModel>?> getAllProduk() async {
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
  Future<List<SatitemModel>> getSatuanById(int produkId) async {
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
  Future<bool> deleteProduk(int produkId) async {
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
