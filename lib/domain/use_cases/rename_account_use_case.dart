import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/rename_account_failure.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';

class RenameAccountUseCase {
  RenameAccountUseCase(
    this._accountCredentialsRepository,
    this._accountsStore,
  );

  final AccountsRepository _accountCredentialsRepository;
  final AccountsStore _accountsStore;

  Future<Either<RenameAccountFailure, Unit>> execute({
    required EmerisAccount emerisAccount,
    required String updatedName,
  }) async =>
      _accountCredentialsRepository
          .renameAccount(
        emerisAccount.accountDetails.accountIdentifier,
        updatedName,
      )
          .flatMap(
        (updatedEmerisAccount) async {
          _accountsStore.updateAccount(
            identifier: updatedEmerisAccount.accountDetails.accountIdentifier,
            account: updatedEmerisAccount,
          );
          return right(unit);
        },
      );
}
