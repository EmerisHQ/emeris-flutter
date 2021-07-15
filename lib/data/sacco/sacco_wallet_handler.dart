import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/data/sacco/sacco_private_wallet_credentials.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/global.dart';
import 'package:sacco/sacco.dart' as sacco;
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:uuid/uuid.dart';

class SaccoWalletHandler {
  final TransactionSigningGateway _signingGateway;

  SaccoWalletHandler(this._signingGateway);

  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(
    ImportWalletFormData walletFormData,
  ) async {
    final creds = SaccoPrivateWalletCredentials(
      chainId: walletFormData.walletType.stringVal,
      mnemonic: walletFormData.mnemonic,
      walletId: const Uuid().v4(),
      networkInfo: baseEnv.networkInfo,
    );
    final sacco.Wallet wallet;
    try {
      wallet = sacco.Wallet.derive(walletFormData.mnemonic.split(" "), baseEnv.networkInfo);
    } catch (e) {
      return left(AddWalletFailure.invalidMnemonic(e));
    }
    ////////////////////////////////////////////////////////
    //TODO remove this as soon as we get rid of Global apis
    cosmosApi.importWallet(mnemonicString: walletFormData.mnemonic, walletAlias: walletFormData.alias);
    ////////////////////////////////////////////////////////
    final result = await _signingGateway.storeWalletCredentials(
      credentials: creds,
      password: walletFormData.password,
    );
    return result.fold(
      (l) => left(AddWalletFailure.storeError(l)),
      (r) => right(EmerisWallet(
        walletDetails: WalletDetails(
          walletAlias: walletFormData.alias,
          walletAddress: wallet.bech32Address,
        ),
        walletType: walletFormData.walletType,
      )),
    );
  }
}
