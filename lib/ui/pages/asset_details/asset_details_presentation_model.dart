import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class AssetDetailsViewModel {
  bool get isStakedAmountLoading;

  Amount get stakedAmount;

  bool get isChainListLoading;

  List<ChainAsset> get chainAssets;

  Balance get balance;

  String get totalAmountInUSD;

  Prices get prices;
}

class AssetDetailsPresentationModel with AssetDetailsPresentationModelBase implements AssetDetailsViewModel {
  AssetDetailsPresentationModel(
    this.initialParams,
    this._blockchainMetadataStore,
  );

  final BlockchainMetadataStore _blockchainMetadataStore;
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

  List<Balance> get balances => initialParams.chainBalances;

  Balance get selectedAsset => initialParams.totalBalance;

  @override
  List<ChainAsset> get chainAssets => _chainAssets.value;

  EmerisAccount get account => initialParams.account;

  String get onChain => initialParams.totalBalance.onChain;

  Denom get baseDenom => initialParams.totalBalance.denom;

  @override
  Balance get balance => initialParams.totalBalance;

  @override
  String get totalAmountInUSD => initialParams.chainBalances.totalAmountInUSDText(prices);

  @override
  Prices get prices => _blockchainMetadataStore.prices;
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
