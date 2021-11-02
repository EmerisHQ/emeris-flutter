class FiatJson {
  final String symbol;
  final double price;

  const FiatJson({required this.symbol, required this.price});

  factory FiatJson.fromJson(Map<String, dynamic> json) => FiatJson(
        symbol: json['Symbol'] as String? ?? '',
        price: double.tryParse(json['Price'].toString()) ?? 0.0,
      );
}
