import 'dart:math';

import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_app/data/ethereum/ethereum_private_wallet_credentials.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_core/wallet_core.dart';

Future<Either<AddWalletFailure, EmerisWallet>> importEthereumWallet(
  TransactionSigningGateway signingGateway,
  ImportWalletFormData walletFormData,
) async {
  final rng = Random.secure();
  final Wallet wallet;
  final corePassword = Key.fromSecureRandom(16).base64;
  try {
    final privateKey = Web3.privateKeyFromMnemonic(walletFormData.mnemonic.stringRepresentation);
    final privateEthCredentials = EthPrivateKey.fromHex(privateKey);
    wallet = Wallet.createNew(privateEthCredentials, corePassword, rng);
  } catch (e, stack) {
    logError(e, stack);
    return left(AddWalletFailure.invalidMnemonic(e));
  }
  final creds = EthereumPrivateWalletCredentials(
    mnemonic: walletFormData.mnemonic.stringRepresentation,
    publicInfo: AccountPublicInfo(
      accountId: const Uuid().v4(),
      chainId: walletFormData.walletType.stringVal,
      name: walletFormData.name,
      publicAddress: (await wallet.privateKey.extractAddress()).hex,
    ),
    walletCoreJson: wallet.toJson(),
    walletCorePassword: corePassword,
  );
  final result = await signingGateway.storeAccountCredentials(
    credentials: creds,
    password: walletFormData.password,
  );

  return result.fold(
    (l) => left(AddWalletFailure.storeError(l)),
    (r) => right(
      EmerisWallet(
        walletDetails: WalletDetails(
          walletIdentifier: WalletIdentifier(
            chainId: creds.publicInfo.chainId,
            walletId: creds.publicInfo.accountId,
          ),
          walletAlias: walletFormData.name,
          walletAddress: wallet.privateKey.address.hex,
        ),
        walletType: walletFormData.walletType,
      ),
    ),
  );
}
