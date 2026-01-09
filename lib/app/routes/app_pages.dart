import 'package:get/get.dart';
import 'package:unit_converter/app/routes/app_routes.dart';
import 'package:unit_converter/presentation/pages/home/home_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
  ];
}
