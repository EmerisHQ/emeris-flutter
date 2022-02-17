import 'package:flutter_app/domain/use_cases/paste_from_clipboard_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class MnemonicImportPresenter {
  MnemonicImportPresenter(
    this._model,
    this.navigator,
    this._pasteFromClipboardUseCase,
  );

  final MnemonicImportPresentationModel _model;
  final MnemonicImportNavigator navigator;
  final PasteFromClipboardUseCase _pasteFromClipboardUseCase;

  MnemonicImportViewModel get viewModel => _model;

  Future<void> onTapPaste() async => _pasteFromClipboardUseCase.execute().observableDoOn(
        (fail) => navigator.showError(fail.displayableFailure()),
        (success) => _model.mnemonicText = success,
      );

  void onTapImport() => navigator.closeWithResult(_model.mnemonic);

  void onTapWhatIsRecovery() => showNotImplemented();

  // ignore: use_setters_to_change_properties
  void onTextChangedMnemonic(String value) => _model.mnemonicText = value;
}
