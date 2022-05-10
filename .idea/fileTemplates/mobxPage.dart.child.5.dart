#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")

import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_navigator.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_presentation_model.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';

void main() {
  late ${ClassName}PresentationModel model;
  late ${ClassName}Presenter presenter;
  late _Mock${ClassName}Navigator navigator;

// TODO implement this
  test(
    'sample test',
    () {
      expect(presenter, isNotNull);
    },
  );

  setUp(() {
    model = _Mock${ClassName}PresentationModel();
    navigator = _Mock${ClassName}Navigator();
    presenter = ${ClassName}Presenter(
      model,
      navigator,
    );
  });
}

class _Mock${ClassName}Navigator extends Mock implements ${ClassName}Navigator {}

class _Mock${ClassName}PresentationModel extends Mock implements ${ClassName}PresentationModel {}
