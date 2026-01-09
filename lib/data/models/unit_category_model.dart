import 'package:flutter/material.dart';
import 'package:unit_converter/data/models/unit_model.dart';

class UnitCategory {
  final String name;
  final IconData icon;
  final List<UnitModel> units;
  final String parentCategory; // BASIC, LIVING, SCIENCE, MISC

  UnitCategory({
    required this.name,
    required this.icon,
    required this.units,
    required this.parentCategory,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitCategory &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          parentCategory == other.parentCategory;

  @override
  int get hashCode => name.hashCode ^ parentCategory.hashCode;
}
