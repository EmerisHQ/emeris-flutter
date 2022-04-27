import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated_assets/assets.gen.dart';
import 'package:flutter_app/generated_assets/fonts.gen.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:pinput/pin_put/pin_put.dart';

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
  late TextEditingController _pinPutController;
  static const filledOpacity = 0.44;
  static const unfilledOpacity = 0.11;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    _pinPutController = TextEditingController();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: CosmosTheme.of(context).colors.text.withOpacity(unfilledOpacity),
    );
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
                Theme(
                  data: Theme.of(context).copyWith(inputDecorationTheme: const InputDecorationTheme()),
                  child: PinPut(
                    controller: _pinPutController,
                    fieldsCount: 6,
                    fieldsAlignment: MainAxisAlignment.center,
                    eachFieldMargin: const EdgeInsets.symmetric(horizontal: 12),
                    eachFieldConstraints: const BoxConstraints(
                      maxHeight: 10,
                      maxWidth: 10,
                    ),
                    textStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
                    eachFieldHeight: 10,
                    useNativeKeyboard: false,
                    enableInteractiveSelection: false,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      color: CosmosTheme.of(context).colors.text.withOpacity(filledOpacity),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration,
                  ),
                ),
                SizedBox(height: theme.spacingXXXL),
                SizedBox(height: theme.spacingL),
                Text(
                  strings.onboardingWelcomeTitle,
                  style: CosmosTextTheme.copy0Normal,
                ),
                Text(
                  strings.onboardingTaglineTitle,
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
