// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_initial_params.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class ImportWalletViewModel {
  bool get isLoading;

  String get loadingMessage;
}

class ImportWalletPresentationModel with ImportWalletPresentationModelBase implements ImportWalletViewModel {
  ImportWalletPresentationModel(this.initialParams);

  final ImportWalletInitialParams initialParams;

  ObservableFuture<Either<AddWalletFailure, EmerisWallet>>? get importWalletFuture => _importWalletFuture.value;

  @override
  bool get isLoading => isFutureInProgress(importWalletFuture);

  @override
  String get loadingMessage {
    if (isFutureInProgress(importWalletFuture)) {
      return strings.importingWalletProgressMessage;
    } else {
      return '';
    }
  }
}

//////////////////BOILERPLATE
mixin ImportWalletPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<AddWalletFailure, EmerisWallet>>?> _importWalletFuture = Observable(null);

  set importWalletFuture(ObservableFuture<Either<AddWalletFailure, EmerisWallet>>? value) =>
      Action(() => _importWalletFuture.value = value)();
}
