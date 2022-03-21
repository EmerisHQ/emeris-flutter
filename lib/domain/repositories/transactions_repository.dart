import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/broadcast_transaction.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/transaction.dart';

abstract class TransactionsRepository {
  Future<Either<GeneralFailure, BroadcastTransaction>> signAndBroadcast({
    required Transaction transaction,
    required AccountIdentifier accountIdentifier,
  });
}
