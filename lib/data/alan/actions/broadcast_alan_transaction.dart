import 'package:alan/alan.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/transaction_hash.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

Future<Either<GeneralFailure, TransactionHash>> broadcastAlanTransaction(
    BaseEnv baseEnv, SignedAlanTransaction alanTransaction) async {
  try {
    final txSender = TxSender.fromNetworkInfo(baseEnv.networkInfo);
    final result = await txSender.broadcastTx(alanTransaction.signedTransaction);

    if (result.isSuccessful) {
      return right(TransactionHash(hash: result.txhash));
    } else {
      return left(GeneralFailure.unknown('Tx send error: ${result.rawLog}'));
    }
  } catch (e, stack) {
    logError(e, stack);
    return left(GeneralFailure.unknown("$e"));
  }
}
