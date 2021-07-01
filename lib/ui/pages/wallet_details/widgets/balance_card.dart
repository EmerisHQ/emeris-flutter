import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/wallet_balances.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceCard extends StatelessWidget {
  final WalletBalancesData data;
  final VoidCallback onTransferPressed;
  final bool isSendMoneyLoading;

  const BalanceCard({
    required this.data,
    required this.onTransferPressed,
    required this.isSendMoneyLoading,
  });

  // TODO: Remove these icons during refactor
  // ignore: avoid_field_initializers_in_const_classes
  final List<Widget> icons = const [
    Icon(Icons.wifi_tethering),
    Icon(Icons.workspaces_filled),
    Icon(Icons.workspaces_filled),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(data.denom),
        subtitle: Text(data.amount),
        // TODO: Fix this during refactor
        leading: icons[Random().nextInt(2)],
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          onPressed: isSendMoneyLoading
              ? null
              : () {
                  onTransferPressed();
                },
          child: Text(strings.transfer),
        ),
      ),
    );
  }
}
