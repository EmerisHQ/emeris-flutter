import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class RecipientSendTokensStep extends StatelessWidget {
  const RecipientSendTokensStep({
    required this.onChangedRecipientAddress,
    required this.recipientConfirmed,
    required this.onTapConfirmRecipientCheckbox,
    required this.onTapPaste,
    required this.onTapScanCode,
    required this.recipientTextController,
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
  final VoidCallback? onTapContinue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(strings.recipientToLabel),
              IconButton(
                icon: const Icon(Icons.qr_code),
                onPressed: onTapScanCode,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CosmosTextField(
                  controller: recipientTextController,
                  onChanged: onChangedRecipientAddress,
                  hint: strings.recipientToHint,
                ),
              ),
              SizedBox(
                width: CosmosTheme.of(context).spacingM,
              ),
              CosmosOutlineButton(
                text: strings.pasteAction,
                onTap: onTapPaste,
                height: 40,
              )
            ],
          ),
          SizedBox(height: CosmosTheme.of(context).spacingXXXL),
          Text(strings.referenceLabel),
          CosmosTextField(
            onChanged: onChangedMemo,
            hint: strings.referenceHint,
          ),
          const Spacer(),
          CosmosCheckboxTile(
            text: strings.confirmRecipientCheckbox,
            onTap: onTapConfirmRecipientCheckbox,
            checked: recipientConfirmed,
          ),
          SizedBox(height: CosmosTheme.of(context).spacingL),
          CosmosElevatedButton(
            text: strings.continueAction,
            onTap: onTapContinue,
          ),
        ],
      ),
    );
  }

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
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTapContinue', onTapContinue));
  }
}
