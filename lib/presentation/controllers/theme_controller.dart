import 'package:get/get.dart';
import 'package:unit_converter/core/services/theme_service.dart';

class ThemeController extends GetxController {
  final ThemeService _themeService = Get.find<ThemeService>();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _themeService.isDarkModeNow();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _themeService.saveTheme(isDarkMode.value);
  }
}
