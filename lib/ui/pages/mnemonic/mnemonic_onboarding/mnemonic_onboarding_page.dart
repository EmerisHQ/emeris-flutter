import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_presenter.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/widgets/mnemonic_choice_chip.dart';
import 'package:flutter_app/ui/widgets/content_state_switcher.dart';
import 'package:flutter_app/utils/app_theme.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/utils/utils.dart';
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
      body: SafeArea(
        child: Observer(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
            child: ContentStateSwitcher(
              isEmpty: model.mnemonic.isEmpty,
              emptyChild: Center(
                child: ElevatedButton(
                  onPressed: presenter.generateMnemonicClicked,
                  child: Text(strings.createNewWallet),
                ),
              ),
              contentChild: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GridView.count(
                      crossAxisCount: (MediaQuery.of(context).size.width * 0.005).ceil(),
                      shrinkWrap: true,
                      childAspectRatio: 5,
                      children: model.mnemonicWords //
                          .mapIndexed((index, word) => MnemonicChoiceChip(index: index, word: word))
                          .toList(),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    Text(
                      strings.mnemonicHelperText,
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: presenter.onProceedClicked,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(strings.proceed),
                          const SizedBox(width: AppTheme.spacingS),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
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
