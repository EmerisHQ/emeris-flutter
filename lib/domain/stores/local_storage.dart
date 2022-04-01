import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/local_storage_failure.dart';

abstract class LocalStorage {
  Future<Either<LocalStorageFailure, Unit>> save<T>(
    String key,
    LocalStorageCodec<T> codec,
    T data,
  );

  Future<Either<LocalStorageFailure, T?>> read<T>(
    String key,
    LocalStorageCodec<T> codec,
  );
}

abstract class LocalStorageCodec<T> {
  String encode(T object);

  T? decode(String? encoded);
}

T decodeJsonString<T>(String data, T Function(Map<String, dynamic>) decoder) =>
    decoder(jsonDecode(data) as Map<String, dynamic>);
