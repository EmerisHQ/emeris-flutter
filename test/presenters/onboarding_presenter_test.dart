import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_result.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late OnboardingPresentationModel model;
  late OnboardingPresenter presenter;
  late _MockOnboardingNavigator navigator;

  test(
    'should open Create Account page on tap',
    () async {
      when(() => navigator.openAddAccount(any())).thenAnswer((_) => Future.value(const AddAccountResult.empty()));
      await presenter.onTapCreateAccount();
      verify(() => navigator.openAddAccount(any()));
      verify(() => navigator.openRouting(any()));
      verifyNoMoreInteractions(navigator);
    },
  );

  test(
    'should open Create Account page on tap',
    () async {
      when(() => navigator.openImportAccount(any())).thenAnswer((_) => Future.value(const EmerisAccount.empty()));
      await presenter.onTapImportAccount();
      verify(() => navigator.openImportAccount(any()));
      verify(() => navigator.openRouting(any()));
      verifyNoMoreInteractions(navigator);
    },
  );
  test(
    'should not open routing if Create Account is cancelled',
    () async {
      when(() => navigator.openAddAccount(any())).thenAnswer((_) => Future.value(null));
      await presenter.onTapCreateAccount();
      verify(() => navigator.openAddAccount(any()));
      verifyNever(() => navigator.openRouting(any()));
      verifyNoMoreInteractions(navigator);
    },
  );

  test(
    'should not open routing if Import Account is cancelled',
    () async {
      when(() => navigator.openImportAccount(any())).thenAnswer((_) => Future.value(null));
      await presenter.onTapImportAccount();
      verify(() => navigator.openImportAccount(any()));
      verifyNever(() => navigator.openRouting(any()));
      verifyNoMoreInteractions(navigator);
    },
  );

  setUp(() {
    model = _MockOnboardingPresentationModel();
    navigator = _MockOnboardingNavigator();
    presenter = OnboardingPresenter(
      model,
      navigator,
    );
    when(() => navigator.openRouting(any())).thenAnswer((_) => Future.value(null));
  });
}

class _MockOnboardingNavigator extends Mock implements OnboardingNavigator {}

class _MockOnboardingPresentationModel extends Mock implements OnboardingPresentationModel {}
