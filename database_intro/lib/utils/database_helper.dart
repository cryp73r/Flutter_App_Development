import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableUser = 'userTable';
  final String columnId = 'id';
  final String columnUsername = 'username';
  final String columnPassword = 'password';

  static DatabaseHelper _db;

  Future<Database> get db async {
    if (_db!=null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'maindb.db');

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnUsername TEXT, $columnPassword TEXT)'
    );
  }
}