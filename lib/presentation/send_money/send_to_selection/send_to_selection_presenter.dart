import 'package:flutter_app/ui/pages/send_money/send_to_selection/send_to_selection_navigator.dart';

class SendToSelectionPresenter {
  final SendToSelectionNavigator navigator;

  SendToSelectionPresenter(this.navigator);

  void sendToAddressTapped() => navigator.navigateToRecipientAddressInput();
}
