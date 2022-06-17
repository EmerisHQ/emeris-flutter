import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/ui/widgets/denom_icon.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceSelectorButton extends StatelessWidget {
  const BalanceSelectorButton({
    required this.chainAsset,
    required this.chain,
    required this.onTap,
    required this.prices,
    Key? key,
  }) : super(key: key);

  final ChainAsset chainAsset;
  final Chain chain;
  final VoidCallback onTap;

  // ignore: diagnostic_describe_all_properties
  final Prices prices;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: theme.elevationM,
      shadowColor: theme.colors.shadowColor,
      borderRadius: theme.borderRadiusL,
      color: theme.colors.background,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: theme.spacingL,
            horizontal: theme.spacingM,
          ),
          child: Row(
            children: [
              DenomIcon(url: chainAsset.verifiedDenom.logo),
              SizedBox(width: theme.spacingS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chainAsset.denom.displayName,
                          style: CosmosTextTheme.title0Bold,
                        ),
                        Text(
                          prices.totalPriceText(chainAsset.balance),
                          style: CosmosTextTheme.title0Medium,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(chain.displayName),
                        Text(strings.tokenAvailableFormat(chainAsset.balance.amountWithDenomText)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: theme.spacingS),
              Icon(Icons.chevron_right, color: theme.colors.text),
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
      ..add(DiagnosticsProperty<Chain>('chain', chain))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DiagnosticsProperty<ChainAsset>('asset', chainAsset));
  }
}
