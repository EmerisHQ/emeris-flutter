import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presenter.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/amount_send_tokens_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/recipient_send_tokens_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/review_send_tokens_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/send_tokens_wizard_form.dart';
import 'package:flutter_app/utils/mobx_aware_text_controller.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SendTokensPage extends StatefulWidget {
  const SendTokensPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final SendTokensPresenter presenter;

  @override
  State<SendTokensPage> createState() => _SendTokensPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<SendTokensPresenter?>('presenter', presenter));
  }
}

class _SendTokensPageState extends State<SendTokensPage> {
  SendTokensPresenter get presenter => widget.presenter;

  SendTokensViewModel get model => presenter.viewModel;

  // ignore: diagnostic_describe_all_properties
  late MobxAwareTextController recipientController;

  // ignore: diagnostic_describe_all_properties
  late MobxAwareTextController memoController;

  // ignore: diagnostic_describe_all_properties
  late MobxAwareTextController amountTextController;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    recipientController = MobxAwareTextController(listenTo: () => model.recipientAddress.value);
    memoController = MobxAwareTextController(listenTo: () => model.memo);
    amountTextController = MobxAwareTextController(listenTo: () => model.amountText);
  }

  @override
  void dispose() {
    memoController.dispose();
    recipientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: presenter.onWillPop,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Observer(
          builder: (context) => ContentStateSwitcher(
            isLoading: model.isLoading,
            loadingChild: Scaffold(
              body: ContentLoadingIndicator(
                message: strings.sendingMoney,
              ),
            ),
            contentChild: Scaffold(
              appBar: CosmosAppBar(
                leading: CosmosBackButton(
                  text: '',
                  onTap: presenter.onTapBack,
                ),
                title: model.title,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: CosmosTheme.of(context).spacingL),
                child: Observer(
                  builder: (context) => SendTokensWizardForm(
                    step: model.step,
                    steps: [
                      Observer(
                        builder: (context) => RecipientSendTokensStep(
                          recipientTextController: recipientController,
                          memoTextController: memoController,
                          onChangedRecipientAddress: presenter.onChangedRecipientAddress,
                          recipientConfirmed: model.recipientConfirmed,
                          onTapConfirmRecipientCheckbox: presenter.onTapConfirmRecipientCheckbox,
                          onTapPaste: presenter.onTapPaste,
                          onTapScanCode: presenter.onTapScanRecipientAddress,
                          onChangedMemo: presenter.onChangeMemo,
                          onTapContinue: model.continueButtonEnabled ? presenter.onTapContinue : null,
                        ),
                      ),
                      Observer(
                        builder: (context) => AmountSendTokensStep(
                          amountTextController: amountTextController,
                          primaryAmountSymbol: model.primaryAmountSymbol,
                          onTapCurrencySwitch: presenter.onTapCurrencySwitch,
                          onTapGasPriceLevel: presenter.onTapGasPriceLevel,
                          secondaryPriceText: model.secondaryPriceText,
                          priceType: model.priceType,
                          switchPriceTypeText: model.switchPriceTypeText,
                          chain: model.chain,
                          onChangedAmount: presenter.onChangedAmount,
                          onTapMax: presenter.onTapMaxAmount,
                          onTapContinue: model.continueButtonEnabled ? presenter.onTapContinue : null,
                          onTapBalanceSelector: presenter.onTapBalanceSelector,
                          prices: model.prices,
                          chainAsset: model.selectedAsset,
                          feeVerifiedDenom: model.feeVerifiedDenom,
                          appliedFee: model.appliedFee,
                        ),
                      ),
                      ReviewSendTokensStep(
                        formData: model.formData,
                        onTapConfirm: model.continueButtonEnabled ? presenter.onTapContinue : null,
                      ),
                    ],
                  ),
                ),
              ),
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
      ..add(DiagnosticsProperty<SendTokensPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<SendTokensViewModel>('model', model));
  }
}
