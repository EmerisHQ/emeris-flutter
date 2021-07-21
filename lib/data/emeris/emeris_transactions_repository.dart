import 'package:dartz/dartz.dart';
import 'package:emeris_app/data/api_calls/wallet_api.dart';
import 'package:emeris_app/domain/entities/failures/general_failure.dart';
import 'package:emeris_app/domain/entities/transaction.dart';
import 'package:emeris_app/domain/entities/transaction_hash.dart';
import 'package:emeris_app/domain/entities/wallet_identifier.dart';
import 'package:emeris_app/domain/repositories/transactions_repository.dart';

class EmerisTransactionsRepository implements TransactionsRepository {
  final List<WalletApi> _walletApis;

  EmerisTransactionsRepository(this._walletApis);

  @override
  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required Transaction transaction,
    required WalletIdentifier walletIdentifier,
  }) =>
      WalletApi.forType(_walletApis, transaction.walletType)?.signAndBroadcast(
        transaction: transaction,
        walletIdentifier: walletIdentifier,
      ) ??
      Future.value(left(
        GeneralFailure.unknown("Could not find wallet api for ${transaction.walletType}"),
      ));
}
