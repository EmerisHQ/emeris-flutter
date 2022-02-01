import 'package:flutter_app/domain/entities/token_price_data.dart';

class Price {
  Price({required this.data, required this.message, required this.status});

  late TokenPriceData data;
  dynamic message;
  late int status;
}
