part of 'wallet_details_presenter.dart';

abstract class WalletDetailsViewModel {
  bool get isLoading;

  List<WalletBalancesData> get balanceList;
}

class WalletDetailsPresentationModel with WalletDetailsPresentationModelBase implements WalletDetailsViewModel {
  final WalletDetailsInitialParams initialParams;

  WalletDetailsPresentationModel(
    this.initialParams,
  );

  ObservableFuture<Either<AddWalletFailure, List<WalletBalancesData>>>? get getWalletBalancesFuture =>
      _getWalletBalancesFuture.value;

  @override
  List<WalletBalancesData> get balanceList => _balanceList.value;

  @override
  bool get isLoading => getWalletBalancesFuture == null || getWalletBalancesFuture?.status == FutureStatus.pending;
}

abstract class WalletDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<AddWalletFailure, List<WalletBalancesData>>>?> _getWalletBalancesFuture =
      Observable(null);

  set getWalletBalancesFuture(ObservableFuture<Either<AddWalletFailure, List<WalletBalancesData>>>? value) =>
      Action(() => _getWalletBalancesFuture.value = value)();

  final Observable<List<WalletBalancesData>> _balanceList = Observable([]);

  set balanceList(List<WalletBalancesData> value) => Action(() => _balanceList.value = value)();
}
