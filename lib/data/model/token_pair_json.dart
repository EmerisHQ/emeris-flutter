class CurrencyPairJson {
  const CurrencyPairJson({
    required this.symbol,
    required this.price,
    required this.supply,
  });

  factory CurrencyPairJson.fromJson(Map<String, dynamic> json) {
    return CurrencyPairJson(
      symbol: json['Symbol'] as String? ?? '',
      price: json['Price'] as num? ?? 0.0,
      supply: json['Supply'] as num? ?? -1,
    );
  }

  final String? symbol;
  final num? price;
  final num? supply;
}
