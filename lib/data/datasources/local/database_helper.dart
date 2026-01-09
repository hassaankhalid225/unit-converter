import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:unit_converter/core/constants/database_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(DatabaseConstants.dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: DatabaseConstants.dbVersion,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableHistory} (
        ${DatabaseConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstants.colCategory} TEXT NOT NULL,
        ${DatabaseConstants.colFromUnit} TEXT NOT NULL,
        ${DatabaseConstants.colToUnit} TEXT NOT NULL,
        ${DatabaseConstants.colFromValue} REAL NOT NULL,
        ${DatabaseConstants.colToValue} REAL NOT NULL,
        ${DatabaseConstants.colTimestamp} INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableFavorites} (
        ${DatabaseConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstants.colCategory} TEXT NOT NULL,
        ${DatabaseConstants.colUnitType} TEXT NOT NULL,
        ${DatabaseConstants.colIsFavorite} INTEGER DEFAULT 0,
        ${DatabaseConstants.colOrderIndex} INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tablePreferences} (
        ${DatabaseConstants.colKey} TEXT PRIMARY KEY,
        ${DatabaseConstants.colValue} TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<int> delete(String table, String column, dynamic value) async {
    final db = await instance.database;
    return await db.delete(table, where: '$column = ?', whereArgs: [value]);
  }

  Future<int> update(String table, Map<String, dynamic> row, String column, dynamic value) async {
    final db = await instance.database;
    return await db.update(table, row, where: '$column = ?', whereArgs: [value]);
  }

  Future<void> clearTable(String table) async {
    final db = await instance.database;
    await db.delete(table);
  }
}
