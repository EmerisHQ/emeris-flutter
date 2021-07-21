import 'package:emeris_app/domain/entities/failures/displayable_failure.dart';
import 'package:emeris_app/utils/strings.dart';

class NoWalletSelectedFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const NoWalletSelectedFailure();

  DisplayableFailure displayableFailure() {
    return DisplayableFailure(
      title: strings.noWalletSelectedTitle,
      message: strings.noWalletSelectedMessage,
    );
  }
}
