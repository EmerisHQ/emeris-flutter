part of 'wallet_details_presenter.dart';

abstract class WalletDetailsViewModel {
  bool get isLoading;

  bool get isSendMoneyLoading;

  PaginatedList<Balance> get balanceList;
}

class WalletDetailsPresentationModel with WalletDetailsPresentationModelBase implements WalletDetailsViewModel {
  final WalletDetailsInitialParams initialParams;

  WalletDetailsPresentationModel(
    this.initialParams,
  );

  ObservableFuture<Either<AddWalletFailure, PaginatedList<Balance>>>? get getWalletBalancesFuture =>
      _getWalletBalancesFuture.value;

  ObservableFuture<Either<AddWalletFailure, Unit>>? get sendMoneyFuture => _sendMoneyFuture.value;

  @override
  PaginatedList<Balance> get balanceList => _balanceList.value;

  @override
  bool get isLoading => isFutureInProgress(getWalletBalancesFuture);

  @override
  bool get isSendMoneyLoading => sendMoneyFuture?.status == FutureStatus.pending;
}

abstract class WalletDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<AddWalletFailure, PaginatedList<Balance>>>?> _getWalletBalancesFuture =
      Observable(null);

  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _sendMoneyFuture = Observable(null);

  set sendMoneyFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();

  set getWalletBalancesFuture(ObservableFuture<Either<AddWalletFailure, PaginatedList<Balance>>>? value) =>
      Action(() => _getWalletBalancesFuture.value = value)();

  final Observable<PaginatedList<Balance>> _balanceList =
      Observable(PaginatedList<Balance>(pagination: BalancePagination(), list: const []));

  set balanceList(PaginatedList<Balance> value) => Action(() => _balanceList.value = value)();
}
