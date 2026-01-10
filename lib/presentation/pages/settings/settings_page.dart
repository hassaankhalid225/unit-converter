import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unit_converter/presentation/controllers/settings_controller.dart';
import 'package:unit_converter/presentation/controllers/theme_controller.dart';
import 'package:unit_converter/core/constants/app_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          _SectionHeader(title: 'Appearance'),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).dividerColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Obx(() => SwitchListTile(
                      title: const Text('Dark Mode'),
                      subtitle: const Text('Use dark theme'),
                      secondary: Icon(
                        themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      value: themeController.isDarkMode.value,
                      onChanged: (value) => themeController.toggleTheme(),
                    )),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Conversion Settings Section
          _SectionHeader(title: 'Conversion Settings'),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).dividerColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Obx(() => ListTile(
                      leading: Icon(Icons.numbers, color: Theme.of(context).colorScheme.primary),
                      title: const Text('Decimal Places'),
                      subtitle: Text('${controller.decimalPlaces.value} decimal places'),
                      trailing: SizedBox(
                        width: 120,
                        child: Slider(
                          value: controller.decimalPlaces.value.toDouble(),
                          min: 0,
                          max: 10,
                          divisions: 10,
                          label: controller.decimalPlaces.value.toString(),
                          onChanged: (value) => controller.updateDecimalPlaces(value.toInt()),
                        ),
                      ),
                    )),
                const Divider(height: 1),
                Obx(() => SwitchListTile(
                      title: const Text('Auto-save History'),
                      subtitle: const Text('Automatically save conversions'),
                      secondary: Icon(Icons.save, color: Theme.of(context).colorScheme.primary),
                      value: controller.enableAutoSave.value,
                      onChanged: controller.toggleAutoSave,
                    )),
                const Divider(height: 1),
                Obx(() => SwitchListTile(
                      title: const Text('Haptic Feedback'),
                      subtitle: const Text('Vibrate on button press'),
                      secondary: Icon(Icons.vibration, color: Theme.of(context).colorScheme.primary),
                      value: controller.enableHapticFeedback.value,
                      onChanged: controller.toggleHapticFeedback,
                    )),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Data & Storage Section
          _SectionHeader(title: 'Data & Storage'),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).dividerColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
                  title: const Text('Clear All Data'),
                  subtitle: const Text('Delete all history and settings'),
                  onTap: () => _showClearDataDialog(context, controller),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // About Section
          _SectionHeader(title: 'About'),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).dividerColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                  title: const Text('Version'),
                  subtitle: Text(AppConstants.appVersion),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.code, color: Theme.of(context).colorScheme.primary),
                  title: const Text('App Name'),
                  subtitle: Text(AppConstants.appName),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context, SettingsController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will delete all conversion history and reset settings to default. This action cannot be undone.\n\nAre you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Get.back();
              controller.clearAllData();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
