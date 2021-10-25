class TokenJson {
  late String symbol;
  late double price;
  late int supply;

  TokenJson({required this.symbol, required this.price, required this.supply});

  TokenJson.fromJson(Map<String, dynamic> json) {
    symbol = json['Symbol'] as String? ?? '';
    price = json['Price'] as double? ?? 0.0;
    supply = json['Supply'] as int? ?? -1;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Symbol'] = symbol;
    data['Price'] = price;
    data['Supply'] = supply;
    return data;
  }
}
