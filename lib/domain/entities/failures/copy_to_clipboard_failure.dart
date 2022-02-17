import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum CopyToClipboardFailureType {
  Unknown,
}

class CopyToClipboardFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CopyToClipboardFailure.unknown([this.cause]) : type = CopyToClipboardFailureType.Unknown;

  final CopyToClipboardFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case CopyToClipboardFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'CopyToClipboardFailure{type: , cause: }';
  }
}
