import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/asset_chain.dart';
import 'package:flutter_app/utils/emeris_amount_formatter.dart';

class ChainCard extends StatelessWidget {
  const ChainCard({required this.assetChain, Key? key}) : super(key: key);

  final AssetChain assetChain;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(assetChain.chainDetails.displayName),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        child: Text(assetChain.chainDetails.displayName[0]),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatEmerisAmount(assetChain.balance.dollarPrice),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            '${formatEmerisAmount(assetChain.balance.amount, symbol: '')} ${assetChain.balance.denom.text}',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AssetChain>('assetChain', assetChain));
  }
}
