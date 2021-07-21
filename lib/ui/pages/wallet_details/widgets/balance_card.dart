import 'dart:math';

import 'package:flutter/material.dart';
import 'package:emeris_app/domain/entities/balance.dart';
import 'package:emeris_app/utils/app_theme.dart';
import 'package:emeris_app/utils/strings.dart';

class BalanceCard extends StatelessWidget {
  final Balance data;
  final VoidCallback? onTransferPressed;

  const BalanceCard({
    required this.data,
    required this.onTransferPressed,
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
      elevation: AppTheme.elevationS,
      child: ListTile(
        title: Text(data.denom.text),
        subtitle: Text(data.amount.displayText),
        // TODO: Fix this during refactor
        leading: icons[Random().nextInt(2)],
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          onPressed: onTransferPressed,
          child: Text(strings.transfer),
        ),
      ),
    );
  }
}
