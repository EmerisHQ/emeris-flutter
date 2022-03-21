import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/change_current_account_failure.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';

class ChangeCurrentAccountUseCase {
  ChangeCurrentAccountUseCase(this._walletsStore, this._getBalancesUseCase);

  final AccountsStore _walletsStore;
  final GetBalancesUseCase _getBalancesUseCase;

  Future<Either<ChangeCurrentAccountFailure, Unit>> execute({required EmerisAccount account}) async {
    _walletsStore.currentAccount = account;

    // this fetches balances for the newly selected account and saves it into the assetsStore
    return _getBalancesUseCase
        .execute(details: account.accountDetails)
        .mapError(ChangeCurrentAccountFailure.unknown)
        .mapSuccess((response) => unit);
  }
}
