import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class WalletDetailsViewModel {
  bool get isLoading;

  bool get isSendMoneyLoading;

  EmerisWallet get wallet;

  String get walletAddress;

  String get walletAlias;

  List<Balance> get balances;

  Amount get totalAmountInUSD;
}

class WalletDetailsPresentationModel with WalletDetailsPresentationModelBase implements WalletDetailsViewModel {
  WalletDetailsPresentationModel(
    this.initialParams,
    this._walletsStore,
  );

  final WalletDetailsInitialParams initialParams;
  final WalletsStore _walletsStore;

  ObservableFuture<Either<GeneralFailure, AssetDetails>>? get getAssetDetailsFuture => _getAssetDetailsFuture.value;

  ObservableFuture<Either<AddWalletFailure, Unit>>? get sendMoneyFuture => _sendMoneyFuture.value;

  AssetDetails get assetDetails => _assetDetails.value;

  @override
  bool get isLoading => isFutureInProgress(getAssetDetailsFuture);

  @override
  bool get isSendMoneyLoading => sendMoneyFuture?.status == FutureStatus.pending;

  @override
  EmerisWallet get wallet => _walletsStore.currentWallet;

  @override
  String get walletAddress => wallet.walletDetails.walletAddress;

  @override
  String get walletAlias => wallet.walletDetails.walletAlias;

  ReactionDisposer? disposer;

  void listenToWalletChanges(ValueChanged<EmerisWallet> callback) {
    disposer = _walletsStore.listenToWalletChanges(callback);
  }

  void dispose() => disposer?.call();

  @override
  List<Balance> get balances => assetDetails.balances;

  @override
  Amount get totalAmountInUSD => assetDetails.totalAmountInUSD;
}

mixin WalletDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, AssetDetails>>?> _getAssetDetailsFuture = Observable(null);

  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _sendMoneyFuture = Observable(null);

  set sendMoneyFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();

  set getAssetDetailsFuture(ObservableFuture<Either<GeneralFailure, AssetDetails>>? value) =>
      Action(() => _getAssetDetailsFuture.value = value)();

  final Observable<AssetDetails> _assetDetails = Observable(const AssetDetails(balances: <Balance>[]));

  set balanceList(AssetDetails value) => Action(() => _assetDetails.value = value)();
}
