class TokenJson {
  final String symbol;
  final num price;
  final num supply;

  const TokenJson({required this.symbol, required this.price, required this.supply});

  factory TokenJson.fromJson(Map<String, dynamic> json) {
    return TokenJson(
      symbol: json['Symbol'] as String? ?? '',
      price: json['Price'] as num? ?? 0.0,
      supply: json['Supply'] as num? ?? -1,
    );
  }
}
