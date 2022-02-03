// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';
import 'package:flutter_app/domain/model/operating_system.dart';
import 'package:flutter_app/domain/stores/platform_info_store.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_initial_params.dart';

abstract class WalletBackupIntroViewModel {
  bool get isIcloudAvailable;
}

class WalletBackupIntroPresentationModel
    with WalletBackupIntroPresentationModelBase
    implements WalletBackupIntroViewModel {
  WalletBackupIntroPresentationModel(
    this.initialParams,
    this.platformInfoStore,
  );

  final WalletBackupIntroInitialParams initialParams;
  final PlatformInfoStore platformInfoStore;

  @override
  bool get isIcloudAvailable => platformInfoStore.operatingSystem.isIcloudAvailable;

  Mnemonic get mnemonic => initialParams.mnemonic;

}

//////////////////BOILERPLATE
mixin WalletBackupIntroPresentationModelBase {}
