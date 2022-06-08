import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_initial_parameters.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_navigator.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_page.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late RenameAccountPage page;
  late RenameAccountInitialParams initParams;
  late RenameAccountPresentationModel model;
  late RenameAccountPresenter presenter;
  late RenameAccountNavigator navigator;
  const updatedName = 'Hello';

  void _initMvp() {
    initParams = const RenameAccountInitialParams(emerisAccount: EmerisAccount.empty());
    model = RenameAccountPresentationModel(initParams);
    navigator = RenameAccountNavigator(Mocks.appNavigator);
    presenter = RenameAccountPresenter(model, navigator, Mocks.renameAccountUseCase);
    page = RenameAccountPage(presenter: presenter);
  }

  screenshotTest(
    'rename_account_page',
    setUp: () {
      _initMvp();
      when(
        () => Mocks.renameAccountUseCase.execute(
          emerisAccount: any(named: 'emerisAccount'),
          updatedName: updatedName,
        ),
      ) //
          .thenAnswer((invocation) => successFuture(unit));
    },
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  test(
    'getIt page resolves successfully',
    () async {
      expect(getIt<RenameAccountPage>(param1: _MockRenameAccountInitialParams()), isNotNull);
    },
  );
}

class _MockRenameAccountInitialParams extends Mock implements RenameAccountInitialParams {}
