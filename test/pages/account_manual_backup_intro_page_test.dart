import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_page.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late AccountManualBackupPage page;
  late AccountManualBackupInitialParams initParams;
  late AccountManualBackupPresentationModel model;
  late AccountManualBackupPresenter presenter;
  late AccountManualBackupNavigator navigator;

  void _initMvp() {
    initParams = AccountManualBackupInitialParams(
      mnemonic: Mnemonic.fromString(
        'stick damage injury omit inner portion '
        'core fabric middle blanket soul rebuild '
        'library genius act hour garlic load '
        'word today knee keen one apple',
      ),
    );
    model = AccountManualBackupPresentationModel(initParams);
    navigator = AccountManualBackupNavigator(Mocks.appNavigator);
    presenter = AccountManualBackupPresenter(model, navigator, Mocks.copyToClipboardUseCase);
    page = AccountManualBackupPage(presenter: presenter, taskScheduler: Mocks.taskScheduler);
    model.shuffledMnemonic = initParams.mnemonic; // this avoids mnemonic shuffling and makes the tests consistent
  }

  screenshotTest(
    'account_manual_backup_page_intro',
    setUp: _initMvp,
    pageBuilder: (theme) {
      model.step = ManualBackupStep.intro;
      return TestAppWidget(
        themeData: theme,
        child: page,
      );
    },
  );

  screenshotTest(
    'account_manual_backup_page_confirm',
    setUp: _initMvp,
    pageBuilder: (theme) {
      model.step = ManualBackupStep.confirm;
      return TestAppWidget(
        themeData: theme,
        child: page,
      );
    },
  );

  screenshotTest(
    'account_manual_backup_page_success',
    setUp: _initMvp,
    pageBuilder: (theme) {
      model.step = ManualBackupStep.success;
      return TestAppWidget(
        themeData: theme,
        child: page,
      );
    },
  );

  test('getIt page resolves successfully', () async {
    expect(getIt<AccountManualBackupPage>(param1: _MockAccountManualBackupInitialParams()), isNotNull);
  });

  setUp(() {
    when(() => Mocks.taskScheduler.schedule(any(), any())).thenAnswer((_) => Future.value(null));
  });
}

class _MockAccountManualBackupInitialParams extends Mock implements AccountManualBackupInitialParams {}
