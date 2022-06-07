import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test(
    'getIt page resolves successfully',
    () async {
      expect(getIt<AddAccountPage>(param1: _MockAddAccountInitialParams()), isNotNull);
    },
  );
}

class _MockAddAccountInitialParams extends Mock implements AddAccountInitialParams {}
