import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/asset_chain.dart';
import 'package:flutter_app/utils/emeris_amount_formatter.dart';

class ChainCard extends StatelessWidget {
  const ChainCard({required this.chainAsset, Key? key}) : super(key: key);

  final ChainAsset chainAsset;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(chainAsset.chainDetails.displayName),
      leading: CircleAvatar(
        backgroundColor: theme.colors.background,
        foregroundColor: theme.colors.text,
        child: Text(chainAsset.chainDetails.displayName[0]),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatEmerisAmount(chainAsset.balance.dollarPrice),
            style: TextStyle(color: theme.colors.text),
          ),
          Text(
            '${formatEmerisAmount(chainAsset.balance.amount, symbol: '')} ${chainAsset.balance.denom.text}',
            style: TextStyle(color: theme.colors.text),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ChainAsset>('chainAsset', chainAsset));
  }
}
