import 'package:get/get.dart';
import 'package:unit_converter/core/services/theme_service.dart';

class ThemeController extends GetxController {
  final ThemeService _themeService = ThemeService();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() async {
    isDarkMode.value = await _themeService.isDarkMode();
  }

  void toggleTheme() {
    _themeService.switchTheme();
    isDarkMode.value = !isDarkMode.value;
  }
}
