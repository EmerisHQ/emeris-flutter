import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/ui/pages/wallets_list/widgets/wallet_list_item.dart';

class WalletsListView extends StatelessWidget {
  final List<EmerisWallet> list;
  final void Function(EmerisWallet) walletClicked;

  const WalletsListView({
    Key? key,
    required this.list,
    required this.walletClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list
          .map(
            (wallet) => WalletListItem(
              alias: wallet.walletDetails.walletAlias.toString(),
              address: wallet.walletDetails.walletAddress,
              walletType: wallet.walletType,
              onClicked: () => walletClicked(wallet),
            ),
          )
          .toList(),
    );
  }
}
