import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceHeading extends StatelessWidget {
  const BalanceHeading({
    required this.wallet,
    Key? key,
  }) : super(key: key);
  final EmerisWallet wallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(strings.assetTitle, textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline6),
          Text(strings.balanceTitle),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EmerisWallet>('wallet', wallet));
  }
}
