import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/change_current_account_failure.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';

class ChangeCurrentAccountUseCase {
  ChangeCurrentAccountUseCase(
    this._walletsStore,
    this._getBalancesUseCase,
    this._accountsRepository,
  );

  final AccountsStore _walletsStore;
  final AccountsRepository _accountsRepository;
  final GetBalancesUseCase _getBalancesUseCase;

  Future<Either<ChangeCurrentAccountFailure, Unit>> execute({required EmerisAccount account}) => _accountsRepository
          .setCurrentAccount(account.accountDetails.accountIdentifier)
          .mapError(ChangeCurrentAccountFailure.unknown)
          .flatMap(
        (currentAccount) {
          _walletsStore.currentAccount = currentAccount;
          // this fetches balances for the newly selected account and saves it into the assetsStore
          return _getBalancesUseCase
              .execute(details: account.accountDetails)
              .mapError(ChangeCurrentAccountFailure.unknown)
              .mapSuccess((response) => unit);
        },
      );
}
