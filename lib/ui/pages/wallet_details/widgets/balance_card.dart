import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class BalanceCard extends StatelessWidget {
  final Balance data;

  const BalanceCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
            '\$${data.dollarPrice.displayText}',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            '${data.amount.displayText} ${data.denom.text}',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
