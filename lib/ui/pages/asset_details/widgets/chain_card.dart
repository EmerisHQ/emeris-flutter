import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';

class ChainCard extends StatelessWidget {
  const ChainCard({
    required this.chainAsset,
    required this.totalPriceText,
    Key? key,
  }) : super(key: key);

  final ChainAsset chainAsset;
  final String totalPriceText;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(chainAsset.chain.displayName),
      leading: CircleAvatar(
        backgroundColor: theme.colors.inactive,
        foregroundColor: theme.colors.text,
        child: Text(chainAsset.chain.displayName[0]),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            totalPriceText,
            style: TextStyle(color: theme.colors.text),
          ),
          Text(
            chainAsset.balance.amountWithDenomText,
            style: TextStyle(color: theme.colors.text),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ChainAsset>('chainAsset', chainAsset))
      ..add(StringProperty('totalPriceText', totalPriceText));
  }
}
