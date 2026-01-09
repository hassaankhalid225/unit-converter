import 'package:get/get.dart';
import 'package:unit_converter/presentation/controllers/theme_controller.dart';
import 'package:unit_converter/presentation/controllers/home_controller.dart';
import 'package:unit_converter/presentation/controllers/conversion_controller.dart';
import 'package:unit_converter/core/services/database_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DatabaseService());
    Get.put(ThemeController());
    Get.put(ConversionController());
    Get.put(HomeController());
  }
}
