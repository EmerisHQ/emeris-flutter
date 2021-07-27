import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/transaction_hash.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:sacco/tx_sender.dart';
import 'package:sacco/wallet.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

Future<Either<GeneralFailure, TransactionHash>> broadcastSaccoTransaction(
    BaseEnv baseEnv, SaccoTransaction saccoTransaction) async {
  try {
    final result = await TxSender.broadcastStdTx(
      wallet: Wallet(
        networkInfo: baseEnv.networkInfo,
        address: Uint8List(0), // this is not needed for proper broadcasting
        privateKey: Uint8List(0), // this is not needed for proper broadcasting
        publicKey: Uint8List(0), // this is not needed for proper broadcasting
      ),
      stdTx: saccoTransaction.stdTx,
      mode: 'BROADCAST_MODE_SYNC',
    );

    if (result.success) {
      return right(TransactionHash(hash: result.hash));
    } else {
      return left(GeneralFailure.unknown('Tx send error: ${result.error?.errorMessage}'));
    }
  } catch (e, stack) {
    logError(e, stack);
    return left(GeneralFailure.unknown("$e"));
  }
}
