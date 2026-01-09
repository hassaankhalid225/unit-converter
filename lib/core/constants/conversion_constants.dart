import 'package:flutter/material.dart';
import 'package:unit_converter/data/models/unit_category_model.dart';
import 'package:unit_converter/data/models/unit_model.dart';

class ConversionConstants {
  static List<UnitCategory> categories = [
    // --- BASIC ---
    UnitCategory(
      name: 'Length',
      icon: Icons.straighten,
      parentCategory: 'BASIC',
      units: [
        UnitModel(name: 'Micrometer', symbol: 'μm', toBaseMultiplier: 0.000001, category: 'Length'),
        UnitModel(name: 'Millimeter', symbol: 'mm', toBaseMultiplier: 0.001, category: 'Length'),
        UnitModel(name: 'Centimeter', symbol: 'cm', toBaseMultiplier: 0.01, category: 'Length'),
        UnitModel(name: 'Decimeter', symbol: 'dm', toBaseMultiplier: 0.1, category: 'Length'),
        UnitModel(name: 'Meter', symbol: 'm', toBaseMultiplier: 1.0, category: 'Length', isBase: true),
        UnitModel(name: 'Kilometer', symbol: 'km', toBaseMultiplier: 1000.0, category: 'Length'),
        UnitModel(name: 'Inch', symbol: 'in', toBaseMultiplier: 0.0254, category: 'Length'),
        UnitModel(name: 'Foot', symbol: 'ft', toBaseMultiplier: 0.3048, category: 'Length'),
        UnitModel(name: 'Yard', symbol: 'yd', toBaseMultiplier: 0.9144, category: 'Length'),
        UnitModel(name: 'Mile', symbol: 'mi', toBaseMultiplier: 1609.344, category: 'Length'),
        UnitModel(name: 'Nautical Mile', symbol: 'NM', toBaseMultiplier: 1852.0, category: 'Length'),
      ],
    ),
    UnitCategory(
      name: 'Area',
      icon: Icons.grid_on,
      parentCategory: 'BASIC',
      units: [
        UnitModel(name: 'Square Millimeter', symbol: 'mm²', toBaseMultiplier: 0.000001, category: 'Area'),
        UnitModel(name: 'Square Centimeter', symbol: 'cm²', toBaseMultiplier: 0.0001, category: 'Area'),
        UnitModel(name: 'Square Meter', symbol: 'm²', toBaseMultiplier: 1.0, category: 'Area', isBase: true),
        UnitModel(name: 'Square Kilometer', symbol: 'km²', toBaseMultiplier: 1000000.0, category: 'Area'),
        UnitModel(name: 'Square Inch', symbol: 'in²', toBaseMultiplier: 0.00064516, category: 'Area'),
        UnitModel(name: 'Square Foot', symbol: 'ft²', toBaseMultiplier: 0.09290304, category: 'Area'),
        UnitModel(name: 'Square Yard', symbol: 'yd²', toBaseMultiplier: 0.83612736, category: 'Area'),
        UnitModel(name: 'Acre', symbol: 'ac', toBaseMultiplier: 4046.8564224, category: 'Area'),
        UnitModel(name: 'Hectare', symbol: 'ha', toBaseMultiplier: 10000.0, category: 'Area'),
      ],
    ),
    UnitCategory(
      name: 'Weight',
      icon: Icons.fitness_center,
      parentCategory: 'BASIC',
      units: [
        UnitModel(name: 'Milligram', symbol: 'mg', toBaseMultiplier: 0.001, category: 'Weight'),
        UnitModel(name: 'Gram', symbol: 'g', toBaseMultiplier: 1.0, category: 'Weight', isBase: true),
        UnitModel(name: 'Kilogram', symbol: 'kg', toBaseMultiplier: 1000.0, category: 'Weight'),
        UnitModel(name: 'Metric Ton', symbol: 't', toBaseMultiplier: 1000000.0, category: 'Weight'),
        UnitModel(name: 'Ounce', symbol: 'oz', toBaseMultiplier: 28.349523125, category: 'Weight'),
        UnitModel(name: 'Pound', symbol: 'lb', toBaseMultiplier: 453.59237, category: 'Weight'),
        UnitModel(name: 'Stone', symbol: 'st', toBaseMultiplier: 6350.29318, category: 'Weight'),
      ],
    ),
    UnitCategory(
      name: 'Volume',
      icon: Icons.layers,
      parentCategory: 'BASIC',
      units: [
        UnitModel(name: 'Milliliter', symbol: 'ml', toBaseMultiplier: 0.001, category: 'Volume'),
        UnitModel(name: 'Liter', symbol: 'l', toBaseMultiplier: 1.0, category: 'Volume', isBase: true),
        UnitModel(name: 'Cubic Meter', symbol: 'm³', toBaseMultiplier: 1000.0, category: 'Volume'),
        UnitModel(name: 'Cubic Inch', symbol: 'in³', toBaseMultiplier: 0.016387064, category: 'Volume'),
        UnitModel(name: 'Cubic Foot', symbol: 'ft³', toBaseMultiplier: 28.316846592, category: 'Volume'),
        UnitModel(name: 'Gallon (US)', symbol: 'gal', toBaseMultiplier: 3.785411784, category: 'Volume'),
      ],
    ),

    // --- LIVING ---
    UnitCategory(
      name: 'Temperature',
      icon: Icons.thermostat,
      parentCategory: 'LIVING',
      units: [
        UnitModel(name: 'Celsius', symbol: '°C', toBaseMultiplier: 1.0, category: 'Temperature', isBase: true),
        UnitModel(name: 'Fahrenheit', symbol: '°F', toBaseMultiplier: 1.0, category: 'Temperature'),
        UnitModel(name: 'Kelvin', symbol: 'K', toBaseMultiplier: 1.0, category: 'Temperature'),
      ],
    ),
    UnitCategory(
      name: 'Time',
      icon: Icons.access_time,
      parentCategory: 'LIVING',
      units: [
        UnitModel(name: 'Millisecond', symbol: 'ms', toBaseMultiplier: 0.001, category: 'Time'),
        UnitModel(name: 'Second', symbol: 's', toBaseMultiplier: 1.0, category: 'Time', isBase: true),
        UnitModel(name: 'Minute', symbol: 'min', toBaseMultiplier: 60.0, category: 'Time'),
        UnitModel(name: 'Hour', symbol: 'h', toBaseMultiplier: 3600.0, category: 'Time'),
        UnitModel(name: 'Day', symbol: 'd', toBaseMultiplier: 86400.0, category: 'Time'),
        UnitModel(name: 'Week', symbol: 'wk', toBaseMultiplier: 604800.0, category: 'Time'),
      ],
    ),
    UnitCategory(
      name: 'Speed',
      icon: Icons.speed,
      parentCategory: 'LIVING',
      units: [
        UnitModel(name: 'Meter/Second', symbol: 'm/s', toBaseMultiplier: 1.0, category: 'Speed', isBase: true),
        UnitModel(name: 'Kilometer/Hour', symbol: 'km/h', toBaseMultiplier: 0.2777777778, category: 'Speed'),
        UnitModel(name: 'Mile/Hour', symbol: 'mph', toBaseMultiplier: 0.44704, category: 'Speed'),
        UnitModel(name: 'Knot', symbol: 'kn', toBaseMultiplier: 0.5144444444, category: 'Speed'),
      ],
    ),

    // --- SCIENCE ---
    UnitCategory(
      name: 'Pressure',
      icon: Icons.compress,
      parentCategory: 'SCIENCE',
      units: [
        UnitModel(name: 'Pascal', symbol: 'Pa', toBaseMultiplier: 1.0, category: 'Pressure', isBase: true),
        UnitModel(name: 'Bar', symbol: 'bar', toBaseMultiplier: 100000.0, category: 'Pressure'),
        UnitModel(name: 'PSI', symbol: 'psi', toBaseMultiplier: 6894.75729, category: 'Pressure'),
        UnitModel(name: 'Atmosphere', symbol: 'atm', toBaseMultiplier: 101325.0, category: 'Pressure'),
      ],
    ),
    UnitCategory(
      name: 'Power',
      icon: Icons.bolt,
      parentCategory: 'SCIENCE',
      units: [
        UnitModel(name: 'Watt', symbol: 'W', toBaseMultiplier: 1.0, category: 'Power', isBase: true),
        UnitModel(name: 'Kilowatt', symbol: 'kW', toBaseMultiplier: 1000.0, category: 'Power'),
        UnitModel(name: 'Horsepower', symbol: 'hp', toBaseMultiplier: 745.699872, category: 'Power'),
      ],
    ),

    // --- MISC ---
    UnitCategory(
      name: 'Data',
      icon: Icons.storage,
      parentCategory: 'MISC',
      units: [
        UnitModel(name: 'Bit', symbol: 'bit', toBaseMultiplier: 0.125, category: 'Data'),
        UnitModel(name: 'Byte', symbol: 'B', toBaseMultiplier: 1.0, category: 'Data', isBase: true),
        UnitModel(name: 'Kilobyte', symbol: 'KB', toBaseMultiplier: 1024.0, category: 'Data'),
        UnitModel(name: 'Megabyte', symbol: 'MB', toBaseMultiplier: 1048576.0, category: 'Data'),
        UnitModel(name: 'Gigabyte', symbol: 'GB', toBaseMultiplier: 1073741824.0, category: 'Data'),
        UnitModel(name: 'Terabyte', symbol: 'TB', toBaseMultiplier: 1099511627776.0, category: 'Data'),
      ],
    ),
  ];
}
