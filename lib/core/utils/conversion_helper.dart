import 'package:unit_converter/data/models/unit_model.dart';

class ConversionHelper {
  static double convert(double value, UnitModel fromUnit, UnitModel toUnit) {
    if (fromUnit.category == 'Temperature') {
      return _convertTemperature(value, fromUnit.symbol, toUnit.symbol);
    }

    // Step 1: Convert input to base unit
    double baseValue = value * fromUnit.toBaseMultiplier;

    // Step 2: Convert base unit to target unit
    double result = baseValue / toUnit.toBaseMultiplier;

    return result;
  }

  static double _convertTemperature(double value, String fromSymbol, String toSymbol) {
    if (fromSymbol == toSymbol) return value;

    // Convert to Celsius first
    double celsius;
    if (fromSymbol == '°C') {
      celsius = value;
    } else if (fromSymbol == '°F') {
      celsius = (value - 32) * 5 / 9;
    } else {
      // Kelvin
      celsius = value - 273.15;
    }

    // Convert from Celsius to target
    if (toSymbol == '°C') {
      return celsius;
    } else if (toSymbol == '°F') {
      return (celsius * 9 / 5) + 32;
    } else {
      // Kelvin
      return celsius + 273.15;
    }
  }

  static String formatResult(double value) {
    if (value == 0) return '0';
    
    // Use scientific notation for very large/small numbers
    if (value.abs() < 0.0001 || value.abs() > 1000000) {
      return value.toStringAsExponential(4).replaceAll('e', ' × 10^').replaceAll('+', '');
    }

    // Format with maximum 6 decimal places
    String formatted = value.toStringAsFixed(6);
    
    // Remove trailing zeros and decimal point if not needed
    if (formatted.contains('.')) {
      formatted = formatted.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    
    return formatted;
  }
}
