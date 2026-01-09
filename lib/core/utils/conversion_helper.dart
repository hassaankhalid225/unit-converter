import 'package:unit_converter/data/models/unit_model.dart';

class ConversionHelper {
  static double convert(double value, UnitModel fromUnit, UnitModel toUnit) {
    if (fromUnit.category == 'Temperature') {
      return _convertTemperature(value, fromUnit.symbol, toUnit.symbol);
    }

    if (fromUnit.category == 'Fuel') {
      return _convertFuel(value, fromUnit.symbol, toUnit.symbol);
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

  static double _convertFuel(double value, String fromSymbol, String toSymbol) {
    if (fromSymbol == toSymbol) return value;
    if (value <= 0) return 0;

    // Convert everything to base unit (km/L)
    double kmL;
    if (fromSymbol == 'km/L') {
      kmL = value;
    } else if (fromSymbol == 'L/100km') {
      kmL = 100 / value;
    } else if (fromSymbol == 'mpg(US)') {
      kmL = value * 0.425144;
    } else if (fromSymbol == 'mpg(UK)') {
      kmL = value * 0.354006;
    } else {
      kmL = value;
    }

    // Convert from base unit (km/L) to target
    if (toSymbol == 'km/L') {
      return kmL;
    } else if (toSymbol == 'L/100km') {
      return 100 / kmL;
    } else if (toSymbol == 'mpg(US)') {
      return kmL / 0.425144;
    } else if (toSymbol == 'mpg(UK)') {
      return kmL / 0.354006;
    } else {
      return kmL;
    }
  }

  static String formatResult(double value) {
    if (value == 0) return '0';
    
    // Check if value is extremely small or large
    if (value.abs() < 1e-10) return '0';

    // Use scientific notation for very large/small numbers
    if (value.abs() < 0.0001 || value.abs() > 1000000000) {
      String exp = value.toStringAsExponential(4);
      return exp.replaceAll('e', ' × 10^').replaceAll('+', '');
    }

    // Format with maximum 6 decimal places, but avoid too many zeros
    String formatted = value.toStringAsFixed(6);
    
    // Remove trailing zeros and decimal point if not needed
    if (formatted.contains('.')) {
      formatted = formatted.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    
    return formatted;
  }
}
