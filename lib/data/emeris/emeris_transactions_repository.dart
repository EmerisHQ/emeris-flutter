import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/account_api.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';

class EmerisTransactionsRepository implements TransactionsRepository {
  EmerisTransactionsRepository(this._accountApis);

  final List<AccountApi> _accountApis;

  @override
  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required Transaction transaction,
    required AccountIdentifier accountIdentifier,
  }) =>
      AccountApi.forType(_accountApis, transaction.accountType)?.signAndBroadcast(
        transaction: transaction,
        accountIdentifier: accountIdentifier,
      ) ??
      Future.value(
        left(
          GeneralFailure.unknown('Could not find account api for ${transaction.accountType}'),
        ),
      );
}
