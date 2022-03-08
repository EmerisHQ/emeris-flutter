import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/ethereum/ethereum_private_wallet_credentials.dart';
import 'package:flutter_app/data/ethereum/ethereum_transaction.dart';
import 'package:transaction_signing_gateway/model/private_account_credentials.dart';
import 'package:transaction_signing_gateway/model/signed_transaction.dart';
import 'package:transaction_signing_gateway/model/transaction_signing_failure.dart';
import 'package:transaction_signing_gateway/model/unsigned_transaction.dart';
import 'package:transaction_signing_gateway/transaction_signer.dart';
import 'package:web3dart/web3dart.dart';

class EthereumTransactionSigner implements TransactionSigner {
  EthereumTransactionSigner(this._web3client);

  final Web3Client _web3client;

  @override
  bool canSign(UnsignedTransaction unsignedTransaction) => unsignedTransaction is EthereumTransaction;

  @override
  Future<Either<TransactionSigningFailure, SignedTransaction>> sign({
    required PrivateAccountCredentials privateCredentials,
    required UnsignedTransaction transaction,
  }) async {
    if (transaction is! EthereumTransaction) {
      return left(EthereumTransactionSigningFailure('passed transaction is not $EthereumTransaction'));
    }
    if (privateCredentials is! EthereumPrivateWalletCredentials) {
      return left(
        EthereumTransactionSigningFailure('passed privateCredentials is not $EthereumPrivateWalletCredentials'),
      );
    }

    try {
      final signedTx = await _web3client.signTransaction(
        privateCredentials.wallet.privateKey,
        transaction.unsignedTransaction,
      );
      return right(EthereumSignedTransaction(signedTx));
    } catch (e, stack) {
      logError(e, stack);
      return left(EthereumTransactionSigningFailure(e));
    }
  }
}

class EthereumTransactionSigningFailure extends TransactionSigningFailure {
  EthereumTransactionSigningFailure(this.cause);

  final Object cause;

  @override
  TransactionSigningFailType get type => TransactionSigningFailType.unknown;

  @override
  String toString() {
    return 'EthereumTransactionSigningFailure{cause: $cause}';
  }
}
