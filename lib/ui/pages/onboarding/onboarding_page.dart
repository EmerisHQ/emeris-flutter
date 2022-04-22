import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated_assets/assets.gen.dart';
import 'package:flutter_app/generated_assets/fonts.gen.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesOnboardingBackground.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacingL,
              vertical: theme.spacingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(Assets.imagesEmerisWordmark.path),
                ),
                SizedBox(height: theme.spacingXXXL),
                SizedBox(height: theme.spacingL),
                Text(
                  'Welcome to Emeris wallet',
                  style: CosmosTextTheme.copy0Normal,
                ),
                Text(
                  'Experience the power of cross-chain DeFi',
                  style: CosmosTextTheme.title2Bold.copyWith(
                    fontFamily: FontFamily.casta,
                  ),
                ),
                const Spacer(),
                CosmosElevatedButton(
                  text: strings.createAccountAction,
                  onTap: presenter.onTapCreateAccount,
                ),
                SizedBox(
                  height: CosmosTheme.of(context).spacingM,
                ),
                CosmosTextButton(
                  text: strings.alreadyHaveAccountAction,
                  onTap: presenter.onTapImportAccount,
                ),
              ],
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
      ..add(DiagnosticsProperty<OnboardingPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<OnboardingViewModel>('model', model));
  }
}
