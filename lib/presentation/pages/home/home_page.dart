import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unit_converter/presentation/controllers/home_controller.dart';
import 'package:unit_converter/presentation/controllers/theme_controller.dart';
import 'package:unit_converter/presentation/controllers/conversion_controller.dart';
import 'package:unit_converter/core/theme/app_colors.dart';
import 'package:unit_converter/data/models/unit_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final themeController = Get.find<ThemeController>();
    final conversionController = Get.find<ConversionController>();

    // Initialize first category
    ever(homeController.selectedCategory, (cat) {
      if (cat != null) conversionController.setCategory(cat);
    });

    // Run once at start if category is already set
    if (homeController.selectedCategory.value != null && conversionController.category == null) {
      conversionController.setCategory(homeController.selectedCategory.value!);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('Unit Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: AppColors.favorite),
            onPressed: () {},
          ),
          Obx(() => IconButton(
            icon: Icon(themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeController.toggleTheme(),
          )),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
              const PopupMenuItem(value: 'about', child: Text('About')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Parent Categories Tab Bar
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: homeController.parentCategories.map((cat) {
                bool isSelected = homeController.selectedParentCategory.value == cat;
                return InkWell(
                  onTap: () => homeController.changeParentCategory(cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Theme.of(context).colorScheme.primary : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
          ),
          
          // Sub-categories horizontal list
          Obx(() => Container(
            height: 100,
            color: Theme.of(context).colorScheme.surface,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.categories.length,
              itemBuilder: (context, index) {
                final cat = homeController.categories[index];
                bool isSelected = homeController.selectedCategory.value == cat;
                return InkWell(
                  onTap: () => homeController.selectCategory(cat),
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                          width: 2,
                        )
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat.icon, size: 30, color: isSelected ? Theme.of(context).colorScheme.primary : null),
                        const SizedBox(height: 4),
                        Text(
                          cat.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Theme.of(context).colorScheme.primary : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),

          // Conversion Body
          const Expanded(
            child: ConversionView(),
          ),
        ],
      ),
    );
  }
}

class ConversionView extends StatelessWidget {
  const ConversionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConversionController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Input Section
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Obx(() => TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    labelText: 'Value',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => controller.updateInput(''),
                    ),
                  ),
                  onChanged: (val) => controller.updateInput(val),
                  controller: TextEditingController(text: controller.inputValue.value)..selection = TextSelection.fromPosition(TextPosition(offset: controller.inputValue.value.length)),
                )),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Obx(() => DropdownButtonFormField<UnitModel>(
                  value: controller.selectedFromUnit.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                  items: controller.category?.units.map((u) => DropdownMenuItem(value: u, child: Text(u.symbol))).toList() ?? [],
                  onChanged: (u) => controller.changeFromUnit(u!),
                )),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Result List Header
          const Row(
            children: [
              Text('Conversions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),

          // Result List
          Expanded(
            child: Obx(() => ListView.separated(
              itemCount: controller.allResults.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final result = controller.allResults[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(result['value']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  trailing: Text(result['symbol']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  subtitle: Text(result['name']!),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
