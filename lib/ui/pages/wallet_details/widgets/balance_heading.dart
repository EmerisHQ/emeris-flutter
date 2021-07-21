import 'package:flutter/material.dart';
import 'package:emeris_app/data/model/emeris_wallet.dart';
import 'package:emeris_app/data/model/wallet_type.dart';
import 'package:emeris_app/utils/strings.dart';

class BalanceHeading extends StatelessWidget {
  final EmerisWallet wallet;

  const BalanceHeading({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Text(
            strings.balances,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
                color: wallet.walletType == WalletType.Eth ? Colors.deepPurple : Colors.blueGrey,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              wallet.walletType.toString().split('.')[1],
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
