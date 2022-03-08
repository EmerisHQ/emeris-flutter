import 'package:cosmos_ui_components/components/content_loading_indicator.dart';
import 'package:cosmos_ui_components/components/content_state_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_initial_params.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_navigator.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_presenter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ImportAccountPage extends StatefulWidget {
  const ImportAccountPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final ImportAccountInitialParams initialParams;
  final ImportAccountPresenter? presenter;

  @override
  ImportAccountPageState createState() => ImportAccountPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ImportAccountInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<ImportAccountPresenter?>('presenter', presenter));
  }
}

class ImportAccountPageState extends State<ImportAccountPage> {
  late ImportAccountPresenter presenter;

  ImportAccountViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: ImportAccountPresentationModel(widget.initialParams),
          param2: getIt<ImportAccountNavigator>(),
        );
    presenter.navigator.context = context;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => presenter.init());
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
      ..add(DiagnosticsProperty<ImportAccountPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<ImportAccountViewModel>('model', model));
  }
}
