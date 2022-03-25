import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';

class FeeWithDenom {
  FeeWithDenom({
    required this.gasPriceLevels,
    required this.chainId,
    required this.denom,
  });

  final List<GasPriceLevel> gasPriceLevels;
  final String chainId;
  final Denom denom;
}
