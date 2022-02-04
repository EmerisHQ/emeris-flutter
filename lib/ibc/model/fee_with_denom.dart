import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/gas_price_levels.dart';

class FeeWithDenom {
  FeeWithDenom({
    required this.gasPriceLevels,
    required this.chainId,
    required this.denom,
  });

  final GasPriceLevels gasPriceLevels;
  final String chainId;
  final Denom denom;
}
