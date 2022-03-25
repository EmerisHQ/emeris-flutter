import 'package:flutter_app/utils/strings.dart';

enum GasPriceLevelType {
  low,
  average,
  high,
}

extension GasPriceLevelResources on GasPriceLevelType {
  String get displayName {
    switch (this) {
      case GasPriceLevelType.low:
        return strings.lowPriceLevel;
      case GasPriceLevelType.average:
        return strings.averagePriceLevel;
      case GasPriceLevelType.high:
        return strings.highPriceLevel;
    }
  }
}
