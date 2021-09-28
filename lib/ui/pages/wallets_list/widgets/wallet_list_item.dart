import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/wallet_type.dart';

class WalletListItem extends StatelessWidget {
  final String alias;
  final String address;
  final WalletType walletType;
  final VoidCallback onClicked;

  const WalletListItem({
    Key? key,
    required this.alias,
    required this.address,
    required this.walletType,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Row(
          children: [
            Text(alias),
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: walletType == WalletType.Eth ? Colors.deepPurple : Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                walletType.toString().split('.')[1],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            )
          ],
        ),
        subtitle: Text(address),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => FlutterClipboard.copy(address),
              child: const Icon(Icons.copy),
            ),
          ],
        ),
        onTap: () => onClicked(),
      ),
    );
  }
}
