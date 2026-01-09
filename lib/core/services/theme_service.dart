import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  SharedPreferences? _prefs;
  final _key = 'isDarkMode';

  Future<ThemeService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  bool isDarkModeNow() {
    return _prefs?.getBool(_key) ?? false;
  }

  void saveTheme(bool isDarkMode) {
    _prefs?.setBool(_key, isDarkMode);
  }
}
