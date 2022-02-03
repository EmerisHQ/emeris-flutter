import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class AssetDetailsViewModel {
  bool get isStakedAmountLoading;

  Amount get stakedAmount;
}

class AssetDetailsPresentationModel with AssetDetailsPresentationModelBase implements AssetDetailsViewModel {
  AssetDetailsPresentationModel(
    this.initialParams,
  );

  final AssetDetailsInitialParams initialParams;

  ObservableFuture<Either<GeneralFailure, Amount>>? get getStakedAmountFuture => _getStakedAmountFuture.value;

  @override
  bool get isStakedAmountLoading => isFutureInProgress(getStakedAmountFuture);

  @override
  Amount get stakedAmount => _stakedAmount.value;
}

mixin AssetDetailsPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, Amount>>?> _getStakedAmountFuture = Observable(null);

  set getStakedAmountFuture(ObservableFuture<Either<GeneralFailure, Amount>>? value) =>
      Action(() => _getStakedAmountFuture.value = value)();

  final Observable<Amount> _stakedAmount = Observable(Amount.zero);

  set stakedAmount(Amount value) => Action(() => _stakedAmount.value = value)();
}
