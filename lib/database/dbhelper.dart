import 'dart:developer';

import 'package:mbspos/database/table_schema/item_table.dart';
import 'package:mbspos/database/table_schema/itemsat_table.dart';
import 'package:mbspos/database/table_schema/mitra_table.dart';
import 'package:mbspos/database/table_schema/mutasiitem_table.dart';
import 'package:mbspos/database/table_schema/ref_table.dart';
import 'package:mbspos/database/table_schema/saldoapp_table.dart';
import 'package:mbspos/database/table_schema/transdetail_table.dart';
import 'package:mbspos/database/table_schema/transheader_table.dart';
import 'package:mbspos/database/table_schema/usaha_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'mbs.app');
    return openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      log("updgrading db to 2nd version...");
      await db
          .execute("ALTER TABLE ${ItemTable.table} ADD COLUMN supplier TEXT");
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(ItemTable.create);
    await db.execute(ItemSatTable.create);
    await db.execute(MitraTable.create);
    await db.execute(MutasiItemTable.create);
    await db.execute(RefTable.create);
    await db.execute(SaldoAppTable.create);
    await db.execute(TransHeaderTable.create);
    await db.execute(TransDetailTable.create);
    await db.execute(UsahaTable.create);
  }
}
