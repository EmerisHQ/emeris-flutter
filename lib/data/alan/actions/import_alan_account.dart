import 'package:alan/alan.dart' as alan;
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';
import 'package:uuid/uuid.dart';

Future<Either<AddAccountFailure, EmerisAccount>> importAlanAccount(
  TransactionSigningGateway signingGateway,
  EnvironmentConfig baseEnv,
  ImportAccountFormData accountFormData,
) async {
  final alan.Wallet account;
  try {
    final words = accountFormData.mnemonic.words.map((e) => e.word).toList();
    account = alan.Wallet.derive(words, baseEnv.networkInfo);
  } catch (e) {
    return left(AddAccountFailure.invalidMnemonic(e));
  }
  final creds = AlanPrivateAccountCredentials(
    publicInfo: AccountPublicInfo(
      chainId: accountFormData.accountType.stringVal,
      accountId: const Uuid().v4(),
      name: accountFormData.name,
      publicAddress: account.bech32Address,
    ),
    mnemonic: accountFormData.mnemonic.stringRepresentation,
  );
  final result = await signingGateway.storeAccountCredentials(
    credentials: creds,
    password: accountFormData.password,
  );
  return result.fold(
    (l) => left(AddAccountFailure.storeError(l)),
    (r) => right(
      EmerisAccount(
        accountDetails: AccountDetails(
          accountIdentifier: AccountIdentifier(
            accountId: creds.publicInfo.accountId,
            chainId: creds.publicInfo.chainId,
          ),
          accountAlias: accountFormData.name,
          accountAddress: account.bech32Address,
        ),
        accountType: accountFormData.accountType,
      ),
    ),
  );
}
