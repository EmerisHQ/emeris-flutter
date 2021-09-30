import 'package:flutter_app/data/model/gas_price_levels_json.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class FeeWithDenom {
  final GasPriceLevelsJson gasPriceLevels;
  final String chainId;
  final Denom denom;

  FeeWithDenom({
    required this.gasPriceLevels,
    required this.chainId,
    required this.denom,
  });
}
