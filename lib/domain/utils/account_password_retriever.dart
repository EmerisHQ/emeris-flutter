import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';

abstract class AccountPasswordRetriever {
  Future<Either<GeneralFailure, String>> getAccountPassword(AccountIdentifier accountIdentifier);
}
