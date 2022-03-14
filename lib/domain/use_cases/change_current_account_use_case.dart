import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/change_current_account_failure.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';

class ChangeCurrentAccountUseCase {
  ChangeCurrentAccountUseCase(this._accountsStore);

  final AccountsStore _accountsStore;

  Future<Either<ChangeCurrentAccountFailure, Unit>> execute({required EmerisAccount account}) async {
    _accountsStore.currentAccount = account;
    return right(unit);
  }
}
