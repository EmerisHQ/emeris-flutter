import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/failures/verify_account_password_failure.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';

class VerifyAccountPasswordUseCase {
  VerifyAccountPasswordUseCase(this._accountsRepository);

  final AccountsRepository _accountsRepository;

  /// checks if the [accountIdentifier] contains a valid password for this given account
  Future<Either<VerifyAccountPasswordFailure, bool>> execute(AccountIdentifier accountIdentifier) async {
    if (accountIdentifier.password == null) {
      return left(const VerifyAccountPasswordFailure.invalidPassword());
    }
    return _accountsRepository.verifyPassword(accountIdentifier);
  }
}
