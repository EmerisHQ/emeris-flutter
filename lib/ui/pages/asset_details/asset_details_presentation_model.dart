import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/asset_chain.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class AssetDetailsViewModel {
  bool get isStakedAmountLoading;

  Amount get stakedAmount;

  bool get isChainListLoading;

  List<AssetChain> get assetChains;
}

class AssetDetailsPresentationModel with AssetDetailsPresentationModelBase implements AssetDetailsViewModel {
  AssetDetailsPresentationModel(
    this.initialParams,
  );

  final AssetDetailsInitialParams initialParams;

  ObservableFuture<Either<GeneralFailure, Amount>>? get getStakedAmountFuture => _getStakedAmountFuture.value;

  ObservableFuture<Either<GeneralFailure, List<AssetChain>>>? get getAssetChainsDetailsFuture =>
      _getAssetChainsDetailsFuture.value;

  @override
  bool get isStakedAmountLoading => isFutureInProgress(getStakedAmountFuture);

  @override
  bool get isChainListLoading => isFutureInProgress(getAssetChainsDetailsFuture);

  @override
  Amount get stakedAmount => _stakedAmount.value;

  List<Balance> get balances => initialParams.assetDetails.balances;

  Balance get selectedAsset => initialParams.balance;

  @override
  List<AssetChain> get assetChains => _assetChains.value;
}

mixin AssetDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, Amount>>?> _getStakedAmountFuture = Observable(null);

  final Observable<ObservableFuture<Either<GeneralFailure, List<AssetChain>>>?> _getAssetChainsDetailsFuture =
      Observable(null);

  set getStakedAmountFuture(ObservableFuture<Either<GeneralFailure, Amount>>? value) =>
      Action(() => _getStakedAmountFuture.value = value)();

  set getAssetChainsDetails(ObservableFuture<Either<GeneralFailure, List<AssetChain>>>? value) =>
      Action(() => _getAssetChainsDetailsFuture.value = value)();

  final Observable<Amount> _stakedAmount = Observable(Amount.zero);

  set stakedAmount(Amount value) => Action(() => _stakedAmount.value = value)();

  final Observable<List<AssetChain>> _assetChains = Observable([]);

  set assetChains(List<AssetChain> value) => Action(() => _assetChains.value = value)();
}
