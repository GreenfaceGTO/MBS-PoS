import 'package:sqflite/sqflite.dart';

class Dbhelper {
  Dbhelper._();

  static final Dbhelper _instance = Dbhelper._();

  factory Dbhelper() => _instance;

  static Database? _db;

  static const String _dbName = "mbspos.db";

  static const int _dbVersion = 1;
}
