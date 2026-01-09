import 'package:get/get.dart';
import 'package:unit_converter/presentation/controllers/home_controller.dart';
import 'package:unit_converter/presentation/controllers/conversion_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // ThemeController is already put in main.dart
    Get.put(ConversionController());
    Get.put(HomeController());
  }
}
