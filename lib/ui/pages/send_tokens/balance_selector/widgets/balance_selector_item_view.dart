import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/ui/widgets/text_in_circle.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceSelectorItemView extends StatelessWidget {
  const BalanceSelectorItemView({
    required this.item,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final BalanceSelectorItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Material(
      clipBehavior: Clip.antiAlias,
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
              const Icon(Icons.monetization_on),
              SizedBox(width: theme.spacingS),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: CosmosTextTheme.title0Bold,
                  ),
                  SizedBox(height: theme.spacingS),
                  Text(item.availableText),
                ],
              ),
              const Spacer(),
              SizedBox(width: theme.spacingS),
              if (item.subItems.length > 1)
                TextInCircle(
                  text: item.subItems.length.toString(),
                ),
              if (item.subItems.isNotEmpty)
                Icon(
                  Icons.chevron_right,
                  color: theme.colors.text,
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
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DiagnosticsProperty<BalanceSelectorItem>('item', item));
  }
}

class BalanceSelectorItem {
  BalanceSelectorItem({
    required this.title,
    required this.icon,
    required this.availableText,
    required this.subItems,
    required this.chainAsset,
  });

  factory BalanceSelectorItem.asset(Asset asset) {
    return BalanceSelectorItem(
      title: asset.verifiedDenom.denom.displayName,
      icon: asset.verifiedDenom.logo,
      availableText: strings.tokenAvailableFormat(asset.totalBalance.amountWithDenomText),
      subItems: asset.chainAssets.map(BalanceSelectorItem.chainAsset).toList(),
      chainAsset: asset.chainAssets.length == 1 ? asset.chainAssets.first : null,
    );
  }

  factory BalanceSelectorItem.chainAsset(ChainAsset chainAsset) {
    return BalanceSelectorItem(
      title: chainAsset.chain.displayName,
      icon: chainAsset.chain.logo,
      availableText: strings.tokenAvailableFormat(chainAsset.balance.amountWithDenomText),
      subItems: [],
      chainAsset: chainAsset,
    );
  }

  final String title;
  final String icon;
  final String availableText;
  final List<BalanceSelectorItem> subItems;
  final ChainAsset? chainAsset;
}
