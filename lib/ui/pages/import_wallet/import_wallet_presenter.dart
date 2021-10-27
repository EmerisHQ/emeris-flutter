import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_initial_params.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:mobx/mobx.dart';

class ImportWalletPresenter {
  ImportWalletPresenter(
    this._model,
    this.navigator,
    this._importWalletUseCase,
  );

  final ImportWalletPresentationModel _model;
  final ImportWalletNavigator navigator;

  final ImportWalletUseCase _importWalletUseCase;

  ImportWalletViewModel get viewModel => _model;

  Future<void> init() async {
    {
      final name = await _openNamePage();
      if (name == null) {
        return navigator.close();
      }
      final mnemonic = await _openMnemonicImportPage();
      if (mnemonic == null) {
        return navigator.close();
      }
      final passcode = await navigator.openPasscode(
        const PasscodeInitialParams(
          requirePasscodeConfirmation: true,
        ),
      );
      if (passcode == null) {
        return navigator.close();
      }
      await _importWallet(mnemonic, name, passcode).asyncFold(
        (fail) => navigator
          ..close()
          ..showError(fail.displayableFailure()),
        (newWallet) => navigator.closeWithResult(newWallet),
      );
    }
  }

  Future<String?> _openNamePage() => navigator.openWalletName(const WalletNameInitialParams());

  Future<Mnemonic?> _openMnemonicImportPage() => navigator.openMnemonicImport(const MnemonicImportInitialParams());

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
}
