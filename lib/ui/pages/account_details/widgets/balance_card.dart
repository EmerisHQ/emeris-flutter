import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/prices.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    required this.balance,
    required this.prices,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Balance balance;
  final Prices prices;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(balance.denom.text.toUpperCase()),
      subtitle: Text(
        balance.unitPriceText(prices),
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            balance.totalPriceText(prices),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            balance.amountWithDenomText,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Balance>('data', balance))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<Prices>('prices', prices));
  }
}
