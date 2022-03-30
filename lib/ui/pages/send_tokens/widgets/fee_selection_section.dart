import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/fee_price_levels_selector.dart';
import 'package:flutter_app/ui/widgets/expanded_indicator.dart';
import 'package:flutter_app/utils/strings.dart';

class FeeSelectionSection extends StatefulWidget {
  const FeeSelectionSection({
    required this.appliedFee,
    required this.feeVerifiedDenom,
    required this.prices,
    required this.onTapGasPriceLevel,
    Key? key,
  }) : super(key: key);

  final GasPriceLevel appliedFee;
  final VerifiedDenom feeVerifiedDenom;
  final Prices prices;
  final void Function(GasPriceLevel level)? onTapGasPriceLevel;

  @override
  State<FeeSelectionSection> createState() => _FeeSelectionSectionState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Prices>('prices', prices))
      ..add(DiagnosticsProperty<VerifiedDenom>('feeVerifiedDenom', feeVerifiedDenom))
      ..add(DiagnosticsProperty<GasPriceLevel>('appliedFee', appliedFee))
      ..add(ObjectFlagProperty<void Function(GasPriceLevel level)?>.has('onTapGasPriceLevel', onTapGasPriceLevel));
  }
}

class _FeeSelectionSectionState extends State<FeeSelectionSection> {
  bool _expanded = false;

  String get _appliedFeeValueText => widget.prices.totalPriceText(widget.appliedFee.balance);

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: theme.spacingL,
            ),
            child: Row(
              children: [
                Text(
                  strings.feesIncluded,
                  style: CosmosTextTheme.title0Medium,
                ),
                const Spacer(),
                if (!_expanded) ...[
                  Text(_appliedFeeValueText),
                  SizedBox(width: theme.spacingM),
                ],
                ExpandedIndicator(expanded: _expanded),
              ],
            ),
          ),
        ),
        ExpandableContainer(
          expanded: _expanded,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: theme.spacingM),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(strings.transactionFeeMultipliesFormat(1)),
                  Text(_appliedFeeValueText),
                ],
              ),
              SizedBox(height: theme.spacingM),
              FeePriceLevelsSelector(
                selectedLevel: widget.appliedFee,
                prices: widget.prices,
                gasPriceLevels: widget.feeVerifiedDenom.gasPriceLevels,
                onTapGasPriceLevel: widget.onTapGasPriceLevel,
              )
            ],
          ),
        ),
      ],
    );
  }
}
