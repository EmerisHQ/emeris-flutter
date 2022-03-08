import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/use_cases/generate_mnemonic_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_account_use_case.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_result.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

class AddAccountPresenter {
  AddAccountPresenter(
    this._model,
    this.navigator,
    this._importAccountUseCase,
    this._generateMnemonicUseCase,
  );

  final AddAccountPresentationModel _model;
  final AddAccountNavigator navigator;
  final ImportAccountUseCase _importAccountUseCase;
  final GenerateMnemonicUseCase _generateMnemonicUseCase;

  AddAccountViewModel get viewModel => _model;

  Future<void> init() async {
    final name = await navigator.openAccountName(const AccountNameInitialParams());
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
    final backedUp = await navigator.openAccountBackup(
      AccountBackupIntroInitialParams(
        mnemonic: mnemonic,
      ),
    );
    if (backedUp != true) {
      return navigator.close();
    }
    await _importAccount(mnemonic, name, passcode).asyncFold(
      (fail) => navigator
        ..close()
        ..showError(fail.displayableFailure()),
      (account) async => navigator.closeWithResult(
        AddAccountResult(
          account: account,
          mnemonic: mnemonic,
        ),
      ),
    );
  }

  Future<Either<AddAccountFailure, EmerisAccount>> _importAccount(Mnemonic mnemonic, String name, Passcode passcode) =>
      _model.importAccountFuture = _importAccountUseCase
          .execute(
            accountFormData: ImportAccountFormData(
              mnemonic: mnemonic,
              name: name,
              password: passcode.value,
              accountType: AccountType.Cosmos,
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
