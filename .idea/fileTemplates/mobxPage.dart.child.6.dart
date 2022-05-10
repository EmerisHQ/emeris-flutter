#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")


import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_initial_params.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_presentation_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../mocks/mocks_definitions.dart';

void main() {
  late ${ClassName}PresentationModel model;

  // TODO implement this
  test(
    'sample test',
    () {
      //GIVEN
      model = _initModel(_initParams());

      //THEN
      expect(model, isNotNull);
    },
  );

  setUp(() {
    Mocks.init();
    prepareAppForUnitTests();
  });
}

${ClassName}InitialParams _initParams() => ${ClassName}InitialParams();

${ClassName}PresentationModel _initModel(
  ${ClassName}InitialParams initialParams,
) {
  final model = ${ClassName}PresentationModel(
    initialParams,
  );
  return model;
}
