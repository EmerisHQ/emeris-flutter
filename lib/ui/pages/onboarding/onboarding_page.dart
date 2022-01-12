import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
import 'package:flutter_app/ui/pages/onboarding/widgets/welcome_splash.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/strings.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingInitialParams initialParams;
  final OnboardingPresenter? presenter;

  const OnboardingPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late OnboardingPresenter presenter;

  OnboardingViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: OnboardingPresentationModel(widget.initialParams),
          param2: getIt<OnboardingNavigator>(),
        );
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
              CosmosElevatedButton(
                text: strings.createWalletAction,
                onTap: presenter.onTapCreateWallet,
              ),
              CosmosOutlineButton(
                text: strings.importWalletAction,
                onTap: presenter.onTapImportWallet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
