import 'package:bip39/bip39.dart' as bip39;
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/model/failures/generate_mnemonic_failure.dart';

class GenerateMnemonicUseCase {
  Future<Either<GenerateMnemonicFailure, String>> execute() async => right(bip39.generateMnemonic(strength: 256));
}
