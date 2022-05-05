#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")


import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_initial_params.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_navigator.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_navigator.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_page.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_presentation_model.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late ${ClassName}Page page;
  late ${ClassName}InitialParams initParams;
  late ${ClassName}PresentationModel model;
  late ${ClassName}Presenter presenter;
  late ${ClassName}Navigator navigator;

  void _initMvp() {
    initParams = const ${ClassName}InitialParams();
    model = ${ClassName}PresentationModel(initParams);
    navigator = ${ClassName}Navigator(Mocks.appNavigator);
    presenter = ${ClassName}Presenter(
      model,
      navigator,
    );
    page = ${ClassName}Page(presenter: presenter);
  }
  
  screenshotTest(
    "${NAME}_page",
    setUp: _initMvp,
    pageBuilder: (theme) => TestAppWidget(
        themeData: theme,
        child: page,
      );
    }
  );
  
  test("getIt page resolves successfully", () async {

    expect(getIt<${NAME}Page>(param1: _Mock${NAME}InitialParams()), isNotNull);
  });
}

class _Mock${NAME}InitialParams extends Mock implements ${NAME}InitialParams {}
