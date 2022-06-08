import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_page.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late AccountNamePage page;
  late AccountNameInitialParams initParams;
  late AccountNamePresentationModel model;
  late AccountNamePresenter presenter;
  late AccountNameNavigator navigator;

  void _initMvp() {
    initParams = const AccountNameInitialParams();
    model = AccountNamePresentationModel(initParams);
    navigator = AccountNameNavigator(Mocks.appNavigator);
    presenter = AccountNamePresenter(
      model,
      navigator,
    );
    page = AccountNamePage(presenter: presenter);
  }

  screenshotTest(
    'account_name_page',
    setUp: _initMvp,
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  test(
    'getIt page resolves successfully',
    () async {
      expect(getIt<AccountNamePage>(param1: _MockAccountNameInitialParams()), isNotNull);
    },
  );
}

class _MockAccountNameInitialParams extends Mock implements AccountNameInitialParams {}
