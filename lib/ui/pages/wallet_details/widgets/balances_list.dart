import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_card.dart';

class BalancesList extends StatelessWidget {
  const BalancesList({
    required this.balances,
    required this.onTapBalance,
    Key? key,
  }) : super(key: key);

  final List<Balance> balances;

  final ValueChanged<Balance>? onTapBalance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: balances
            .map(
              (balance) => BalanceCard(
                data: balance,
                onTap: () => onTapBalance?.call(balance),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<Balance>('balances', balances))
      ..add(
        ObjectFlagProperty<ValueChanged<Balance>?>.has(
          'onTapBalance',
          onTapBalance,
        ),
      );
  }
}
