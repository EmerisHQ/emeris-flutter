import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/delete_app_data_failure.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';

class DeleteAppDataUseCase {
  DeleteAppDataUseCase(this._accountsRepository);

  final AccountsRepository _accountsRepository;

  Future<Either<DeleteAppDataFailure, Unit>> execute() async {
    return _accountsRepository
        .deleteAllAccounts() //
        .mapError(DeleteAppDataFailure.unknown);
  }
}
