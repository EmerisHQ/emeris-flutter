import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/delete_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_accounts_list_failure.dart';
import 'package:flutter_app/domain/entities/failures/rename_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/verify_account_password_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';

abstract class AccountsRepository {
  Future<Either<AddAccountFailure, EmerisAccount>> importAccount(ImportAccountFormData accountFormData);

  Future<Either<GetAccountsListFailure, List<EmerisAccount>>> getAccountsList();

  Future<Either<VerifyAccountPasswordFailure, bool>> verifyPassword(AccountIdentifier accountIdentifier);

  Future<Either<DeleteAccountFailure, Unit>> deleteAccount(AccountIdentifier accountIdentifier);

  Future<Either<RenameAccountFailure, EmerisAccount>> renameAccount(AccountIdentifier accountIdentifier, String updatedName);
}
