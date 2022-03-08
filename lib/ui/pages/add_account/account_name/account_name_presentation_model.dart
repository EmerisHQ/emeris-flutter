// ignore_for_file: avoid_setters_without_getters

import 'package:flutter_app/ui/pages/add_account/account_name/account_name_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class AccountNameViewModel {}

class AccountNamePresentationModel with AccountNamePresentationModelBase implements AccountNameViewModel {
  AccountNamePresentationModel(this.initialParams);

  final AccountNameInitialParams initialParams;

  String get name => _name.value;
}

//////////////////BOILERPLATE
mixin AccountNamePresentationModelBase {
  //////////////////////////////////////
  final Observable<String> _name = Observable('');

  set name(String value) => Action(() => _name.value = value)();
}
