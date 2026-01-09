import 'package:get/get.dart';
import 'package:unit_converter/data/models/unit_model.dart';
import 'package:unit_converter/core/utils/conversion_helper.dart';
import 'package:unit_converter/data/models/unit_category_model.dart';
import 'package:unit_converter/core/services/database_service.dart';

class ConversionController extends GetxController {
  final DatabaseService _dbService = Get.find<DatabaseService>();
  
  final _category = Rxn<UnitCategory>();
  UnitCategory? get category => _category.value;
  
  final inputValue = '1'.obs;
  final selectedFromUnit = Rxn<UnitModel>();
  final selectedToUnit = Rxn<UnitModel>();
  final conversionResult = '1'.obs;
  final allResults = <Map<String, String>>[].obs;

  void setCategory(UnitCategory cat) {
    _category.value = cat;
    selectedFromUnit.value = cat.units.firstWhere((u) => u.isBase, orElse: () => cat.units.first);
    selectedToUnit.value = cat.units.length > 1 ? cat.units[1] : cat.units.first;
    calculateAll();
  }

  void updateInput(String value) {
    inputValue.value = value;
    calculateAll();
  }

  void changeFromUnit(UnitModel unit) {
    selectedFromUnit.value = unit;
    calculateAll();
  }

  void changeToUnit(UnitModel unit) {
    selectedToUnit.value = unit;
    calculateAll();
  }

  void swapUnits() {
    final temp = selectedFromUnit.value;
    selectedFromUnit.value = selectedToUnit.value;
    selectedToUnit.value = temp;
    calculateAll();
  }

  void calculateAll() {
    if (category == null || selectedFromUnit.value == null || selectedToUnit.value == null) return;
    
    if (inputValue.isEmpty) {
      allResults.clear();
      conversionResult.value = '0';
      return;
    }

    double? val = double.tryParse(inputValue.value);
    if (val == null) {
      conversionResult.value = 'Error';
      return;
    }

    // Main conversion result
    double mainResult = ConversionHelper.convert(val, selectedFromUnit.value!, selectedToUnit.value!);
    conversionResult.value = ConversionHelper.formatResult(mainResult);

    // All unit conversions
    allResults.value = category!.units.map((unit) {
      double result = ConversionHelper.convert(val, selectedFromUnit.value!, unit);
      return {
        'name': unit.name,
        'symbol': unit.symbol,
        'value': ConversionHelper.formatResult(result),
      };
    }).toList();

    // Auto-save to history (debounced or simple)
    _saveHistoryEntry(val, mainResult);
  }

  void _saveHistoryEntry(double fromVal, double toVal) {
    if (category == null || selectedFromUnit.value == null || selectedToUnit.value == null) return;
    
    final entry = {
      'category': category!.name,
      'from_unit': selectedFromUnit.value!.symbol,
      'to_unit': selectedToUnit.value!.symbol,
      'from_value': fromVal,
      'to_value': toVal,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    
    _dbService.saveHistory(entry);
  }
}
