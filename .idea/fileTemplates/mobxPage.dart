#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_presenter.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_initial_params.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_navigator.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_presentation_model.dart';

class ${ClassName}Page extends StatefulWidget {
  const ${ClassName}Page({
    required this.initialParams,
    this.presenter, // useful for tests
    Key? key, 
  }): super(key: key);
  
  final ${ClassName}InitialParams initialParams;
  final ${ClassName}Presenter? presenter;
      
  @override
  State<${ClassName}Page> createState() => _${ClassName}PageState();
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<${ClassName}InitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<${ClassName}Presenter?>('presenter', presenter));
  }
}

class _${ClassName}PageState extends State<${ClassName}Page> {
  late ${ClassName}Presenter presenter;
  ${ClassName}ViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
            param1: ${ClassName}PresentationModel(widget.initialParams),
            param2: getIt<${ClassName}Navigator>(),
        );
    presenter.navigator.context = context;
  }

  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('${ClassName} Page'),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<${ClassName}Presenter>('presenter', presenter))
      ..add(DiagnosticsProperty<${ClassName}ViewModel>('model', model));
  }
}
