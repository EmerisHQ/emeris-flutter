import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/generate_mnemonic_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';

class OnboardingPresenter {
  OnboardingPresenter(
    this._model,
    this.navigator,
    this._walletsStore,
    this._importWalletUseCase,
    this._generateMnemonicUseCase,
  );

  final WalletsStore _walletsStore;
  final OnboardingPresentationModel _model;
  final ImportWalletUseCase _importWalletUseCase;
  final OnboardingNavigator navigator;
  final GenerateMnemonicUseCase _generateMnemonicUseCase;

  OnboardingViewModel get viewModel => _model;

  Future<void> onTapCreateWallet() async {
    final name = await _openNamePage();
    if (name == null) {
      return;
    }
    final passcode = await navigator.openPasscode(
      const PasscodeInitialParams(
        requirePasscodeConfirmation: true,
      ),
    );
    if (passcode == null) {
      return;
    }
    final mnemonic = await _generateMnemonic();
    if (mnemonic == null) {
      return;
    }
    final wallet = await _importWallet(mnemonic, name, passcode);
    if (wallet == null) {
      return;
    }
    navigator.close();
    navigator.openWalletBackup(WalletBackupIntroInitialParams(wallet: wallet));
  }

  Future<EmerisWallet?> _importWallet(String mnemonic, String name, Passcode passcode) {
    final future = _importWalletUseCase.execute(
      walletFormData: ImportWalletFormData(
        mnemonic: mnemonic,
        name: name,
        password: passcode.value,
        walletType: WalletType.Cosmos,
      ),
    );
    _model.importWalletFuture = future.observableDoOn(
      (fail) => navigator.showError(fail.displayableFailure()),
      (success) {},
    );
    return future.asyncFold((fail) => null, (success) => success);
  }

  Future<String?> _openNamePage() async {
    String? name;
    if (_walletsStore.wallets.isEmpty) {
      name = await navigator.openWalletName(const WalletNameInitialParams());
    } else {
      name = "";
    }
    return name;
  }

  Future<String?> _generateMnemonic() async =>
      _model.generateMnemonicFuture = _generateMnemonicUseCase.execute().observableAsyncFold<String?>(
        (fail) {
          navigator.showError(fail.displayableFailure());
          return null;
        },
        (mnemonic) => mnemonic,
      );

  void onTapImportWallet() => notImplemented(AppNavigator.navigatorKey.currentContext!);
}
