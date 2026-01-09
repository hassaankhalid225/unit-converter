class DatabaseConstants {
  static const String dbName = 'unit_converter.db';
  static const int dbVersion = 1;

  // Tables
  static const String tableHistory = 'conversion_history';
  static const String tableFavorites = 'favorites';
  static const String tablePreferences = 'preferences';

  // Common Columns
  static const String colId = 'id';
  static const String colCategory = 'category';
  static const String colTimestamp = 'timestamp';

  // History Columns
  static const String colFromUnit = 'from_unit';
  static const String colToUnit = 'to_unit';
  static const String colFromValue = 'from_value';
  static const String colToValue = 'to_value';

  // Favorites Columns
  static const String colUnitType = 'unit_type';
  static const String colIsFavorite = 'is_favorite';
  static const String colOrderIndex = 'order_index';

  // Preferences Columns
  static const String colKey = 'key';
  static const String colValue = 'value';
}
