// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/domain/entities/operating_system.dart';
import 'package:flutter_app/domain/stores/platform_info_store.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_initial_params.dart';

abstract class AccountBackupIntroViewModel {
  bool get isIcloudAvailable;
}

class AccountBackupIntroPresentationModel
    with AccountBackupIntroPresentationModelBase
    implements AccountBackupIntroViewModel {
  AccountBackupIntroPresentationModel(
    this.initialParams,
    this.platformInfoStore,
  );

  final AccountBackupIntroInitialParams initialParams;
  final PlatformInfoStore platformInfoStore;

  @override
  bool get isIcloudAvailable => platformInfoStore.operatingSystem.isIcloudAvailable;

  Mnemonic get mnemonic => initialParams.mnemonic;
}

//////////////////BOILERPLATE
mixin AccountBackupIntroPresentationModelBase {}
