import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/generate_mnemonic_failure.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';

class GenerateMnemonicUseCase {
  Future<Either<GenerateMnemonicFailure, Mnemonic>> execute() async {
    try {
      return right(Mnemonic.fromString(await generateMnemonic()));
    } catch (ex, stack) {
      logError(ex, stack);
      return left(const GenerateMnemonicFailure.unknown());
    }
  }
}
