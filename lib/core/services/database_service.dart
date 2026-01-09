import 'package:get/get.dart';
import 'package:unit_converter/data/datasources/local/database_helper.dart';
import 'package:unit_converter/core/constants/database_constants.dart';

class DatabaseService extends GetxService {
  late DatabaseHelper _dbHelper;

  Future<DatabaseService> init() async {
    _dbHelper = DatabaseHelper.instance;
    await _dbHelper.database;
    return this;
  }

  // History methods
  Future<void> saveHistory(Map<String, dynamic> history) async {
    await _dbHelper.insert(DatabaseConstants.tableHistory, history);
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    return await _dbHelper.queryAllRows(DatabaseConstants.tableHistory);
  }

  Future<void> clearHistory() async {
    await _dbHelper.clearTable(DatabaseConstants.tableHistory);
  }

  // Favorites methods
  Future<void> addFavorite(Map<String, dynamic> favorite) async {
    await _dbHelper.insert(DatabaseConstants.tableFavorites, favorite);
  }

  Future<void> removeFavorite(String category) async {
    await _dbHelper.delete(DatabaseConstants.tableFavorites, DatabaseConstants.colCategory, category);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    return await _dbHelper.queryAllRows(DatabaseConstants.tableFavorites);
  }
}
