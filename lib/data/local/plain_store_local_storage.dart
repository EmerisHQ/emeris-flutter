import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/local_storage_failure.dart';
import 'package:flutter_app/domain/stores/local_storage.dart';

class PlainStoreLocalStorage implements LocalStorage {
  const PlainStoreLocalStorage(
    this._plainDataStore,
  );

  final PlainDataStore _plainDataStore;

  @override
  Future<Either<LocalStorageFailure, Unit>> save<T>(
    String key,
    LocalStorageCodec<T> codec,
    T data,
  ) =>
      _plainDataStore
          .savePlainText(
            key: key,
            value: codec.encode(data),
          )
          .mapError(LocalStorageFailure.saveError);

  @override
  Future<Either<LocalStorageFailure, T?>> read<T>(
    String key,
    LocalStorageCodec<T> codec,
  ) =>
      _plainDataStore
          .readPlainText(key: key)
          .mapError(LocalStorageFailure.readError)
          .mapSuccess((response) => codec.decode(response));
}
