import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/utils/emeris_amount_formatter.dart';

class BalanceCard extends StatelessWidget {
  final Balance data;
  final VoidCallback? onTap;

  const BalanceCard({
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(data.denom.text.toUpperCase()),
      subtitle: Text(
        '\$${data.unitPrice.value.toStringAsFixed(2)}',
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatEmerisAmount(data.dollarPrice),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            '${formatEmerisAmount(data.amount, symbol: '')} ${data.denom.text}',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
