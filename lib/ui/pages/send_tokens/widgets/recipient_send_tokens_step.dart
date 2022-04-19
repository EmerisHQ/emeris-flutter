import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class RecipientSendTokensStep extends StatefulWidget {
  const RecipientSendTokensStep({
    required this.onChangedRecipientAddress,
    required this.recipientConfirmed,
    required this.onTapConfirmRecipientCheckbox,
    required this.onTapPaste,
    required this.onTapScanCode,
    required this.recipientTextController,
    required this.memoTextController,
    required this.onChangedMemo,
    required this.onTapContinue,
    Key? key,
  }) : super(key: key);

  final ValueChanged<String> onChangedRecipientAddress;
  final ValueChanged<String> onChangedMemo;
  final VoidCallback onTapConfirmRecipientCheckbox;
  final VoidCallback onTapPaste;
  final VoidCallback onTapScanCode;
  final bool recipientConfirmed;
  final TextEditingController recipientTextController;
  final TextEditingController memoTextController;
  final VoidCallback? onTapContinue;

  @override
  State<RecipientSendTokensStep> createState() => _RecipientSendTokensStepState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<String>>.has('onChangedRecipientAddress', onChangedRecipientAddress))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapConfirmRecipientCheckbox', onTapConfirmRecipientCheckbox))
      ..add(DiagnosticsProperty<bool>('recipientConfirmed', recipientConfirmed))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapPaste', onTapPaste))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapQrCode', onTapScanCode))
      ..add(DiagnosticsProperty<TextEditingController>('recipientTextController', recipientTextController))
      ..add(ObjectFlagProperty<ValueChanged<String>>.has('onChangedMemo', onChangedMemo))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTapContinue', onTapContinue))
      ..add(DiagnosticsProperty<TextEditingController>('memoTextController', memoTextController));
  }
}

class _RecipientSendTokensStepState extends State<RecipientSendTokensStep> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = CosmosTheme.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(strings.recipientToLabel),
                        IconButton(
                          icon: const Icon(Icons.qr_code),
                          onPressed: widget.onTapScanCode,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CosmosTextField(
                            controller: widget.recipientTextController,
                            initialText: widget.recipientTextController.text,
                            onChanged: widget.onChangedRecipientAddress,
                            hint: strings.recipientToHint,
                          ),
                        ),
                        SizedBox(
                          width: theme.spacingM,
                        ),
                        CosmosElevatedButton(
                          text: strings.pasteAction,
                          onTap: widget.onTapPaste,
                          height: 40,
                          elevation: theme.elevationL,
                          textColor: theme.colors.text,
                          backgroundColor: theme.colors.background,
                        )
                      ],
                    ),
                    SizedBox(height: theme.spacingXXXL),
                    Text(strings.referenceLabel),
                    CosmosTextField(
                      onChanged: widget.onChangedMemo,
                      controller: widget.memoTextController,
                      hint: strings.referenceHint,
                    ),
                    SizedBox(height: theme.spacingXL),
                    CosmosCheckboxTile(
                      text: strings.confirmRecipientCheckbox,
                      onTap: widget.onTapConfirmRecipientCheckbox,
                      checked: widget.recipientConfirmed,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: theme.spacingL),
            CosmosElevatedButton(
              text: strings.continueAction,
              onTap: widget.onTapContinue,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
