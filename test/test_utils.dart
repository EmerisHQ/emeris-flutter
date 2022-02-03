import 'package:dartz/dartz.dart';

Future<Either<L, R>> successFuture<L, R>(R value) => Future.value(right(value));
