import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';
import 'package:flutter_app/ui/pages/routing/routing_presenter.dart';

class RoutingPage extends StatefulWidget {
  const RoutingPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final RoutingPresenter? presenter;
  final RoutingInitialParams initialParams;

  @override
  RoutingPageState createState() => RoutingPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<RoutingPresenter?>('presenter', presenter))
      ..add(DiagnosticsProperty<RoutingInitialParams>('initialParams', initialParams));
  }
}

class RoutingPageState extends State<RoutingPage> {
  late RoutingPresenter presenter;

  RoutingViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: RoutingPresentationModel(widget.initialParams, getIt()),
          param2: getIt<RoutingNavigator>(),
        );
    presenter.navigator.context = context;
    WidgetsBinding.instance?.addPostFrameCallback((_) => presenter.init());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<RoutingPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<RoutingViewModel>('model', model));
  }
}
