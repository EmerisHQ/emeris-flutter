import 'package:flutter_app/domain/entities/token_price_data.dart';

class Price {
  late TokenPriceData data;
  dynamic message;
  late int status;

  Price({required this.data, required this.message, required this.status});
}
