import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';

class EmerisWallet extends Equatable {
  const EmerisWallet({
    required this.walletDetails,
    required this.walletType,
  });

  const EmerisWallet.empty()
      : walletDetails = const WalletDetails.empty(),
        walletType = WalletType.Cosmos;

  final WalletDetails walletDetails;
  final WalletType walletType;

  @override
  List<Object?> get props => [
        walletDetails,
        walletType,
      ];
}

extension EmerisWalletInfo on EmerisWallet {
  WalletInfo get walletInfo => WalletInfo(
        name: walletDetails.walletAlias,
        address: walletDetails.walletAddress,
        walletId: walletDetails.walletIdentifier.walletId,
      );
}
