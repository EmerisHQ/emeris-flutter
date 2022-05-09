import 'dart:async';

import 'mocks/mocks.dart';
import 'test_utils/golden_test_utils.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  Mocks.init();
  await prepareAppForUnitTests();
  return await testMain();
}
