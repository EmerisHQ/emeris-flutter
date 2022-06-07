import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/settings/settings_initial_params.dart';
import 'package:flutter_app/ui/pages/settings/settings_navigator.dart';
import 'package:flutter_app/ui/pages/settings/settings_page.dart';
import 'package:flutter_app/ui/pages/settings/settings_presentation_model.dart';
import 'package:flutter_app/ui/pages/settings/settings_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late SettingsPage page;
  late SettingsInitialParams initParams;
  late SettingsPresentationModel model;
  late SettingsPresenter presenter;
  late SettingsNavigator navigator;

  void _initMvp() {
    initParams = const SettingsInitialParams();
    model = SettingsPresentationModel(initParams, Mocks.settingsStore);
    navigator = SettingsNavigator(Mocks.appNavigator);
    presenter = SettingsPresenter(model, navigator, Mocks.updateThemeUseCase);
    page = SettingsPage(presenter: presenter);
  }

  screenshotTest(
    'settings_page',
    setUp: () {
      _initMvp();
      when(() => Mocks.settingsStore.brightness).thenAnswer((invocation) => Brightness.dark);
      when(() => Mocks.updateThemeUseCase.execute(brightness: any(named: 'brightness'))) //
          .thenAnswer((invocation) => successFuture(unit));
    },
    pageBuilder: (theme) {
      return TestAppWidget(
        themeData: theme,
        child: page,
      );
    },
  );

  test(
    'getIt page resolves successfully',
    () async {
      expect(getIt<SettingsPage>(param1: _MockSettingsInitialParams()), isNotNull);
    },
  );
}

class _MockSettingsInitialParams extends Mock implements SettingsInitialParams {}
