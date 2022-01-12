import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presentation_model.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presenter.dart';
import 'package:flutter_app/ui/widgets/passcode_text_field.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PasscodePage extends StatefulWidget {
  final PasscodeInitialParams initialParams;
  final PasscodePresenter? presenter;

  const PasscodePage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  late PasscodePresenter presenter;

  PasscodeViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: PasscodePresentationModel(widget.initialParams),
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
    return Scaffold(
      appBar: const CosmosAppBar(),
      body: Padding(
        padding: EdgeInsets.all(theme.spacingL),
        child: Observer(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _title,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: theme.spacingL),
              if (model.mode == PasscodeMode.firstPasscode)
                PasscodeTextField(
                  key: const ValueKey(PasscodeMode.firstPasscode),
                  text: model.firstPasscodeText,
                  onSubmit: presenter.onPasscodeSubmit,
                ),
              if (model.mode == PasscodeMode.confirmPasscode)
                PasscodeTextField(
                  key: const ValueKey(PasscodeMode.confirmPasscode),
                  text: model.confirmPasscodeText,
                  onSubmit: presenter.onPasscodeSubmit,
                ),
              SizedBox(height: theme.spacingXL * 3),
            ],
          ),
        ),
      ),
    );
  }
}
