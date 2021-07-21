import 'package:dartz/dartz.dart';
import 'package:emeris_app/data/api_calls/wallet_api.dart';
import 'package:emeris_app/data/ethereum/actions/broadcast_ethereum_transaction.dart';
import 'package:emeris_app/data/ethereum/actions/get_ethereum_balances.dart';
import 'package:emeris_app/data/ethereum/actions/import_ethereum_wallet.dart';
import 'package:emeris_app/data/ethereum/ethereum_transaction.dart';
import 'package:emeris_app/data/model/emeris_wallet.dart';
import 'package:emeris_app/data/model/wallet_type.dart';
import 'package:emeris_app/domain/entities/balance.dart';
import 'package:emeris_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:emeris_app/domain/entities/failures/general_failure.dart';
import 'package:emeris_app/domain/entities/import_wallet_form_data.dart';
import 'package:emeris_app/domain/entities/paginated_list.dart';
import 'package:emeris_app/domain/entities/transaction.dart';
import 'package:emeris_app/domain/entities/transaction_hash.dart';
import 'package:emeris_app/domain/entities/wallet_identifier.dart';
import 'package:emeris_app/domain/utils/future_either.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/wallet_lookup_key.dart';
import 'package:web3dart/web3dart.dart' as eth;

class EthereumWalletApi implements WalletApi {
  String? privateKey; // TODO
  final TransactionSigningGateway _signingGateway;
  final eth.Web3Client _web3client;

  @override
  WalletType get walletType => WalletType.Eth;

  EthereumWalletApi(this._signingGateway, this._web3client);

  @override
  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(
    ImportWalletFormData walletFormData,
  ) =>
      importEthereumWallet(_signingGateway, walletFormData);

  @override
  Future<Either<GeneralFailure, PaginatedList<Balance>>> getWalletBalances(
    String walletAddress,
  ) async =>
      getEthereumBalances(_web3client, walletAddress);

  @override
  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required WalletIdentifier walletIdentifier,
    required Transaction transaction,
  }) async {
    final ethTx = EthereumTransaction.fromDomain(transaction);
    if (ethTx == null) {
      return left(GeneralFailure.unknown("Could not create Ethereum transaction from $transaction"));
    }
    final password = walletIdentifier.password;
    if (password == null) {
      return left(GeneralFailure.unknown("Could not resolve password to sign transaction: $walletIdentifier"));
    }
    return _signingGateway
        .signTransaction(
          transaction: ethTx,
          walletLookupKey: WalletLookupKey(
            walletId: walletIdentifier.walletId,
            chainId: walletIdentifier.chainId,
            password: password,
          ),
        )
        .leftMap((signingFailure) => left(GeneralFailure.unknown("$signingFailure")))
        .flatMap(
          (transaction) => broadcastEthereumTransaction(_web3client, transaction as EthereumSignedTransaction),
        );
  }
}
