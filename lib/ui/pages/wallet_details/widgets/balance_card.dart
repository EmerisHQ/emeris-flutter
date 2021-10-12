import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class BalanceCard extends StatelessWidget {
  final Balance data;
  final VoidCallback? onTransferPressed;

  const BalanceCard({
    required this.data,
    required this.onTransferPressed,
  });

  /// TODO: Add missing parameters to [Balance] model (currently hardcoded as strings)
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.denom.text.toUpperCase()),
      subtitle: Text(
        '\$${data.amount.value.toStringAsFixed(2)}',
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '#\$1.23M',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            '#12,300 ATOM',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
