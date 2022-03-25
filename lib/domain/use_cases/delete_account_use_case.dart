import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/delete_account_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/use_cases/change_current_account_use_case.dart';

class DeleteAccountUseCase {
  DeleteAccountUseCase(this._accountsRepository, this._accountsStore, this._changeCurrentAccountUseCase);

  final AccountsRepository _accountsRepository;
  final AccountsStore _accountsStore;
  final ChangeCurrentAccountUseCase _changeCurrentAccountUseCase;

  Future<Either<DeleteAccountFailure, bool>> execute({
    required EmerisAccount account,
    required Passcode passcode,
  }) =>
      _accountsRepository.deleteAccount(account.id.byUpdatingPasscode(passcode)).mapSuccess(
        (_) {
          _accountsStore.removeAccount(account);
          if (_accountsStore.currentAccount == account) {
            _changeCurrentAccountUseCase.execute(
              account: _accountsStore.accounts.isEmpty ? const EmerisAccount.empty() : _accountsStore.accounts.first,
            );
          }
          return _accountsStore.accounts.isEmpty;
        },
      );
}
