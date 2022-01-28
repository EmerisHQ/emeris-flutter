import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/ethereum/ethereum_transaction.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';
import 'package:wallet_core/wallet_core.dart';

Future<Either<GeneralFailure, TransactionHash>> broadcastEthereumTransaction(
  Web3Client ethClient,
  EthereumSignedTransaction transaction,
) async {
  try {
    final result = await ethClient.sendRawTransaction(
      transaction.txBytes,
    );
    return right(TransactionHash(txHash: result));
  } catch (e, stack) {
    logError(e, stack);
    return left(GeneralFailure.unknown('$e'));
  }
}
