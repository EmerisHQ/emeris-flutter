import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

/// Extensions for the Either, Future and MobX combinations
extension AsyncEither<L, R> on Future<Either<L, R>> {
  ObservableFuture<Either<L, R>> observableDoOn<R2>(
    R2 Function(L fail) fail,
    R2 Function(R success) success,
  ) =>
      doOn(fail: fail, success: success).asObservable();

  ObservableFuture<R2> observableAsyncFold<R2>(
    R2 Function(L fail) fail,
    R2 Function(R success) success,
  ) =>
      asyncFold(fail, success).asObservable();

  Future<R> getOrThrow() async => asyncFold(
        (l) => throw l as Object,
        (r) => r,
      );
}

bool isFutureInProgress(ObservableFuture? future) => future != null && future.status == FutureStatus.pending;
