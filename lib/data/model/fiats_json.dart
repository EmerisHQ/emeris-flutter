class FiatsJson {
  late String symbol;
  late double price;

  FiatsJson({required this.symbol, required this.price});

  FiatsJson.fromJson(Map<String, dynamic> json) {
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
