import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class WalletDetailsViewModel {
  bool get isLoading;

  bool get isSendMoneyLoading;

  AssetDetails get assetDetails;
}

class WalletDetailsPresentationModel with WalletDetailsPresentationModelBase implements WalletDetailsViewModel {
  WalletDetailsPresentationModel(
    this.initialParams,
  );

  final WalletDetailsInitialParams initialParams;

  ObservableFuture<Either<GeneralFailure, AssetDetails>>? get getAssetDetailsFuture => _getAssetDetailsFuture.value;

  ObservableFuture<Either<AddWalletFailure, Unit>>? get sendMoneyFuture => _sendMoneyFuture.value;

  @override
  AssetDetails get assetDetails => _assetDetails.value;

  @override
  bool get isLoading => isFutureInProgress(getAssetDetailsFuture);

  @override
  bool get isSendMoneyLoading => sendMoneyFuture?.status == FutureStatus.pending;
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
