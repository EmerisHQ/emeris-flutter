import 'package:flutter_app/domain/use_cases/rename_account_use_case.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_navigator.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

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
    await _renameAccountUseCase
        .execute(
          emerisAccount: _model.emerisAccount,
          updatedName: _model.accountName,
        )
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (_) => navigator.close(),
        );
  }

  // ignore: use_setters_to_change_properties
  void onNameUpdated(String value) => _model.accountName = value;

  Future<void> init() async {}
}
