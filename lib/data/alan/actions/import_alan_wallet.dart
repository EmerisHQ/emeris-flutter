import 'package:alan/alan.dart' as alan;
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';
import 'package:uuid/uuid.dart';

Future<Either<AddWalletFailure, EmerisWallet>> importAlanWallet(
  TransactionSigningGateway signingGateway,
  EnvironmentConfig baseEnv,
  ImportWalletFormData walletFormData,
) async {
  final alan.Wallet wallet;
  try {
    final words = walletFormData.mnemonic.words.map((e) => e.word).toList();
    wallet = alan.Wallet.derive(words, baseEnv.networkInfo);
  } catch (e) {
    return left(AddWalletFailure.invalidMnemonic(e));
  }
  final creds = AlanPrivateWalletCredentials(
    publicInfo: WalletPublicInfo(
      chainId: walletFormData.walletType.stringVal,
      walletId: const Uuid().v4(),
      name: walletFormData.name,
      publicAddress: wallet.bech32Address,
    ),
    mnemonic: walletFormData.mnemonic.stringRepresentation,
  );
  final result = await signingGateway.storeWalletCredentials(
    credentials: creds,
    password: walletFormData.password,
  );
  return result.fold(
    (l) => left(AddWalletFailure.storeError(l)),
    (r) => right(
      EmerisWallet(
        walletDetails: WalletDetails(
          walletIdentifier: WalletIdentifier(
            walletId: creds.publicInfo.walletId,
            chainId: creds.publicInfo.chainId,
          ),
          walletAlias: walletFormData.name,
          walletAddress: wallet.bech32Address,
        ),
        walletType: walletFormData.walletType,
      ),
    ),
  );
}
