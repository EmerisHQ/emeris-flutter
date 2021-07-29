import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_presentation_model.dart';

class PasswordGenerationPresenter {
  PasswordGenerationPresenter(
    this._model,
    this.navigator,
    this._importWalletUseCase,
  );

  final PasswordGenerationPresentationModel _model;
  final PasswordGenerationNavigator navigator;
  final ImportWalletUseCase _importWalletUseCase;

  PasswordGenerationViewModel get viewModel => _model;

  void togglePasswordVisibilityClicked() => _model.isPasswordVisible = !_model.isPasswordVisible;

  Future<void> importWalletClicked() async {
    await _importWalletUseCase.execute(
        walletFormData: ImportWalletFormData(
      mnemonic: _model.mnemonic,
      name: "First wallet", // TODO
      password: _model.password,
      walletType: WalletType.Cosmos,
    ));
    await _importWalletUseCase.execute(
        walletFormData: ImportWalletFormData(
      mnemonic: _model.mnemonic,
      name: "Another wallet", // TODO
      password: _model.password,
      walletType: WalletType.Eth,
    ));
    navigator.openWalletsList(const WalletsListInitialParams());
  }

  // ignore: use_setters_to_change_properties
  void passwordChanged(String password) => _model.password = password;
}
