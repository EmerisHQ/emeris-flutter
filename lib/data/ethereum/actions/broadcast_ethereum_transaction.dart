import 'package:dartz/dartz.dart';
import 'package:emeris_app/data/ethereum/ethereum_transaction.dart';
import 'package:emeris_app/domain/entities/failures/general_failure.dart';
import 'package:emeris_app/domain/entities/transaction_hash.dart';
import 'package:emeris_app/utils/logger.dart';
import 'package:wallet_core/wallet_core.dart';

Future<Either<GeneralFailure, TransactionHash>> broadcastEthereumTransaction(
  Web3Client ethClient,
  EthereumSignedTransaction transaction,
) async {
  try {
    final result = await ethClient.sendRawTransaction(
      transaction.txBytes,
    );
    return right(TransactionHash(hash: result));
  } catch (e, stack) {
    logError(e, stack);
    return left(GeneralFailure.unknown("$e"));
  }
}
