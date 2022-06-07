import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_initial_parameters.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test(
    'getIt page resolves successfully',
    () async {
      expect(getIt<RenameAccountPage>(param1: _MockRenameAccountInitialParams()), isNotNull);
    },
  );
}

class _MockRenameAccountInitialParams extends Mock implements RenameAccountInitialParams {}
