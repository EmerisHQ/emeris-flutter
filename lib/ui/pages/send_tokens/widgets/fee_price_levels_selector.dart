import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/ui/pages/send_tokens/widgets/fee_level_box.dart';

class FeePriceLevelsSelector extends StatelessWidget {
  const FeePriceLevelsSelector({
    required this.prices,
    required this.selectedLevel,
    required this.gasPriceLevels,
    required this.onTapGasPriceLevel,
    Key? key,
  }) : super(key: key);

  final Prices prices;
  final List<GasPriceLevel> gasPriceLevels;
  final GasPriceLevel selectedLevel;
  final void Function(GasPriceLevel level)? onTapGasPriceLevel;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Row(
      children: gasPriceLevels.map(
        (it) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spacingS),
              child: GasPriceLevelBox(
                prices: prices,
                level: it,
                selected: it.type == selectedLevel.type,
                onTap: onTapGasPriceLevel == null ? null : () => onTapGasPriceLevel!(it),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Prices>('prices', prices))
      ..add(IterableProperty<GasPriceLevel>('gasPriceLevels', gasPriceLevels))
      ..add(DiagnosticsProperty<GasPriceLevel>('selectedLevel', selectedLevel))
      ..add(ObjectFlagProperty<void Function(GasPriceLevel level)?>.has('onTapGasPriceLevel', onTapGasPriceLevel));
  }
}
