import 'package:flutter_app/ui/pages/send_money/recipient_address_input/recipient_address_input_navigator.dart';

class RecipientAddressInputPresenter {
  RecipientAddressInputNavigator navigator;

  RecipientAddressInputPresenter(this.navigator);

  void continueTapped() => navigator.navigateToEnterAmount();
}
