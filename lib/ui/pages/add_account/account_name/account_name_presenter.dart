import 'package:flutter_app/ui/pages/add_account/account_name/account_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_presentation_model.dart';

class AccountNamePresenter {
  AccountNamePresenter(
    this._model,
    this.navigator,
  );

  final AccountNamePresentationModel _model;
  final AccountNameNavigator navigator;

  AccountNameViewModel get viewModel => _model;

  void onTapSubmit() => navigator.closeWithResult(_model.name);

  // ignore: use_setters_to_change_properties
  void onChanged(String value) => _model.name = value;
}
