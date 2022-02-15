// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class MnemonicImportViewModel {
  bool get showPasteButton;

  bool get showImportButton;

  bool get importButtonEnabled;

  String get mnemonicText;
}

class MnemonicImportPresentationModel with MnemonicImportPresentationModelBase implements MnemonicImportViewModel {
  MnemonicImportPresentationModel(this.initialParams);

  final MnemonicImportInitialParams initialParams;

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
mixin MnemonicImportPresentationModelBase {
  //////////////////////////////////////
  final Observable<String> _mnemonicText = Observable('');

  set mnemonicText(String value) => Action(() => _mnemonicText.value = value)();
}
