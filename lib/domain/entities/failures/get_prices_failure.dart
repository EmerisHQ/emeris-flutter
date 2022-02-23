import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum GetPricesFailureType {
  Unknown,
}

class GetPricesFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPricesFailure.unknown([this.cause]) : type = GetPricesFailureType.Unknown;

  final GetPricesFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPricesFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GetPricesFailure{type: , cause: }';
  }
}
