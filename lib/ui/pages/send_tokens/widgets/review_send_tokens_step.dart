import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/send_tokens_form_data.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/review_amount_with_denom.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/review_table_row.dart';
import 'package:flutter_app/utils/strings.dart';

class ReviewSendTokensStep extends StatelessWidget {
  const ReviewSendTokensStep({
    required this.formData,
    required this.onTapConfirm,
    Key? key,
  }) : super(key: key);

  final SendTokensFormData formData;
  final VoidCallback? onTapConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: theme.borderRadiusM,
                  border: Border.all(color: theme.colors.inputBorder),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: theme.spacingM),
                    ReviewTableRow(
                      title: strings.sendAmountTitle,
                      valueChild: ReviewAmountWithDenom(
                        verifiedDenom: formData.verifiedDenom,
                        amount: formData.sendAmount,
                        chain: formData.senderChain,
                      ),
                    ),
                    const CosmosDivider(),
                    ReviewTableRow(
                      title: strings.sendAddressTitle,
                      valueChild: Text(formData.sender.abbreviatedAddress),
                      expandedChild: Text(formData.sender.value),
                    ),
                    const CosmosDivider(),
                    ReviewTableRow(
                      title: strings.feeTitle,
                      valueChild: Text(formData.feeWithDenomText),
                    ),
                    const CosmosDivider(),
                    ReviewTableRow(
                      title: strings.receiveAmountTitle,
                      valueChild: ReviewAmountWithDenom(
                        verifiedDenom: formData.verifiedDenom,
                        amount: formData.receiveAmount,
                        chain: formData.recipientChain,
                      ),
                    ),
                    const CosmosDivider(),
                    ReviewTableRow(
                      title: strings.receiveAddressTitle,
                      valueChild: Text(formData.recipient.abbreviatedAddress),
                      expandedChild: Text(formData.recipient.value),
                    ),
                    SizedBox(height: theme.spacingM),
                  ],
                ),
              ),
            ),
          ),
          CosmosElevatedButton(
            text: strings.confirmAndContinueAction,
            onTap: onTapConfirm,
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<SendTokensFormData>('formData', formData))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTapConfirm', onTapConfirm));
  }
}
