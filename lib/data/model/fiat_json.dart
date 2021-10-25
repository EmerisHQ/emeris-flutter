class FiatJson {
  late String symbol;
  late double price;

  FiatJson({required this.symbol, required this.price});

  FiatJson.fromJson(Map<String, dynamic> json) {
    symbol = json['Symbol'] as String? ?? '';
    price = json['Price'] as double? ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Symbol'] = symbol;
    data['Price'] = price;
    return data;
  }
}
