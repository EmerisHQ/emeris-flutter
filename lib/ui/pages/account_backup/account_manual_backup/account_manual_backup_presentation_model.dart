// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_initial_params.dart';
import 'package:mobx/mobx.dart';

enum ManualBackupStep {
  intro,
  confirm,
  success,
}

abstract class AccountManualBackupViewModel {
  Mnemonic get mnemonic;

  bool get confirmationChecked;

  ManualBackupStep get step;

  bool get mnnemonicConfirmationValid;

  List<String> get mnemonicStringWords;

  List<MnemonicWord> get filteredOutSelectedWords;

  List<MnemonicWord> get selectedWords;

  bool get isWordsOrderValid;
}

class AccountManualBackupPresentationModel
    with AccountManualBackupPresentationModelBase
    implements AccountManualBackupViewModel {
  AccountManualBackupPresentationModel(this.initialParams) {
    _shuffledMnemonic = Observable(mnemonic.byShufflingWords());
  }

  final AccountManualBackupInitialParams initialParams;

  @override
  Mnemonic get mnemonic => initialParams.mnemonic;

  Mnemonic get shuffledMnemonic => _shuffledMnemonic.value;

  String get mnemonicString => mnemonic.stringRepresentation;

  @override
  bool get confirmationChecked => _confirmationChecked.value;

  @override
  ManualBackupStep get step => _step.value;

  @override
  List<String> get mnemonicStringWords => mnemonic.stringWords;

  @override
  bool get mnnemonicConfirmationValid =>
      mnemonic.isWordsOrderValid(selectedWords: selectedWords) && mnemonic.words.length == selectedWords.length;

  @override
  List<MnemonicWord> get filteredOutSelectedWords => shuffledMnemonic.filteredOutSelectedWords(selectedWords);

  @override
  ObservableList<MnemonicWord> get selectedWords => _selectedWords.value;

  @override
  bool get isWordsOrderValid => mnemonic.isWordsOrderValid(selectedWords: selectedWords);
}

//////////////////BOILERPLATE
mixin AccountManualBackupPresentationModelBase {
  //////////////////////////////////////
  final Observable<bool> _confirmationChecked = Observable(false);

  set confirmationChecked(bool value) => Action(() => _confirmationChecked.value = value)();

  //////////////////////////////////////
  final Observable<ManualBackupStep> _step = Observable(ManualBackupStep.intro);

  set step(ManualBackupStep value) => Action(() => _step.value = value)();

  //////////////////////////////////////
  final Observable<ObservableList<MnemonicWord>> _selectedWords = Observable(ObservableList());

  set selectedWords(ObservableList<MnemonicWord> value) => Action(() => _selectedWords.value = value)();

  //////////////////////////////////////
  late Observable<Mnemonic> _shuffledMnemonic;

  set shuffledMnemonic(Mnemonic value) => Action(() => _shuffledMnemonic.value = value)();
}
