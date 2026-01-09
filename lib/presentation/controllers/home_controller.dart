import 'package:get/get.dart';
import 'package:unit_converter/core/constants/conversion_constants.dart';
import 'package:unit_converter/data/models/unit_category_model.dart';

class HomeController extends GetxController {
  final List<String> parentCategories = ['BASIC', 'LIVING', 'SCIENCE', 'MISC'];
  final selectedParentCategory = 'BASIC'.obs;
  final categories = <UnitCategory>[].obs;

  final selectedCategory = Rxn<UnitCategory>();

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  void changeParentCategory(String category) {
    selectedParentCategory.value = category;
    _loadCategories();
  }

  void selectCategory(UnitCategory category) {
    selectedCategory.value = category;
  }

  void _loadCategories() {
    final list = ConversionConstants.categories
        .where((cat) => cat.parentCategory == selectedParentCategory.value)
        .toList();
    categories.value = list;
    if (list.isNotEmpty) {
      selectedCategory.value = list.first;
    }
  }
}
