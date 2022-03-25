import 'dart:math';

import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_app/data/ethereum/ethereum_private_account_credentials.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_core/wallet_core.dart';

Future<Either<AddAccountFailure, EmerisAccount>> importEthereumAccount(
  TransactionSigningGateway signingGateway,
  ImportAccountFormData accountFormData,
) async {
  final rng = Random.secure();
  final Wallet account;
  final corePassword = Key.fromSecureRandom(16).base64;
  try {
    final privateKey = Web3.privateKeyFromMnemonic(accountFormData.mnemonic.stringRepresentation);
    final privateEthCredentials = EthPrivateKey.fromHex(privateKey);
    account = Wallet.createNew(privateEthCredentials, corePassword, rng);
  } catch (e, stack) {
    logError(e, stack);
    return left(AddAccountFailure.invalidMnemonic(e));
  }
  final creds = EthereumPrivateAccountCredentials(
    mnemonic: accountFormData.mnemonic.stringRepresentation,
    publicInfo: AccountPublicInfo(
      accountId: const Uuid().v4(),
      chainId: accountFormData.accountType.stringVal,
      name: accountFormData.name,
      publicAddress: (await account.privateKey.extractAddress()).hex,
    ),
    accountCoreJson: account.toJson(),
    accountCorePassword: corePassword,
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
            chainId: creds.publicInfo.chainId,
            accountId: creds.publicInfo.accountId,
          ),
          accountAlias: accountFormData.name,
          accountAddress: AccountAddress(value: account.privateKey.address.hex),
        ),
        accountType: accountFormData.accountType,
      ),
    ),
  );
}
