import 'package:flutter_app/domain/use_cases/rename_account_use_case.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_navigator.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presentation_model.dart';

class RenameAccountPresenter {
  RenameAccountPresenter(
    this._model,
    this.navigator,
    this._renameAccountUseCase,
  );

  final RenameAccountPresentationModel _model;
  final RenameAccountNavigator navigator;

  final RenameAccountUseCase _renameAccountUseCase;

  RenameAccountViewModel get viewModel => _model;

  Future<void> onTapSave() async {
    final passcode = await navigator.openPasscode(const PasscodeInitialParams());
    if (passcode == null) {
      return navigator.close();
    }
    await _renameAccountUseCase.execute(
      emerisAccount: _model.emerisAccount,
      updatedName: _model.accountName,
    );
  }

  // ignore: use_setters_to_change_properties
  void onNameUpdated(String value) => _model.accountName = value;

  Future<void> init() async {}
}
