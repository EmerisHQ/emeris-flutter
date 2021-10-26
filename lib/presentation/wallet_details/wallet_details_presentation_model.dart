part of 'wallet_details_presenter.dart';

abstract class WalletDetailsViewModel {
  bool get isLoading;

  bool get isSendMoneyLoading;

  AssetDetails get assetDetails;
}

class WalletDetailsPresentationModel with WalletDetailsPresentationModelBase implements WalletDetailsViewModel {
  final WalletDetailsInitialParams initialParams;

  WalletDetailsPresentationModel(
    this.initialParams,
  );

  ObservableFuture<Either<GeneralFailure, AssetDetails>>? get getAssetDetailsFuture => _getAssetDetailsFuture.value;

  ObservableFuture<Either<AddWalletFailure, Unit>>? get sendMoneyFuture => _sendMoneyFuture.value;

  @override
  AssetDetails get assetDetails => _assetDetails.value;

  @override
  bool get isLoading => isFutureInProgress(getAssetDetailsFuture);

  @override
  bool get isSendMoneyLoading => sendMoneyFuture?.status == FutureStatus.pending;
}

abstract class WalletDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, AssetDetails>>?> _getAssetDetailsFuture = Observable(null);

  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _sendMoneyFuture = Observable(null);

  set sendMoneyFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();

  set getAssetDetailsFuture(ObservableFuture<Either<GeneralFailure, AssetDetails>>? value) =>
      Action(() => _getAssetDetailsFuture.value = value)();

  final Observable<AssetDetails> _assetDetails = Observable(const AssetDetails(balances: <Balance>[]));

  set balanceList(AssetDetails value) => Action(() => _assetDetails.value = value)();
}
