import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/ui/pages/account_details/widgets/balance_card.dart';

class BalancesList extends StatelessWidget {
  const BalancesList({
    required this.assets,
    required this.prices,
    required this.onTapBalance,
    Key? key,
  }) : super(key: key);

  final List<Asset> assets;
  final Prices prices;

  final ValueChanged<Asset>? onTapBalance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: assets
          .map(
            (asset) => BalanceCard(
              balance: asset.totalBalance,
              prices: prices,
              onTap: () => onTapBalance?.call(asset),
            ),
          )
          .toList(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<Asset>('assets', assets))
      ..add(
        ObjectFlagProperty<ValueChanged<Asset>?>.has(
          'onTapBalance',
          onTapBalance,
        ),
      )
      ..add(DiagnosticsProperty<Prices>('prices', prices));
  }
}
