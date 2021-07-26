import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';

abstract class WalletPasswordRetriever {
  Future<Either<GeneralFailure, String>> getWalletPassword(WalletIdentifier walletIdentifier);
}
