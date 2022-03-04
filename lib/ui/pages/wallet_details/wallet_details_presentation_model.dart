import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class WalletDetailsViewModel {
  bool get isLoading;

  bool get isSendTokensLoading;

  EmerisWallet get wallet;

  String get walletAddress;

  String get walletAlias;

  List<Balance> get balances;

  String get totalAmountInUSD;

  Prices get prices;
}

class WalletDetailsPresentationModel with WalletDetailsPresentationModelBase implements WalletDetailsViewModel {
  WalletDetailsPresentationModel(
    this.initialParams,
    this._walletsStore,
    this._blockchainMetadataStore,
  );

  final WalletDetailsInitialParams initialParams;
  final WalletsStore _walletsStore;
  final BlockchainMetadataStore _blockchainMetadataStore;

  ObservableFuture<Either<GeneralFailure, List<Balance>>>? get getBalancesFuture => _getBalancesFuture.value;

  ObservableFuture<Either<AddWalletFailure, Unit>>? get SendTokensFuture => _SendTokensFuture.value;

  @override
  bool get isLoading => isFutureInProgress(getBalancesFuture);

  @override
  bool get isSendTokensLoading => SendTokensFuture?.status == FutureStatus.pending;

  @override
  EmerisWallet get wallet => _walletsStore.currentWallet;

  @override
  String get walletAddress => wallet.walletDetails.walletAddress;

  @override
  String get walletAlias => wallet.walletDetails.walletAlias;

  ReactionDisposer? disposer;

  void listenToWalletChanges({required ValueChanged<EmerisWallet> doOnChange}) {
    disposer = _walletsStore.listenToWalletChanges(doOnChange);
  }

  void dispose() => disposer?.call();

  @override
  List<Balance> get balances => _balances.value;

  @override
  String get totalAmountInUSD => balances.totalAmountInUSDText(prices);

  @override
  Prices get prices => _blockchainMetadataStore.prices;
}

mixin WalletDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, List<Balance>>>?> _getBalancesFuture = Observable(null);

  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _SendTokensFuture = Observable(null);

  set SendTokensFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _SendTokensFuture.value = value)();

  set getBalancesFuture(ObservableFuture<Either<GeneralFailure, List<Balance>>>? value) =>
      Action(() => _getBalancesFuture.value = value)();

  //////////////////////////////////////
  final Observable<List<Balance>> _balances = Observable([]);

  set balances(List<Balance> value) => Action(() => _balances.value = value)();
}
