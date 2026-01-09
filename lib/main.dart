import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unit_converter/app/bindings/initial_binding.dart';
import 'package:unit_converter/app/routes/app_pages.dart';
import 'package:unit_converter/app/routes/app_routes.dart';
import 'package:unit_converter/core/theme/dark_theme.dart';
import 'package:unit_converter/core/theme/light_theme.dart';
import 'package:unit_converter/core/services/database_service.dart';
import 'package:unit_converter/core/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Services
  await Get.putAsync(() => DatabaseService().init());
  
  final themeService = ThemeService();
  final initialThemeMode = await themeService.isDarkMode() ? ThemeMode.dark : ThemeMode.light;

  runApp(MyApp(initialThemeMode: initialThemeMode));
}

class MyApp extends StatelessWidget {
  final ThemeMode initialThemeMode;
  const MyApp({super.key, required this.initialThemeMode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: initialThemeMode,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
    );
  }
}
