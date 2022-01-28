import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';
import 'package:flutter_app/utils/clipboard_manager.dart';
import 'package:flutter_app/utils/strings.dart';

class WalletManualBackupPresenter {
  WalletManualBackupPresenter(
    this._model,
    this.navigator,
    this.clipboardManager,
  );

  final WalletManualBackupPresentationModel _model;
  final WalletManualBackupNavigator navigator;
  final ClipboardManager clipboardManager;

  WalletManualBackupViewModel get viewModel => _model;

  void onTapIntroContinue() {
    if (!_model.confirmationChecked) {
      return;
    }
    _model.step = ManualBackupStep.confirm;
  }

  Future<void> onTapConfirmContinue() async {
    if (!_model.mnnemonicConfirmationValid) {
      return;
    }
    _model.step = ManualBackupStep.success;
  }

  void onTapSuccessContinue() {
    navigator.closeWithResult(true);
  }

  Future<void> onTapCopyToClipboard() async {
    await clipboardManager.copyToClipboard(_model.mnemonic.stringRepresentation);
    await navigator.showSnackBar(strings.copiedToClipboardMessage);
  }

  //ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  void onCheckConfirmationCheckbox(bool checked) => _model.confirmationChecked = checked;

  void onTapSelectedWord(int index) => _model.selectedWords.removeAt(index);

  void onTapUnselectedWord(int index) {
    final word = _model.filteredOutSelectedWords[index];
    if (word.word.isNotEmpty) {
      _model.selectedWords.add(word);
    }
  }
}
