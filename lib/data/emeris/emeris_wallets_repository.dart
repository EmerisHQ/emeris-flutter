import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/wallet_api.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_wallets_list_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/model/failures/verify_wallet_password_failure.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/utils/logger.dart';

class EmerisWalletsRepository implements WalletsRepository {
  final List<WalletApi> _walletApis;

  EmerisWalletsRepository(this._walletApis);

  @override
  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(ImportWalletFormData walletFormData) async {
    return WalletApi.forType(_walletApis, walletFormData.walletType)?.importWallet(walletFormData) ??
        Future.value(left(AddWalletFailure.unknown(
          cause: "Could not find wallet api for ${walletFormData.walletType}",
        )));
  }

  @override
  Future<Either<GetWalletsListFailure, List<EmerisWallet>>> getWalletsList() async {
    //TODO implement this when TransactionSigningGateway supports it
    logError("Retrieving wallets list on start is not yet implemented");
    return right([]);
  }

  @override
  Future<Either<VerifyWalletPasswordFailure, bool>> verifyPassword(WalletIdentifier walletIdentifier) async {
    //TODO implement this when TransactionSigningGateway supports it
    logError("Verifying password for transactionSigningGateway is not implemented");
    return right(true);
  }
}
