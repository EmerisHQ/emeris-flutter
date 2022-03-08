import 'package:cosmos_ui_components/components/content_loading_indicator.dart';
import 'package:cosmos_ui_components/components/content_state_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_presenter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final AddAccountInitialParams initialParams;
  final AddAccountPresenter? presenter;

  @override
  AddAccountPageState createState() => AddAccountPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AddAccountInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<AddAccountPresenter?>('presenter', presenter));
  }
}

class AddAccountPageState extends State<AddAccountPage> {
  late AddAccountPresenter presenter;

  AddAccountViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AddAccountPresentationModel(widget.initialParams),
          param2: getIt<AddAccountNavigator>(),
        );
    presenter.navigator.context = context;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      presenter.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        body: ContentStateSwitcher(
          isLoading: model.isLoading,
          loadingChild: ContentLoadingIndicator(
            message: model.loadingMessage,
          ),
          contentChild: const Scaffold(),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AddAccountPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AddAccountViewModel>('model', model));
  }
}
