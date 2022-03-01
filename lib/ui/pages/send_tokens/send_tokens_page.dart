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

  late MobxAwareTextController recipientController;
  late MobxAwareTextController memoController;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    recipientController = MobxAwareTextController(listenTo: () => model.recipientAddress);
    memoController = MobxAwareTextController(listenTo: () => model.memo);
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
      child: Observer(
        builder: (context) => Scaffold(
          appBar: CosmosAppBar(
            leading: CosmosBackButton(
              text: '',
              onTap: presenter.onTapBack,
            ),
            title: model.title,
          ),
          body: Padding(
            padding: EdgeInsets.all(CosmosTheme.of(context).spacingL),
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
                  const AmountSendTokensStep(),
                  const ReviewSendTokensStep(),
                ],
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
      ..add(DiagnosticsProperty<SendTokensViewModel>('model', model))
      ..add(DiagnosticsProperty<MobxAwareTextController>('recipientController', recipientController))
      ..add(DiagnosticsProperty<MobxAwareTextController>('memoController', memoController));
  }
}
