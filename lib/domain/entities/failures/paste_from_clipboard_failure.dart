import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum PasteFromClipboardFailureType {
  Unknown,
}

class PasteFromClipboardFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const PasteFromClipboardFailure.unknown([this.cause]) : type = PasteFromClipboardFailureType.Unknown;

  final PasteFromClipboardFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case PasteFromClipboardFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'PasteFromClipboardFailure{type: , cause: }';
  }
}
