import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/domain/entities/operating_system.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_page.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late AccountBackupIntroPage page;
  late AccountBackupIntroInitialParams initParams;
  late AccountBackupIntroPresentationModel model;
  late AccountBackupIntroPresenter presenter;
  late AccountBackupIntroNavigator navigator;

  void _initMvp() {
    initParams = AccountBackupIntroInitialParams(
      mnemonic: Mnemonic.fromString(
        'stick damage injury omit inner portion '
        'core fabric middle blanket soul rebuild '
        'library genius act hour garlic load '
        'word today knee keen one apple',
      ),
    );
    model = AccountBackupIntroPresentationModel(initParams, Mocks.platformInfoStore);
    navigator = AccountBackupIntroNavigator(Mocks.appNavigator);
    presenter = AccountBackupIntroPresenter(
      model,
      navigator,
    );
    page = AccountBackupIntroPage(presenter: presenter);
  }

  screenshotTest(
    'account_backup_info_page_iOS',
    setUp: () {
      _initMvp();
      when(() => Mocks.platformInfoStore.operatingSystem).thenAnswer((invocation) => OperatingSystem.iOS);
    },
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );
  screenshotTest(
    'account_backup_info_page_Android',
    setUp: () {
      _initMvp();
      when(() => Mocks.platformInfoStore.operatingSystem).thenAnswer((invocation) => OperatingSystem.Android);
    },
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  test('getIt page resolves successfully', () async {
    expect(getIt<AccountBackupIntroPage>(param1: _MockAccountBackupIntroInitialParams()), isNotNull);
  });
}

class _MockAccountBackupIntroInitialParams extends Mock implements AccountBackupIntroInitialParams {}
