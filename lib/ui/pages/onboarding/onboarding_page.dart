import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
import 'package:flutter_app/ui/pages/onboarding/widgets/welcome_splash.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/strings.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final OnboardingPresenter presenter;

  @override
  OnboardingPageState createState() => OnboardingPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<OnboardingPresenter?>('presenter', presenter));
  }
}

class OnboardingPageState extends State<OnboardingPage> {
  OnboardingPresenter get presenter => widget.presenter;

  OnboardingViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Scaffold(
      appBar: const EmerisLogoAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacingL,
            vertical: theme.spacingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(child: WelcomeSplash()),
              SizedBox(
                height: CosmosTheme.of(context).spacingL,
              ),
              CosmosElevatedButton(
                text: strings.createAccountAction,
                onTap: presenter.onTapCreateAccount,
              ),
              SizedBox(
                height: CosmosTheme.of(context).spacingM,
              ),
              CosmosOutlineButton(
                text: strings.importAccountAction,
                onTap: presenter.onTapImportAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<OnboardingPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<OnboardingViewModel>('model', model));
  }
}
