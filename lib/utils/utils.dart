import 'package:dartz/dartz.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:mobx/mobx.dart';

/// does... nothing ;)
T? doNothing<T>() {}

extension IterableExtensions<T> on Iterable<T> {
  /// maps the passed iterable with the mapper that accepts index and element.
  Iterable<T2> mapIndexed<T2>(T2 Function(int, T) mapper) {
    return toList() //
        .asMap()
        .map((key, value) => MapEntry(key, mapper(key, value)))
        .values;
  }
}

/// Extensions for the Either, Future and MobX combinations
extension AsyncEither<L, R> on Future<Either<L, R>> {
  Future<Either<L2, R>> mapError<L2>(L2 Function(L fail) errorMapper) async {
    return (await this).leftMap(errorMapper);
  }

  Future<Either<L, R2>> mapSuccess<R2>(R2 Function(R response) responseMapper) async {
    return (await this).map(responseMapper);
  }

  Future<Either<L, R>> doOn<R2>({
    R2 Function(L fail)? fail,
    R2 Function(R success)? success,
  }) async {
    try {
      (await this).fold(fail ?? (_) {}, success ?? (_) {});
      return this;
    } catch (e, stack) {
      logError(e, stack);
      rethrow;
    }
  }

  ObservableFuture<Either<L, R>> observableDoOn<R2>(
    R2 Function(L fail) fail,
    R2 Function(R success) success,
  ) =>
      doOn(fail: fail, success: success).asObservable();

  Future<R2> asyncFold<R2>(
    R2 Function(L fail) fail,
    R2 Function(R success) success,
  ) async =>
      (await this).fold(fail, success);

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
