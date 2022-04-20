import 'package:flutter_app/domain/domain_entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

void main() {
  late ${ClassName}UseCase useCase;

  setUp(() {
    Mocks.init();
    useCase = ${ClassName}UseCase();
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isRight(), true);
    },
  );
}
