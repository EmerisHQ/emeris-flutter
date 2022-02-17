import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/use_cases/generate_mnemonic_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_result.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

class AddWalletPresenter {
  AddWalletPresenter(
    this._model,
    this.navigator,
    this._importWalletUseCase,
    this._generateMnemonicUseCase,
  );

  final AddWalletPresentationModel _model;
  final AddWalletNavigator navigator;
  final ImportWalletUseCase _importWalletUseCase;
  final GenerateMnemonicUseCase _generateMnemonicUseCase;

  AddWalletViewModel get viewModel => _model;

  Future<void> init() async {
    final name = await navigator.openWalletName(const WalletNameInitialParams());
    if (name == null) {
      return navigator.close();
    }
    final passcode = await navigator.openPasscode(
      const PasscodeInitialParams(),
    );
    if (passcode == null) {
      return navigator.close();
    }
    final mnemonic = await _generateMnemonic();
    if (mnemonic == null) {
      return;
    }
    final backedUp = await navigator.openWalletBackup(
      WalletBackupIntroInitialParams(
        mnemonic: mnemonic,
      ),
    );
    if (backedUp != true) {
      return navigator.close();
    }
    await _importWallet(mnemonic, name, passcode).asyncFold(
      (fail) => navigator
        ..close()
        ..showError(fail.displayableFailure()),
      (wallet) async => navigator.closeWithResult(
        AddWalletResult(
          wallet: wallet,
          mnemonic: mnemonic,
        ),
      ),
    );
  }

  Future<Either<AddWalletFailure, EmerisWallet>> _importWallet(Mnemonic mnemonic, String name, Passcode passcode) =>
      _model.importWalletFuture = _importWalletUseCase
          .execute(
            walletFormData: ImportWalletFormData(
              mnemonic: mnemonic,
              name: name,
              password: passcode.value,
              walletType: WalletType.Cosmos,
            ),
          )
          .asObservable();

  Future<Mnemonic?> _generateMnemonic() async =>
      _model.generateMnemonicFuture = _generateMnemonicUseCase.execute().observableAsyncFold<Mnemonic?>(
        (fail) {
          navigator
            ..close()
            ..showError(fail.displayableFailure());
          return null;
        },
        (mnemonic) => mnemonic,
      );
}
