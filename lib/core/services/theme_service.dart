import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromPrefs() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromPrefs() {
    // We'll initialize shared_preferences in main.dart or here
    return false; // Default to light
  }

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromPrefs() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToPrefs(!_loadThemeFromPrefs());
  }

  void _saveThemeToPrefs(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, isDarkMode);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}
