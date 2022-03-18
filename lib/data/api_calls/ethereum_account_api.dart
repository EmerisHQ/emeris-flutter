import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/account_api.dart';
import 'package:flutter_app/data/ethereum/actions/broadcast_ethereum_transaction.dart';
import 'package:flutter_app/data/ethereum/actions/get_ethereum_balances.dart';
import 'package:flutter_app/data/ethereum/actions/import_ethereum_account.dart';
import 'package:flutter_app/data/ethereum/ethereum_transaction.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/broadcast_transaction.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/account_lookup_key.dart';
import 'package:web3dart/web3dart.dart' as eth;

class EthereumAccountApi implements AccountApi {
  EthereumAccountApi(this._signingGateway, this._web3client);

  String? privateKey; // TODO
  final TransactionSigningGateway _signingGateway;
  final eth.Web3Client _web3client;

  @override
  AccountType get accountType => AccountType.Eth;

  @override
  Future<Either<AddAccountFailure, EmerisAccount>> importAccount(
    ImportAccountFormData accountFormData,
  ) =>
      importEthereumAccount(_signingGateway, accountFormData);

  @override
  Future<Either<GeneralFailure, PaginatedList<Balance>>> getAccountBalances(
    String accountAddress,
  ) async =>
      getEthereumBalances(_web3client, accountAddress);

  @override
  Future<Either<GeneralFailure, BroadcastTransaction>> signAndBroadcast({
    required AccountIdentifier accountIdentifier,
    required Transaction transaction,
  }) async {
    final ethTx = EthereumTransaction.fromDomain(transaction);
    if (ethTx == null) {
      return left(GeneralFailure.unknown('Could not create Ethereum transaction from $transaction'));
    }
    final password = accountIdentifier.password;
    if (password == null) {
      return left(GeneralFailure.unknown('Could not resolve password to sign transaction: $accountIdentifier'));
    }
    return _signingGateway
        .signTransaction(
          transaction: ethTx,
          accountLookupKey: AccountLookupKey(
            accountId: accountIdentifier.accountId,
            chainId: accountIdentifier.chainId,
            password: password,
          ),
        )
        .leftMap((signingFailure) => left(GeneralFailure.unknown('$signingFailure')))
        .flatMap(
          (transaction) => broadcastEthereumTransaction(_web3client, transaction as EthereumSignedTransaction),
        );
  }
}
