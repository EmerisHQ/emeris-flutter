import 'package:flutter_app/domain/use_cases/copy_to_clipboard_use_case.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presentation_model.dart';
import 'package:flutter_app/utils/strings.dart';

class AccountManualBackupPresenter {
  AccountManualBackupPresenter(
    this._model,
    this.navigator,
    this._copyToClipboardUseCase,
  );

  final AccountManualBackupPresentationModel _model;
  final AccountManualBackupNavigator navigator;
  final CopyToClipboardUseCase _copyToClipboardUseCase;

  AccountManualBackupViewModel get viewModel => _model;

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
    await _copyToClipboardUseCase.execute(data: _model.mnemonic.stringRepresentation);
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
