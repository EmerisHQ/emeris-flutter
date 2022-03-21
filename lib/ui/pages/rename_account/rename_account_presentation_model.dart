// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/rename_account_failure.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_initial_parameters.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class RenameAccountViewModel {
  bool get isLoading;

  String get accountName;
}

class RenameAccountPresentationModel with RenameAccountPresentationModelBase implements RenameAccountViewModel {
  RenameAccountPresentationModel(this.initialParams);

  final RenameAccountInitialParams initialParams;

  ObservableFuture<Either<RenameAccountFailure, Unit>>? get renameAccountFuture => _renameAccountFuture.value;

  @override
  String get accountName =>
      _accountName.isEmpty ? initialParams.emerisAccount.accountDetails.accountAlias : _accountName;

  EmerisAccount get emerisAccount => initialParams.emerisAccount;

  @override
  bool get isLoading => isFutureInProgress(renameAccountFuture);
}

//////////////////BOILERPLATE
mixin RenameAccountPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<RenameAccountFailure, Unit>>?> _renameAccountFuture = Observable(null);

  String _accountName = '';

  set renameAccountFuture(
    ObservableFuture<Either<RenameAccountFailure, Unit>>? value,
  ) =>
      Action(() => _renameAccountFuture.value = value)();

  set accountName(String accountName) => _accountName = accountName;
}
