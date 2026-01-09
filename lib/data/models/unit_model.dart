class UnitModel {
  final String name;
  final String symbol;
  final double toBaseMultiplier;
  final String category;
  final bool isBase;

  UnitModel({
    required this.name,
    required this.symbol,
    required this.toBaseMultiplier,
    required this.category,
    this.isBase = false,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      name: json['name'],
      symbol: json['symbol'],
      toBaseMultiplier: json['toBaseMultiplier'].toDouble(),
      category: json['category'],
      isBase: json['isBase'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
      'toBaseMultiplier': toBaseMultiplier,
      'category': category,
      'isBase': isBase,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          symbol == other.symbol &&
          category == other.category;

  @override
  int get hashCode => name.hashCode ^ symbol.hashCode ^ category.hashCode;
}
