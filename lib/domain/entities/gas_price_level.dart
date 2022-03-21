import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/gas_price_level_type.dart';

class GasPriceLevel extends Equatable {
  const GasPriceLevel({
    required this.type,
    required this.balance,
  });

  GasPriceLevel.empty()
      : type = GasPriceLevelType.low,
        balance = Balance.empty();

  final Balance balance;
  final GasPriceLevelType type;

  @override
  List<Object> get props => [
        balance,
        type,
      ];
}

extension GasPriceLevelsExtensions on Iterable<GasPriceLevel> {
  GasPriceLevel? get average => _level(GasPriceLevelType.average);

  GasPriceLevel? get low => _level(GasPriceLevelType.low);

  GasPriceLevel? get high => _level(GasPriceLevelType.high);

  GasPriceLevel get defaultLevel => average ?? low ?? high ?? firstOrNull() ?? GasPriceLevel.empty();

  GasPriceLevel? _level(GasPriceLevelType type) => firstOrNull(
        where: (it) => it.type == type,
      );
}
