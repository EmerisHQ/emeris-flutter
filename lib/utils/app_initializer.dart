import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/utils/strings.dart';

class AppInitializer {
  AppInitializer(
    this._appLocalizationsInitializer,
    this._walletRepository,
    this._walletsStore,
    this._settingsStore,
    this._authRepository,
  );

  final AppLocalizationsInitializer _appLocalizationsInitializer;
  final WalletsRepository _walletRepository;
  final WalletsStore _walletsStore;
  final SettingsStore _settingsStore;
  final AuthRepository _authRepository;

  Future<void> init() async {
    _appLocalizationsInitializer.initializeAppLocalizations();
    await _settingsStore.init(_authRepository);
    (await _walletRepository.getWalletsList()).fold(
      (l) {},
      _walletsStore.addAllWallets,
    );
  }
}
