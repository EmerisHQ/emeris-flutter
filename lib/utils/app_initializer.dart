import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/utils/strings.dart';

class AppInitializer {
  AppInitializer(
    this._appLocalizationsInitializer,
    this._accountRepository,
    this._accountsStore,
    this._settingsStore,
    this._authRepository,
  );

  final AppLocalizationsInitializer _appLocalizationsInitializer;
  final AccountsRepository _accountRepository;
  final AccountsStore _accountsStore;
  final SettingsStore _settingsStore;
  final AuthRepository _authRepository;

  Future<void> init() async {
    _appLocalizationsInitializer.initializeAppLocalizations();
    await _settingsStore.init(_authRepository);
    (await _accountRepository.getAccountsList()).fold(
      (l) {},
      _accountsStore.addAllAccounts,
    );
  }
}
