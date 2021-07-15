import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/ethereum/ethereum_wallet_handler.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/data/sacco/sacco_wallet_handler.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_wallets_list_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/repositories/wallet_credentials_repository.dart';
import 'package:flutter_app/utils/logger.dart';

class EmerisWalletCredentialsRepository implements WalletCredentialsRepository {
  final EthereumWalletHandler _ethereumWalletHandler;
  final SaccoWalletHandler _saccoWalletHandler;

  EmerisWalletCredentialsRepository(
    this._ethereumWalletHandler,
    this._saccoWalletHandler,
  );

  @override
  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(ImportWalletFormData walletFormData) async {
    switch (walletFormData.walletType) {
      case WalletType.Eth:
        return _saccoWalletHandler.importWallet(walletFormData);
      case WalletType.Cosmos:
        return _ethereumWalletHandler.importWallet(walletFormData);
    }
  }

  @override
  Future<Either<GetWalletsListFailure, List<EmerisWallet>>> getWalletsList() async {
    //TODO implement this when TransactionSigningGateway supports it
    logError("Retrieving wallets list on start is not yet implemented");
    return right([]);
  }
}
