import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';

Either<GeneralFailure, Unit> checkError(Response response) {
  final statusCode = response.statusCode;

  if (statusCode == null) {
    return left(GeneralFailure.unknown('An unexpected error occurred'));
  }
  if (statusCode >= HttpStatus.badRequest) {
    return left(GeneralFailure.unknown('An unexpected error occurred'));
  }
  return right(unit);
}
