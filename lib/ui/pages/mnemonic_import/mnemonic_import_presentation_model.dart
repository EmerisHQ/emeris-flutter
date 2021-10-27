// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/domain/model/mnemonic.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class MnemonicImportViewModel {
  bool get showPasteButton;

  bool get showImportButton;

  bool get importButtonEnabled;

  String get mnemonicText;
}

class MnemonicImportPresentationModel with MnemonicImportPresentationModelBase implements MnemonicImportViewModel {
  final MnemonicImportInitialParams initialParams;

  MnemonicImportPresentationModel(this.initialParams);

  @override
  String get mnemonicText => _mnemonicText.value;

  @override
  bool get importButtonEnabled => mnemonic.isEnoughWords;

  @override
  bool get showImportButton => mnemonicText.isNotEmpty;

  @override
  bool get showPasteButton => mnemonicText.isEmpty;

  Mnemonic get mnemonic => Mnemonic.fromString(mnemonicText);
}

//////////////////BOILERPLATE
abstract class MnemonicImportPresentationModelBase {
  //////////////////////////////////////
  final Observable<String> _mnemonicText = Observable("");

  set mnemonicText(String value) => Action(() => _mnemonicText.value = value)();
}
