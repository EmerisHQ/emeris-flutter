import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/balance_selector_button.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/fee_selection_section.dart';
import 'package:flutter_app/utils/price_converter.dart';
import 'package:flutter_app/utils/strings.dart';

class AmountSendTokensStep extends StatefulWidget {
  const AmountSendTokensStep({
    required this.onChangedAmount,
    required this.onTapMax,
    required this.onTapCurrencySwitch,
    required this.onTapBalanceSelector,
    required this.onTapGasPriceLevel,
    required this.amountTextController,
    required this.secondaryPriceText,
    required this.priceType,
    required this.switchPriceTypeText,
    required this.primaryAmountSymbol,
    required this.onTapContinue,
    required this.chainAsset,
    required this.chain,
    required this.prices,
    required this.appliedFee,
    required this.feeVerifiedDenom,
    Key? key,
  }) : super(key: key);

  final Function(String) onChangedAmount;
  final String switchPriceTypeText;
  final String secondaryPriceText;
  final VoidCallback onTapMax;
  final VoidCallback onTapCurrencySwitch;
  final VoidCallback onTapBalanceSelector;
  final VoidCallback? onTapContinue;
  final void Function(GasPriceLevel level)? onTapGasPriceLevel;
  final TextEditingController amountTextController;
  final PriceType priceType;
  final String primaryAmountSymbol;
  final Prices prices;
  final Chain chain;
  final ChainAsset chainAsset;
  final GasPriceLevel appliedFee;
  final VerifiedDenom feeVerifiedDenom;

  @override
  State<AmountSendTokensStep> createState() => _AmountSendTokensStepState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<Function(String param)>.has('onChanged', onChangedAmount))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapMax', onTapMax))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapCurrencySwitch', onTapCurrencySwitch))
      ..add(StringProperty('fiatButtonText', switchPriceTypeText))
      ..add(DiagnosticsProperty<TextEditingController>('amountTextController', amountTextController))
      ..add(StringProperty('dollarPriceText', secondaryPriceText))
      ..add(EnumProperty<PriceType>('priceType', priceType))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTapContinue', onTapContinue))
      ..add(StringProperty('primaryAmountSymbol', primaryAmountSymbol))
      ..add(DiagnosticsProperty<Chain>('chain', chain))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapBalanceSelector', onTapBalanceSelector))
      ..add(DiagnosticsProperty<ChainAsset>('chainAsset', chainAsset))
      ..add(DiagnosticsProperty<Prices>('prices', prices))
      ..add(DiagnosticsProperty<GasPriceLevel>('appliedFee', appliedFee))
      ..add(DiagnosticsProperty<VerifiedDenom>('feeVerifiedDenom', feeVerifiedDenom))
      ..add(
        ObjectFlagProperty<void Function(GasPriceLevel level)?>.has('onTapGasPriceLevel', onTapGasPriceLevel),
      );
  }
}

class _AmountSendTokensStepState extends State<AmountSendTokensStep> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = CosmosTheme.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: theme.spacingM),
                        Expanded(
                          child: CosmosTextField(
                            onChanged: widget.onChangedAmount,
                            textAlign: TextAlign.center,
                            style: CosmosTextTheme.title0Bold,
                            controller: widget.amountTextController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        SizedBox(width: theme.spacingM),
                        Text(
                          widget.primaryAmountSymbol,
                          style: CosmosTextTheme.title0Bold,
                        ),
                      ],
                    ),
                    SizedBox(height: theme.spacingM),
                    Text(
                      widget.secondaryPriceText,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: theme.spacingXXL),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CosmosElevatedButton(
                          elevation: theme.elevationS,
                          contentPadding: 0,
                          backgroundColor: theme.colors.background,
                          onTap: widget.onTapCurrencySwitch,
                          textColor: theme.colors.text,
                          suffixIcon: const Icon(Icons.swap_vert),
                        ),
                        CosmosElevatedButton(
                          text: strings.maxAction,
                          elevation: theme.elevationS,
                          backgroundColor: theme.colors.background,
                          textColor: theme.colors.text,
                          onTap: widget.onTapMax,
                        ),
                      ],
                    ),
                    SizedBox(height: theme.spacingXXL),
                    BalanceSelectorButton(
                      chainAsset: widget.chainAsset,
                      chain: widget.chain,
                      onTap: widget.onTapBalanceSelector,
                      prices: widget.prices,
                    ),
                    SizedBox(height: theme.spacingM),
                    FeeSelectionSection(
                      appliedFee: widget.appliedFee,
                      prices: widget.prices,
                      feeVerifiedDenom: widget.feeVerifiedDenom,
                      onTapGasPriceLevel: widget.onTapGasPriceLevel,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
            child: CosmosElevatedButton(
              text: strings.continueAction,
              onTap: widget.onTapContinue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
