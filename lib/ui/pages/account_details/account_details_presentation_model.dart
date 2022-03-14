import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class AccountDetailsViewModel {
  bool get isLoading;

  bool get isSendTokensLoading;

  EmerisAccount get account;

  String get accountAddress;

  String get accountAlias;

  List<Balance> get balances;

  String get totalAmountInUSD;

  Prices get prices;
}

class AccountDetailsPresentationModel with AccountDetailsPresentationModelBase implements AccountDetailsViewModel {
  AccountDetailsPresentationModel(
    this.initialParams,
    this._accountsStore,
    this._blockchainMetadataStore,
  );

  final AccountDetailsInitialParams initialParams;
  final AccountsStore _accountsStore;
  final BlockchainMetadataStore _blockchainMetadataStore;

  ObservableFuture<Either<GeneralFailure, List<Balance>>>? get getBalancesFuture => _getBalancesFuture.value;

  ObservableFuture<Either<AddAccountFailure, Unit>>? get SendTokensFuture => _SendTokensFuture.value;

  @override
  bool get isLoading => isFutureInProgress(getBalancesFuture);

  @override
  bool get isSendTokensLoading => SendTokensFuture?.status == FutureStatus.pending;

  @override
  EmerisAccount get account => _accountsStore.currentAccount;

  @override
  String get accountAddress => account.accountDetails.accountAddress;

  @override
  String get accountAlias => account.accountDetails.accountAlias;

  ReactionDisposer? disposer;

  void listenToAccountChanges({required ValueChanged<EmerisAccount> doOnChange}) {
    disposer = _accountsStore.listenToAccountChanges(doOnChange);
  }

  void dispose() => disposer?.call();

  @override
  List<Balance> get balances => _balances.value;

  @override
  String get totalAmountInUSD => balances.totalAmountInUSDText(prices);

  @override
  Prices get prices => _blockchainMetadataStore.prices;
}

mixin AccountDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, List<Balance>>>?> _getBalancesFuture = Observable(null);

  final Observable<ObservableFuture<Either<AddAccountFailure, Unit>>?> _SendTokensFuture = Observable(null);

  set SendTokensFuture(ObservableFuture<Either<AddAccountFailure, Unit>>? value) =>
      Action(() => _SendTokensFuture.value = value)();

  set getBalancesFuture(ObservableFuture<Either<GeneralFailure, List<Balance>>>? value) =>
      Action(() => _getBalancesFuture.value = value)();

  //////////////////////////////////////
  final Observable<List<Balance>> _balances = Observable([]);

  set balances(List<Balance> value) => Action(() => _balances.value = value)();
}
