import 'package:get/get.dart';
import 'package:unit_converter/core/services/database_service.dart';

class HistoryController extends GetxController {
  final DatabaseService _dbService = Get.find<DatabaseService>();
  
  final historyList = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      isLoading.value = true;
      final history = await _dbService.getHistory();
      historyList.value = history.reversed.toList(); // Most recent first
    } catch (e) {
      Get.snackbar('Error', 'Failed to load history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearHistory() async {
    try {
      await _dbService.clearHistory();
      historyList.clear();
      Get.snackbar('Success', 'History cleared successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear history: $e');
    }
  }

  String formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
