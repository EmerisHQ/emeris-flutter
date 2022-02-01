import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/ui/pages/wallets_list/widgets/wallet_list_item.dart';

class WalletsListView extends StatelessWidget {
  const WalletsListView({
    required this.list,
    required this.walletClicked,
    Key? key,
  }) : super(key: key);

  final List<EmerisWallet> list;
  final void Function(EmerisWallet) walletClicked;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list
          .map(
            (wallet) => WalletListItem(
              alias: wallet.walletDetails.walletAlias,
              address: wallet.walletDetails.walletAddress,
              walletType: wallet.walletType,
              onClicked: () => walletClicked(wallet),
            ),
          )
          .toList(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<EmerisWallet>('list', list))
      ..add(ObjectFlagProperty<void Function(EmerisWallet p1)>.has('walletClicked', walletClicked));
  }
}
