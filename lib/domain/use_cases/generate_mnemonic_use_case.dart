import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/model/failures/generate_mnemonic_failure.dart';

class GenerateMnemonicUseCase {
  Future<Either<GenerateMnemonicFailure, String>> execute() async => right(generateMnemonic());
}
