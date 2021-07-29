import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/alan/actions/broadcast_alan_transaction.dart';
import 'package:flutter_app/data/alan/actions/get_alan_balances.dart';
import 'package:flutter_app/data/alan/actions/import_alan_wallet.dart';
import 'package:flutter_app/data/alan/alan_transaction.dart';
import 'package:flutter_app/data/api_calls/wallet_api.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/entities/transaction_hash.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:flutter_app/global.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/wallet_lookup_key.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

class CosmosWalletApi implements WalletApi {
  final TransactionSigningGateway _signingGateway;
  final Dio _dio;
  final BaseEnv _baseEnv;

  CosmosWalletApi(this._signingGateway, this._dio, this._baseEnv);

  @override
  WalletType get walletType => WalletType.Cosmos;

  @override
  Future<Either<GeneralFailure, PaginatedList<Balance>>> getWalletBalances(String walletAddress) async =>
      getAlanBalances(_baseEnv, _dio, walletAddress);

  @override
  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(
    ImportWalletFormData walletFormData,
  ) =>
      importAlanWallet(_signingGateway, _baseEnv, walletFormData);

  @override
  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required WalletIdentifier walletIdentifier,
    required Transaction transaction,
  }) async {
    final saccoTx = alanFromDomain(transaction);
    if (saccoTx == null) {
      return left(GeneralFailure.unknown("Could not create Alan transaction from $transaction"));
    }
    final password = walletIdentifier.password;
    if (password == null) {
      return left(const GeneralFailure.unknown("There was no password provided"));
    }
    return _signingGateway
        .signTransaction(
          transaction: saccoTx,
          walletLookupKey: WalletLookupKey(
            walletId: walletIdentifier.walletId,
            chainId: walletIdentifier.chainId,
            password: password,
          ),
        )
        .leftMap((signingFailure) => left(GeneralFailure.unknown("$signingFailure")))
        .flatMap(
          (transaction) => broadcastAlanTransaction(_baseEnv, transaction as SignedAlanTransaction),
        );
  }
}
