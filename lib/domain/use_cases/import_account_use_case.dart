import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/use_cases/change_current_account_use_case.dart';
import 'package:flutter_app/domain/utils/future_either.dart';

class ImportAccountUseCase {
  ImportAccountUseCase(
    this._accountCredentialsRepository,
    this._accountsStore,
    this._changeCurrentAccountUseCase,
  );

  final AccountsRepository _accountCredentialsRepository;
  final AccountsStore _accountsStore;
  final ChangeCurrentAccountUseCase _changeCurrentAccountUseCase;

  Future<Either<AddAccountFailure, EmerisAccount>> execute({required ImportAccountFormData accountFormData}) async =>
      _accountCredentialsRepository.importAccount(accountFormData).flatMap((account) {
        _accountsStore.addAccount(account);
        return _changeCurrentAccountUseCase
            .execute(account: account)
            .mapError((it) => AddAccountFailure.unknown(cause: it))
            .mapSuccess((_) => account);
      });
}
