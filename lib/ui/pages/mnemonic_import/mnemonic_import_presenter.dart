import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presentation_model.dart';
import 'package:flutter_app/utils/clipboard_manager.dart';

class MnemonicImportPresenter {
  MnemonicImportPresenter(
    this._model,
    this.navigator,
    this._clipboardManager,
  );

  final ClipboardManager _clipboardManager;
  final MnemonicImportPresentationModel _model;
  final MnemonicImportNavigator navigator;

  MnemonicImportViewModel get viewModel => _model;

  Future<void> onTapPaste() async => _model.mnemonicText = await _clipboardManager.paste();

  void onTapImport() => navigator.closeWithResult(_model.mnemonic);

  void onTapWhatIsRecovery() => showNotImplemented();

  // ignore: use_setters_to_change_properties
  void onTextChangedMnemonic(String value) => _model.mnemonicText = value;
}
