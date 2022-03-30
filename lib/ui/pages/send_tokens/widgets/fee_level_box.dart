import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';
import 'package:flutter_app/domain/entities/gas_price_level_type.dart';
import 'package:flutter_app/domain/entities/prices.dart';

class GasPriceLevelBox extends StatelessWidget {
  const GasPriceLevelBox({
    required this.selected,
    required this.prices,
    required this.level,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final bool selected;
  final Prices prices;
  final GasPriceLevel level;
  final VoidCallback? onTap;

  Color _backgroundColor(CosmosThemeData theme) => selected ? theme.colors.text : theme.colors.cardBackground;

  Color _textColor(CosmosThemeData theme) => selected ? theme.colors.background : theme.colors.text;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    final radius = theme.borderRadiusL;
    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          color: _backgroundColor(theme),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacingL, vertical: theme.spacingM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                level.type.displayName,
                style: CosmosTextTheme.title0Medium.copyWith(color: _textColor(theme)),
              ),
              Text(
                prices.totalPriceText(level.balance),
                style: CosmosTextTheme.copy0Normal.copyWith(color: _textColor(theme)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<GasPriceLevel>('level', level))
      ..add(DiagnosticsProperty<Prices>('prices', prices))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}
