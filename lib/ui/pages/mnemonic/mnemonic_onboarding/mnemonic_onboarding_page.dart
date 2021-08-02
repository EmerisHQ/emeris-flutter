import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MnemonicOnboardingPage extends StatefulWidget {
  final MnemonicOnboardingInitialParams initialParams;
  final MnemonicOnboardingPresenter? presenter;

  const MnemonicOnboardingPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _MnemonicOnboardingPageState createState() => _MnemonicOnboardingPageState();
}

class _MnemonicOnboardingPageState extends State<MnemonicOnboardingPage> {
  late MnemonicOnboardingPresenter presenter;

  MnemonicOnboardingViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: MnemonicOnboardingPresentationModel(widget.initialParams),
          param2: getIt<MnemonicOnboardingNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        title: strings.enterMnemonic,
      ),
      body: SafeArea(
        child: Observer(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: CosmosAppTheme.spacingM),
            child: ContentStateSwitcher(
              isEmpty: model.mnemonic.isEmpty,
              emptyChild: Center(
                child: CosmosElevatedButton(
                  onTap: presenter.generateMnemonicClicked,
                  text: strings.createNewWallet,
                ),
              ),
              contentChild: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CosmosMnemonicWordsGrid(mnemonicWords: model.mnemonicWords),
                    const SizedBox(height: CosmosAppTheme.spacingM),
                    Text(
                      strings.mnemonicHelperText,
                      textAlign: TextAlign.center,
                    ),
                    CosmosElevatedButton(
                      onTap: presenter.onProceedClicked,
                      text: strings.proceed,
                      suffixIcon: const Icon(Icons.arrow_forward),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
