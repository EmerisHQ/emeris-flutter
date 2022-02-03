import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presentation_model.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final PasscodeInitialParams initialParams;
  final PasscodePresenter? presenter;

  @override
  PasscodePageState createState() => PasscodePageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<PasscodeInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<PasscodePresenter?>('presenter', presenter));
  }
}

class PasscodePageState extends State<PasscodePage> {
  late PasscodePresenter presenter;

  PasscodeViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: PasscodePresentationModel(widget.initialParams, getIt()),
          param2: getIt<PasscodeNavigator>(),
        );
    presenter.navigator.context = context;
  }

  String get _title {
    switch (model.mode) {
      case PasscodeMode.firstPasscode:
        return strings.passcodeTitle;
      case PasscodeMode.confirmPasscode:
        return strings.confirmPasscodeTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return ContentStateSwitcher(
      isLoading: model.isLoading,
      contentChild: Scaffold(
        appBar: const CosmosAppBar(),
        body: Padding(
          padding: EdgeInsets.all(theme.spacingL),
          child: Observer(
            builder: (context) => CosmosPasscodePrompt(
              key: ValueKey(model.passcodeValueKey),
              title: _title,
              onSubmit: presenter.onPasscodeSubmit,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<PasscodePresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<PasscodeViewModel>('model', model));
  }
}
