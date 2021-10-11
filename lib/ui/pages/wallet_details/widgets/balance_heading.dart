import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceHeading extends StatelessWidget {
  final EmerisWallet wallet;

  const BalanceHeading({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(strings.assets, textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline6),
          Text(strings.balance),
        ],
      ),
    );
  }
}
