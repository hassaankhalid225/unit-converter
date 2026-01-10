import 'package:get/get.dart';
import 'package:unit_converter/app/routes/app_routes.dart';
import 'package:unit_converter/presentation/pages/home/home_page.dart';
import 'package:unit_converter/presentation/pages/history/history_page.dart';
import 'package:unit_converter/presentation/pages/settings/settings_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryPage(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
    ),
  ];
}
