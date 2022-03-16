import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/rename_account_failure.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';

class RenameAccountUseCase {
  RenameAccountUseCase(
    this._accountCredentialsRepository,
  );

  final AccountsRepository _accountCredentialsRepository;

  Future<Either<RenameAccountFailure, Unit>> execute({required AccountPublicInfo accountPublicInfo}) async =>
      _accountCredentialsRepository.renameAccount(accountPublicInfo);
}
