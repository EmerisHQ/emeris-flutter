import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:emeris_app/data/api_calls/wallet_api.dart';
import 'package:emeris_app/data/model/emeris_wallet.dart';
import 'package:emeris_app/data/model/wallet_type.dart';
import 'package:emeris_app/data/sacco/actions/broadcast_sacco_transaction.dart';
import 'package:emeris_app/data/sacco/actions/get_sacco_balances.dart';
import 'package:emeris_app/data/sacco/actions/import_sacco_wallet.dart';
import 'package:emeris_app/data/sacco/sacco_transaction.dart';
import 'package:emeris_app/domain/entities/balance.dart';
import 'package:emeris_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:emeris_app/domain/entities/failures/general_failure.dart';
import 'package:emeris_app/domain/entities/import_wallet_form_data.dart';
import 'package:emeris_app/domain/entities/paginated_list.dart';
import 'package:emeris_app/domain/entities/transaction.dart';
import 'package:emeris_app/domain/entities/transaction_hash.dart';
import 'package:emeris_app/domain/entities/wallet_identifier.dart';
import 'package:emeris_app/domain/utils/future_either.dart';
import 'package:emeris_app/global.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/wallet_lookup_key.dart';

class CosmosWalletApi implements WalletApi {
  final TransactionSigningGateway _signingGateway;
  final Dio _dio;
  final BaseEnv _baseEnv;

  CosmosWalletApi(this._signingGateway, this._dio, this._baseEnv);

  @override
  WalletType get walletType => WalletType.Cosmos;

  @override
  Future<Either<GeneralFailure, PaginatedList<Balance>>> getWalletBalances(String walletAddress) async =>
      getSaccoBalances(_baseEnv, _dio, walletAddress);

  @override
  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(
    ImportWalletFormData walletFormData,
  ) =>
      importSaccoWallet(_signingGateway, _baseEnv, walletFormData);

  @override
  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required WalletIdentifier walletIdentifier,
    required Transaction transaction,
  }) async {
    final saccoTx = SaccoTransaction.fromDomain(transaction);
    if (saccoTx == null) {
      return left(GeneralFailure.unknown("Could not create Sacco transaction from $transaction"));
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
          (transaction) => broadcastSaccoTransaction(_baseEnv, transaction as SaccoTransaction),
        );
  }
}
