part of 'wallet_details_presenter.dart';

abstract class WalletDetailsViewModel {
  bool get isLoading;

  bool get isSendMoneyLoading;

  List<WalletBalancesData> get balanceList;
}

class WalletDetailsPresentationModel with WalletDetailsPresentationModelBase implements WalletDetailsViewModel {
  final WalletDetailsInitialParams initialParams;

  WalletDetailsPresentationModel(
    this.initialParams,
  );

  ObservableFuture<Either<AddWalletFailure, List<WalletBalancesData>>>? get getWalletBalancesFuture =>
      _getWalletBalancesFuture.value;

  ObservableFuture<Either<AddWalletFailure, Unit>>? get sendMoneyFuture => _sendMoneyFuture.value;

  @override
  List<WalletBalancesData> get balanceList => _balanceList.value;

  @override
  bool get isLoading => getWalletBalancesFuture == null || getWalletBalancesFuture?.status == FutureStatus.pending;

  @override
  bool get isSendMoneyLoading => sendMoneyFuture?.status == FutureStatus.pending;
}

abstract class WalletDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<AddWalletFailure, List<WalletBalancesData>>>?> _getWalletBalancesFuture =
      Observable(null);

  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _sendMoneyFuture = Observable(null);

  set getWalletBalancesFuture(ObservableFuture<Either<AddWalletFailure, List<WalletBalancesData>>>? value) =>
      Action(() => _getWalletBalancesFuture.value = value)();

  set sendMoneyFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();

  final Observable<List<WalletBalancesData>> _balanceList = Observable([]);

  set balanceList(List<WalletBalancesData> value) => Action(() => _balanceList.value = value)();
}
