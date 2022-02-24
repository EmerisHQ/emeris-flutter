import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/asset_chain.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class AssetDetailsViewModel {
  bool get isStakedAmountLoading;

  Amount get stakedAmount;

  bool get isChainListLoading;

  List<ChainAsset> get chainAssets;

  Balance get balance;

  Amount get totalAmountInUSD;
}

class AssetDetailsPresentationModel with AssetDetailsPresentationModelBase implements AssetDetailsViewModel {
  AssetDetailsPresentationModel(
    this.initialParams,
  );

  final AssetDetailsInitialParams initialParams;

  ObservableFuture<Either<GeneralFailure, Amount>>? get getStakedAmountFuture => _getStakedAmountFuture.value;

  ObservableFuture<Either<GeneralFailure, List<ChainAsset>>>? get getChainAssetsDetailsFuture =>
      _getChainAssetsDetailsFuture.value;

  @override
  bool get isStakedAmountLoading => isFutureInProgress(getStakedAmountFuture);

  @override
  bool get isChainListLoading => isFutureInProgress(getChainAssetsDetailsFuture);

  @override
  Amount get stakedAmount => _stakedAmount.value;

  List<Balance> get balances => initialParams.assetDetails.balances;

  Balance get selectedAsset => initialParams.balance;

  @override
  List<ChainAsset> get chainAssets => _chainAssets.value;

  EmerisWallet get wallet => initialParams.wallet;

  String get onChain => initialParams.balance.onChain;

  Denom get baseDenom => initialParams.balance.denom;

  @override
  Balance get balance => initialParams.balance;

  @override
  Amount get totalAmountInUSD => initialParams.assetDetails.totalAmountInUSD;
}

mixin AssetDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, Amount>>?> _getStakedAmountFuture = Observable(null);

  final Observable<ObservableFuture<Either<GeneralFailure, List<ChainAsset>>>?> _getChainAssetsDetailsFuture =
      Observable(null);

  set getStakedAmountFuture(ObservableFuture<Either<GeneralFailure, Amount>>? value) =>
      Action(() => _getStakedAmountFuture.value = value)();

  set getChainAssetsDetailsFuture(
    ObservableFuture<Either<GeneralFailure, List<ChainAsset>>>? value,
  ) =>
      Action(() => _getChainAssetsDetailsFuture.value = value)();

  final Observable<Amount> _stakedAmount = Observable(Amount.zero);

  set stakedAmount(Amount value) => Action(() => _stakedAmount.value = value)();

  final Observable<List<ChainAsset>> _chainAssets = Observable([]);

  set chainAssets(List<ChainAsset> value) => Action(() => _chainAssets.value = value)();
}
