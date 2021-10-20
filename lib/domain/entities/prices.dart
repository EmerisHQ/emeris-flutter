class PricesDomain {
  late DataDomain data;
  dynamic message;
  late int status;

  PricesDomain({required this.data, required this.message, required this.status});
}

class DataDomain {
  late List<TokensDomain> tokens;
  late List<FiatsDomain> fiats;

  DataDomain({required this.tokens, required this.fiats});
}

class TokensDomain {
  late String symbol;
  late double price;
  late int supply;

  TokensDomain({required this.symbol, required this.price, required this.supply});
}

class FiatsDomain {
  late String symbol;
  late double price;

  FiatsDomain({required this.symbol, required this.price});
}
