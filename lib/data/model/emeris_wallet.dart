import 'package:cosmos_ui_components/models/account_info.dart';
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
  AccountInfo get walletInfo => AccountInfo(
        name: walletDetails.walletAlias,
        address: walletDetails.walletAddress,
        accountId: walletDetails.walletIdentifier.walletId,
      );
}
