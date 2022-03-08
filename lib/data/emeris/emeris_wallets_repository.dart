import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/wallet_api.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/delete_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_wallets_list_failure.dart';
import 'package:flutter_app/domain/entities/failures/verify_wallet_password_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/account_lookup_key.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';

class EmerisWalletsRepository implements WalletsRepository {
  EmerisWalletsRepository(this._walletApis, this._signingGateway);

  final List<WalletApi> _walletApis;
  final TransactionSigningGateway _signingGateway;

  @override
  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(ImportWalletFormData walletFormData) async {
    return WalletApi.forType(_walletApis, walletFormData.walletType)?.importWallet(walletFormData) ??
        Future.value(
          left(
            AddWalletFailure.unknown(
              cause: 'Could not find wallet api for ${walletFormData.walletType}',
            ),
          ),
        );
  }

  @override
  Future<Either<GetWalletsListFailure, List<EmerisWallet>>> getWalletsList() async {
    return _signingGateway.getAccountsList() //
        .map(
      (walletsList) {
        final emerisList = walletsList.map((wallet) => wallet.toEmerisWallet()).toList();
        return right(emerisList);
      },
    ).leftMap<GetWalletsListFailure>(
      (fail) {
        logError(fail, StackTrace.current);
        return left(const GetWalletsListFailure.unknown());
      },
    );
  }

  @override
  Future<Either<VerifyWalletPasswordFailure, bool>> verifyPassword(WalletIdentifier walletIdentifier) async {
    return _signingGateway
        .verifyLookupKey(
          AccountLookupKey(
            chainId: walletIdentifier.chainId,
            accountId: walletIdentifier.walletId,
            password: walletIdentifier.password ?? '',
          ),
        )
        .leftMap(
          (_) => left(const VerifyWalletPasswordFailure.invalidPassword()),
        )
        .map(
          (isValid) => isValid //
              ? right(true)
              : left(const VerifyWalletPasswordFailure.invalidPassword()),
        );
  }

  @override
  Future<Either<DeleteWalletFailure, Unit>> deleteWallet(WalletIdentifier walletIdentifier) => _signingGateway
      .deleteAccountCredentials(
        publicInfo: AccountPublicInfo(
          name: '',
          publicAddress: '',
          accountId: walletIdentifier.walletId,
          chainId: walletIdentifier.chainId,
        ),
      )
      .mapError(
        (fail) => DeleteWalletFailure.unknown(cause: fail),
      );
}

extension WalletPublicInfoTranslator on AccountPublicInfo {
  EmerisWallet toEmerisWallet() {
    return EmerisWallet(
      walletDetails: WalletDetails(
        walletIdentifier: WalletIdentifier(
          walletId: accountId,
          chainId: chainId,
        ),
        walletAddress: publicAddress,
        walletAlias: name,
      ),
      walletType: WalletTypeString.fromString(chainId) ?? WalletType.Cosmos,
    );
  }
}
