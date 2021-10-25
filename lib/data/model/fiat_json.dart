class FiatJson {
  final String symbol;
  final double price;

  const FiatJson({required this.symbol, required this.price});

  factory FiatJson.fromJson(Map<String, dynamic> json) {
    return FiatJson(
      symbol: json['Symbol'] as String? ?? '',
      price: json['Price'] as double? ?? 0.0,
    );
  }
}
