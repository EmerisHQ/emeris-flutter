import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/entities/transaction_hash.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';

abstract class TransactionsRepository {
  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required Transaction transaction,
    required WalletIdentifier walletIdentifier,
  });
}
