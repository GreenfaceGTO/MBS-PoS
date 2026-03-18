import 'package:mbspos/database/tables/item_table.dart';
import 'package:mbspos/database/tables/itemsat_table.dart';
import 'package:mbspos/database/tables/mitra_table.dart';
import 'package:mbspos/database/tables/mutasiitem_table.dart';
import 'package:mbspos/database/tables/ref_table.dart';
import 'package:mbspos/database/tables/saldoapp_table.dart';
import 'package:mbspos/database/tables/transdetail_table.dart';
import 'package:mbspos/database/tables/transheader_table.dart';
import 'package:mbspos/database/tables/usaha_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  static Database? _db;

  static Future<Database> get db async {
    _db ??= await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'mbs.app');
    return openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
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

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // contoh jika ada perubaha skema
      // await db.execute('alter table....')
    }
  }
}
