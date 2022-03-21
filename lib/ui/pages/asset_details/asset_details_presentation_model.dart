import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/asset.dart';
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

  Balance get balance;

  String get totalAmountInUSD;

  Prices get prices;

  List<ChainAsset> get chainAssets;
}

class AssetDetailsPresentationModel with AssetDetailsPresentationModelBase implements AssetDetailsViewModel {
  AssetDetailsPresentationModel(
    this.initialParams,
    this._blockchainMetadataStore,
  );

  final BlockchainMetadataStore _blockchainMetadataStore;
  final AssetDetailsInitialParams initialParams;

  ObservableFuture<Either<GeneralFailure, Amount>>? get getStakedAmountFuture => _getStakedAmountFuture.value;

  @override
  bool get isStakedAmountLoading => isFutureInProgress(getStakedAmountFuture);

  @override
  Amount get stakedAmount => _stakedAmount.value;

  EmerisAccount get account => initialParams.account;

  Denom get denom => initialParams.asset.denom;

  @override
  Balance get balance => initialParams.asset.totalBalance;

  @override
  String get totalAmountInUSD => initialParams.asset.totalAmountInUSDText(prices);

  @override
  Prices get prices => _blockchainMetadataStore.prices;

  @override
  List<ChainAsset> get chainAssets => initialParams.asset.chainAssets;

  Asset get asset => initialParams.asset;
}

mixin AssetDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, Amount>>?> _getStakedAmountFuture = Observable(null);

  set getStakedAmountFuture(ObservableFuture<Either<GeneralFailure, Amount>>? value) =>
      Action(() => _getStakedAmountFuture.value = value)();

  final Observable<Amount> _stakedAmount = Observable(Amount.zero);

  set stakedAmount(Amount value) => Action(() => _stakedAmount.value = value)();
}
