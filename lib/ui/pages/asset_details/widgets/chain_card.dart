import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/asset_chain.dart';
import 'package:flutter_app/utils/emeris_amount_formatter.dart';

class ChainCard extends StatelessWidget {
  const ChainCard({required this.assetChain, Key? key}) : super(key: key);

  final ChainAsset assetChain;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return ListTile(
      title: Text(assetChain.chainDetails.displayName),
      leading: CircleAvatar(
        backgroundColor: theme.colors.background,
        foregroundColor: theme.colors.text,
        child: Text(assetChain.chainDetails.displayName[0]),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatEmerisAmount(assetChain.balance.dollarPrice),
            style: TextStyle(color: theme.colors.text),
          ),
          Text(
            '${formatEmerisAmount(assetChain.balance.amount, symbol: '')} ${assetChain.balance.denom.text}',
            style: TextStyle(color: theme.colors.text),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ChainAsset>('assetChain', assetChain));
  }
}
