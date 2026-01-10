import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unit_converter/presentation/controllers/home_controller.dart';
import 'package:unit_converter/presentation/controllers/theme_controller.dart';
import 'package:unit_converter/presentation/controllers/conversion_controller.dart';
import 'package:unit_converter/data/models/unit_model.dart';
import 'package:unit_converter/app/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final themeController = Get.find<ThemeController>();
    final conversionController = Get.find<ConversionController>();

    // Initial sync
    if (homeController.selectedCategory.value != null && conversionController.category == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        conversionController.setCategory(homeController.selectedCategory.value!);
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Unit Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Get.toNamed(AppRoutes.history),
            tooltip: 'History',
          ),
          Obx(() => IconButton(
            icon: Icon(themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeController.toggleTheme(),
            tooltip: 'Toggle Theme',
          )),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(AppRoutes.settings),
            tooltip: 'Settings',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calculate, color: Colors.white, size: 48),
                  SizedBox(height: 12),
                  Text('Unit Converter', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('v1.0.0', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history), 
              title: const Text('History'), 
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.history);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings), 
              title: const Text('Settings'), 
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.settings);
              },
            ),
            const Divider(),
            ListTile(leading: const Icon(Icons.info_outline), title: const Text('About'), onTap: () => Get.back()),
          ],
        ),
      ),
      body: Column(
        children: [
          // Parent Categories
          Obx(() => Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: homeController.parentCategories.map((cat) {
                bool isSelected = homeController.selectedParentCategory.value == cat;
                return InkWell(
                  onTap: () => homeController.changeParentCategory(cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).colorScheme.primary.withAlpha(20) : null,
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                          width: 4,
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
            ),
          )),
          
          // Sub-Categories
          Obx(() {
            final currentSelected = homeController.selectedCategory.value;
            return Container(
              height: 100,
              color: Theme.of(context).colorScheme.surface,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeController.categories.length,
                itemBuilder: (context, index) {
                  final cat = homeController.categories[index];
                  bool isSelected = currentSelected == cat;
                  
                  return InkWell(
                    key: ValueKey(cat.name),
                    onTap: () {
                      homeController.selectCategory(cat);
                      conversionController.setCategory(cat);
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).colorScheme.primary.withAlpha(40) : null,
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent, 
                            width: 4
                          )
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat.icon, size: 28, color: isSelected ? Theme.of(context).colorScheme.primary : null),
                          const SizedBox(height: 8),
                          Text(
                            cat.name,
                            style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Theme.of(context).colorScheme.primary : null),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          // Conversion Body
          const Expanded(child: ConversionView()),
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

    return Obx(() {
      if (controller.category == null) return const Center(child: CircularProgressIndicator());
      
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _InputCard(key: ValueKey('input_${controller.category!.name}'), controller: controller),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: 20,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => controller.swapUnits(),
                  icon: Icon(Icons.swap_vert, size: 24, color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            ),

            _OutputCard(key: ValueKey('output_${controller.category!.name}'), controller: controller),
            
            const SizedBox(height: 16),
            
            const Row(
              children: [
                Icon(Icons.grid_view_rounded, size: 18),
                SizedBox(width: 8),
                Text('ALL CONVERSIONS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.2)),
              ],
            ),
            const SizedBox(height: 8),

            // Results list - shows all conversions
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.allResults.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final result = controller.allResults[index];
                bool isTarget = result['symbol'] == controller.selectedToUnit.value?.symbol;
                
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  selected: isTarget,
                  selectedTileColor: Theme.of(context).colorScheme.primary.withAlpha(20),
                  onTap: () {
                    final unit = controller.category?.units.firstWhere((u) => u.symbol == result['symbol']);
                    if (unit != null) controller.changeToUnit(unit);
                  },
                  title: Text(result['value']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  trailing: Text(result['symbol']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                  subtitle: Text(result['name']!, style: const TextStyle(fontSize: 11)),
                );
              },
            ),
            // Extra padding for keyboard
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 16),
          ],
        ),
      );
    });
  }
}

class _InputCard extends StatefulWidget {
  final ConversionController controller;
  const _InputCard({super.key, required this.controller});

  @override
  State<_InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<_InputCard> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.controller.inputValue.value);
  }

  @override
  void didUpdateWidget(_InputCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller.category?.name != widget.controller.category?.name) {
       _textController.text = widget.controller.inputValue.value;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(50),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withAlpha(50)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('FROM', style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
              const Icon(Icons.edit_note, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _textController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(border: InputBorder.none, hintText: '0', isDense: true),
                  onChanged: (val) => widget.controller.updateInput(val),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<UnitModel>(
                      value: widget.controller.selectedFromUnit.value,
                      isExpanded: true,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      items: widget.controller.category?.units.map((u) => DropdownMenuItem(value: u, child: Text(u.symbol, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))).toList() ?? [],
                      onChanged: (u) {
                        if (u != null) widget.controller.changeFromUnit(u);
                      },
                    ),
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OutputCard extends StatelessWidget {
  final ConversionController controller;
  const _OutputCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(50),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withAlpha(50)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TO', style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Obx(() => SelectableText(controller.conversionResult.value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<UnitModel>(
                      value: controller.selectedToUnit.value,
                      isExpanded: true,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      items: controller.category?.units.map((u) => DropdownMenuItem(value: u, child: Text(u.symbol, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))).toList() ?? [],
                      onChanged: (u) {
                        if (u != null) controller.changeToUnit(u);
                      },
                    ),
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
