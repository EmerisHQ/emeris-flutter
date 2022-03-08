// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_initial_params.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class ImportAccountViewModel {
  bool get isLoading;

  String get loadingMessage;
}

class ImportAccountPresentationModel with ImportAccountPresentationModelBase implements ImportAccountViewModel {
  ImportAccountPresentationModel(this.initialParams);

  final ImportAccountInitialParams initialParams;

  ObservableFuture<Either<AddAccountFailure, EmerisAccount>>? get importAccountFuture => _importAccountFuture.value;

  @override
  bool get isLoading => isFutureInProgress(importAccountFuture);

  @override
  String get loadingMessage {
    if (isFutureInProgress(importAccountFuture)) {
      return strings.importingAccountProgressMessage;
    } else {
      return '';
    }
  }
}

//////////////////BOILERPLATE
mixin ImportAccountPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<AddAccountFailure, EmerisAccount>>?> _importAccountFuture = Observable(null);

  set importAccountFuture(
    ObservableFuture<Either<AddAccountFailure, EmerisAccount>>? value,
  ) =>
      Action(() => _importAccountFuture.value = value)();
}
