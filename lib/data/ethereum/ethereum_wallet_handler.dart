import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_app/data/ethereum/ethereum_private_wallet_credentials.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_core/wallet_core.dart';

class EthereumWalletHandler {
  final TransactionSigningGateway _signingGateway;

  EthereumWalletHandler(this._signingGateway);

  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(ImportWalletFormData walletFormData) async {
    final rng = Random.secure();
    final Wallet wallet;
    final corePassword = Key.fromSecureRandom(16).base64;
    try {
      final privateKey = Web3.privateKeyFromMnemonic(walletFormData.mnemonic);
      final privateEthCredentials = EthPrivateKey.fromHex(privateKey);
      wallet = Wallet.createNew(privateEthCredentials, corePassword, rng);
    } catch (e, stack) {
      logError(e, stack);
      return left(AddWalletFailure.invalidMnemonic(e));
    }
    final result = await _signingGateway.storeWalletCredentials(
      credentials: EthereumPrivateWalletCredentials(
        mnemonic: walletFormData.mnemonic,
        walletId: const Uuid().v4(),
        walletCoreJson: wallet.toJson(),
        walletCorePassword: corePassword,
        chainId: walletFormData.walletType.stringVal,
      ),
      password: walletFormData.password,
    );

    ////////////////////////////////////////////////////////
    //TODO remove this as soon as we get rid of Global apis
    ethApi.importWallet(mnemonicString: walletFormData.mnemonic, walletAlias: walletFormData.alias);
    ////////////////////////////////////////////////////////

    return result.fold(
      (l) => left(AddWalletFailure.storeError(l)),
      (r) => right(EmerisWallet(
        walletDetails: WalletDetails(
          walletAlias: walletFormData.alias,
          walletAddress: wallet.privateKey.address.hex,
        ),
        walletType: walletFormData.walletType,
      )),
    );
  }
}
