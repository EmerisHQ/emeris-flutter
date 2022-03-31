import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/alan/actions/import_alan_account.dart';
import 'package:flutter_app/data/alan/alan_transaction.dart';
import 'package:flutter_app/data/api_calls/account_api.dart';
import 'package:flutter_app/data/extensions/transaction_response.dart';
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
import 'package:flutter_app/environment_config.dart';
import 'package:transaction_signing_gateway/model/account_lookup_key.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

class CosmosAccountApi implements AccountApi {
  CosmosAccountApi(this._signingGateway, this._baseEnv);

  final TransactionSigningGateway _signingGateway;
  final EnvironmentConfig _baseEnv;

  @override
  AccountType get accountType => AccountType.Cosmos;

  @override
  Future<Either<GeneralFailure, PaginatedList<Balance>>> getAccountBalances(String accountAddress) async =>
      left(GeneralFailure.unknown('Moved to Emeris Backend Repository'));

  @override
  Future<Either<AddAccountFailure, EmerisAccount>> importAccount(
    ImportAccountFormData accountFormData,
  ) =>
      importAlanAccount(_signingGateway, _baseEnv, accountFormData);

  @override
  Future<Either<GeneralFailure, BroadcastTransaction>> signAndBroadcast({
    required AccountIdentifier accountIdentifier,
    required Transaction transaction,
  }) async {
    final alanTx = alanFromDomain(
      transaction: transaction,
    );
    if (alanTx == null) {
      return left(GeneralFailure.unknown('Could not create Alan transaction from $transaction'));
    }
    final password = accountIdentifier.password;
    if (password == null) {
      return left(GeneralFailure.unknown('There was no password provided'));
    }
    final accountLookupKey = AccountLookupKey(
      accountId: accountIdentifier.accountId,
      chainId: accountIdentifier.chainId,
      password: password,
    );
    return _signingGateway
        .signTransaction(
          transaction: alanTx,
          accountLookupKey: accountLookupKey,
        )
        .leftMap((signingFailure) => left(GeneralFailure.unknown('$signingFailure')))
        .flatMap(
          (transaction) => _signingGateway
              .broadcastTransaction(
                accountLookupKey: accountLookupKey,
                transaction: transaction as SignedAlanTransaction,
              )
              .leftMap(
                (broadcastingFailure) => left(
                  GeneralFailure.unknown('$broadcastingFailure'),
                ),
              )
              .flatMap((transactionResponse) async => right(transactionResponse.toDomain)),
        );
  }
}
