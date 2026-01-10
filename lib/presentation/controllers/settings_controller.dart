import 'package:get/get.dart';
import 'package:unit_converter/core/services/database_service.dart';

class SettingsController extends GetxController {
  final DatabaseService _dbService = Get.find<DatabaseService>();
  
  final decimalPlaces = 2.obs;
  final enableHapticFeedback = true.obs;
  final enableAutoSave = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      // Load decimal places
      final decimalStr = await _dbService.getPreference('decimal_places');
      if (decimalStr != null) {
        decimalPlaces.value = int.tryParse(decimalStr) ?? 2;
      }

      // Load haptic feedback
      final hapticStr = await _dbService.getPreference('haptic_feedback');
      if (hapticStr != null) {
        enableHapticFeedback.value = hapticStr == 'true';
      }

      // Load auto-save
      final autoSaveStr = await _dbService.getPreference('auto_save');
      if (autoSaveStr != null) {
        enableAutoSave.value = autoSaveStr == 'true';
      }
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  Future<void> updateDecimalPlaces(int value) async {
    decimalPlaces.value = value;
    await _dbService.savePreference('decimal_places', value.toString());
    update();
  }

  Future<void> toggleHapticFeedback(bool value) async {
    enableHapticFeedback.value = value;
    await _dbService.savePreference('haptic_feedback', value.toString());
  }

  Future<void> toggleAutoSave(bool value) async {
    enableAutoSave.value = value;
    await _dbService.savePreference('auto_save', value.toString());
  }

  Future<void> clearAllData() async {
    try {
      await _dbService.clearHistory();
      // Reset settings to defaults
      decimalPlaces.value = 2;
      enableHapticFeedback.value = true;
      enableAutoSave.value = true;
      
      // Save defaults
      await _dbService.savePreference('decimal_places', '2');
      await _dbService.savePreference('haptic_feedback', 'true');
      await _dbService.savePreference('auto_save', 'true');
      
      Get.snackbar('Success', 'All data cleared successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear data: $e');
    }
  }
}
