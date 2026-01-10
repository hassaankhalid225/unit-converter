import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unit_converter/data/datasources/local/database_helper.dart';
import 'package:unit_converter/core/constants/database_constants.dart';

class DatabaseService extends GetxService {
  late DatabaseHelper _dbHelper;

  Future<DatabaseService> init() async {
    _dbHelper = DatabaseHelper.instance;
    await _dbHelper.database; // Ensure database is created
    return this;
  }

  // History methods
  Future<void> saveHistory(Map<String, dynamic> history) async {
    try {
      await _dbHelper.insert(DatabaseConstants.tableHistory, history);
    } catch (e) {
      print('Error saving history: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    try {
      final results = await _dbHelper.queryAllRows(DatabaseConstants.tableHistory);
      return results;
    } catch (e) {
      print('Error getting history: $e');
      return [];
    }
  }

  Future<void> clearHistory() async {
    try {
      await _dbHelper.clearTable(DatabaseConstants.tableHistory);
    } catch (e) {
      print('Error clearing history: $e');
    }
  }

  // Preferences methods
  Future<void> savePreference(String key, String value) async {
    try {
      final db = await _dbHelper.database;
      await db.insert(
        DatabaseConstants.tablePreferences,
        {DatabaseConstants.colKey: key, DatabaseConstants.colValue: value},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error saving preference: $e');
    }
  }

  Future<String?> getPreference(String key) async {
    try {
      final db = await _dbHelper.database;
      final results = await db.query(
        DatabaseConstants.tablePreferences,
        where: '${DatabaseConstants.colKey} = ?',
        whereArgs: [key],
      );
      if (results.isNotEmpty) {
        return results.first[DatabaseConstants.colValue] as String?;
      }
      return null;
    } catch (e) {
      print('Error getting preference: $e');
      return null;
    }
  }

  // Favorites methods
  Future<void> addFavorite(Map<String, dynamic> favorite) async {
    try {
      await _dbHelper.insert(DatabaseConstants.tableFavorites, favorite);
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  Future<void> removeFavorite(String category) async {
    try {
      await _dbHelper.delete(DatabaseConstants.tableFavorites, DatabaseConstants.colCategory, category);
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      return await _dbHelper.queryAllRows(DatabaseConstants.tableFavorites);
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }
}
