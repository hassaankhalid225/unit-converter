import 'package:flutter/material.dart'; // Added for WidgetsFlutterBinding, runApp, StatelessWidget, Widget, BuildContext, GetMaterialApp
import 'package:get/get.dart';
import 'package:unit_converter/app/bindings/initial_binding.dart';
import 'package:unit_converter/app/routes/app_pages.dart';
import 'package:unit_converter/app/routes/app_routes.dart';
import 'package:unit_converter/core/theme/dark_theme.dart';
import 'package:unit_converter/core/theme/light_theme.dart';
import 'package:unit_converter/core/services/database_service.dart';
import 'package:unit_converter/core/services/theme_service.dart';
import 'package:unit_converter/presentation/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Services
  await Get.putAsync(() => ThemeService().init());
  await Get.putAsync(() => DatabaseService().init());
  
  // Pre-initialize controller for reactive theme
  Get.put(ThemeController());
  
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => GetMaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
    ));
  }
}
