import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/assets_store.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class AccountDetailsViewModel {
  bool get isSendTokensLoading;

  EmerisAccount get account;

  String get accountAddress;

  String get accountAlias;

  List<Asset> get assets;

  String get totalAmountInUSD;

  Prices get prices;
}

class AccountDetailsPresentationModel with AccountDetailsPresentationModelBase implements AccountDetailsViewModel {
  AccountDetailsPresentationModel(
    this._accountsStore,
    this._blockchainMetadataStore,
    this._assetsStore,
    this.initialParams,
  );

  final AccountDetailsInitialParams initialParams;
  final AccountsStore _accountsStore;
  final AssetsStore _assetsStore;
  final BlockchainMetadataStore _blockchainMetadataStore;

  ObservableFuture<Either<AddAccountFailure, Unit>>? get SendTokensFuture => _SendTokensFuture.value;

  @override
  bool get isSendTokensLoading => SendTokensFuture?.status == FutureStatus.pending;

  @override
  EmerisAccount get account => _accountsStore.currentAccount;

  @override
  String get accountAddress => account.accountDetails.accountAddress;

  @override
  String get accountAlias => account.accountDetails.accountAlias;

  @override
  List<Asset> get assets => _assetsStore.getAssets(account.accountDetails.accountIdentifier);

  @override
  String get totalAmountInUSD => assets.totalAmountInUSDText(prices);

  @override
  Prices get prices => _blockchainMetadataStore.prices;
}

mixin AccountDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<AddAccountFailure, Unit>>?> _SendTokensFuture = Observable(null);

  set SendTokensFuture(ObservableFuture<Either<AddAccountFailure, Unit>>? value) =>
      Action(() => _SendTokensFuture.value = value)();
}
