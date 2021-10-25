// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class AddWalletViewModel {}

class AddWalletPresentationModel with AddWalletPresentationModelBase implements AddWalletViewModel {
  final AddWalletInitialParams initialParams;

  @override
  bool get isLoading => isFutureInProgress(importWalletFuture) || isFutureInProgress(generateMnemonicFuture);

  AddWalletPresentationModel(this.initialParams);

  ObservableFuture<Either<AddWalletFailure, EmerisWallet>>? get importWalletFuture => _importWalletFuture.value;

  ObservableFuture<Mnemonic?>? get generateMnemonicFuture => _generateMnemonicFuture.value;
}

//////////////////BOILERPLATE
abstract class AddWalletPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<AddWalletFailure, EmerisWallet>>?> _importWalletFuture = Observable(null);

  set importWalletFuture(ObservableFuture<Either<AddWalletFailure, EmerisWallet>>? value) =>
      Action(() => _importWalletFuture.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Mnemonic?>?> _generateMnemonicFuture = Observable(null);

  set generateMnemonicFuture(ObservableFuture<Mnemonic?>? value) =>
      Action(() => _generateMnemonicFuture.value = value)();
}
