import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/utils/strings.dart';

class AppInitializer {
  AppInitializer(this._walletCredentialsRepository, this._walletsStore);

  final WalletsRepository _walletCredentialsRepository;
  final WalletsStore _walletsStore;

  Future<void> init() async {
    initializeAppLocalizations(AppNavigator.navigatorKey.currentContext!);
    (await _walletCredentialsRepository.getWalletsList()).fold(
      (l) {},
      (wallets) => _walletsStore.wallets.addAll(wallets),
    );
  }
}
