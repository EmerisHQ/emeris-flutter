// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_initial_params.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class AddAccountViewModel {
  bool get isLoading;

  String get loadingMessage;
}

class AddAccountPresentationModel with AddAccountPresentationModelBase implements AddAccountViewModel {
  AddAccountPresentationModel(this.initialParams);

  final AddAccountInitialParams initialParams;

  @override
  bool get isLoading => isFutureInProgress(importAccountFuture) || isFutureInProgress(generateMnemonicFuture);

  ObservableFuture<Either<AddAccountFailure, EmerisAccount>>? get importAccountFuture => _importAccountFuture.value;

  ObservableFuture<Mnemonic?>? get generateMnemonicFuture => _generateMnemonicFuture.value;

  @override
  String get loadingMessage {
    if (isFutureInProgress(importAccountFuture)) {
      return strings.importingAccountProgressMessage;
    } else if (isFutureInProgress(generateMnemonicFuture)) {
      return strings.generatingMnemonicProgressMessage;
    } else {
      return '';
    }
  }
}

//////////////////BOILERPLATE
mixin AddAccountPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<AddAccountFailure, EmerisAccount>>?> _importAccountFuture = Observable(null);

  set importAccountFuture(ObservableFuture<Either<AddAccountFailure, EmerisAccount>>? value) =>
      Action(() => _importAccountFuture.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Mnemonic?>?> _generateMnemonicFuture = Observable(null);

  set generateMnemonicFuture(ObservableFuture<Mnemonic?>? value) =>
      Action(() => _generateMnemonicFuture.value = value)();
}
