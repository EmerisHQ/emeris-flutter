import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late OnboardingPage page;
  late OnboardingInitialParams initParams;
  late OnboardingPresentationModel model;
  late OnboardingPresenter presenter;
  late OnboardingNavigator navigator;

  void _initMvp() {
    initParams = const OnboardingInitialParams();
    model = OnboardingPresentationModel(initParams);
    navigator = OnboardingNavigator(Mocks.appNavigator);
    presenter = OnboardingPresenter(
      model,
      navigator,
    );
    page = OnboardingPage(presenter: presenter);
  }

  screenshotTest(
    'onboarding_page',
    setUp: _initMvp,
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  test('getIt page resolves successfully', () async {
    expect(getIt<OnboardingPage>(param1: _MockOnboardingInitialParams()), isNotNull);
  });
}

class _MockOnboardingInitialParams extends Mock implements OnboardingInitialParams {}
