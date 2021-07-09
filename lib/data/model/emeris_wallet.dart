import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';

class WalletDetails extends Equatable {
  final String walletAlias;
  final String walletAddress;

  const WalletDetails({
    required this.walletAlias,
    required this.walletAddress,
  });

  @override
  List<Object?> get props => [
        walletAlias,
        walletAddress,
      ];
}

class EmerisWallet extends Equatable {
  final WalletDetails walletDetails;
  final WalletType walletType;

  const EmerisWallet({
    required this.walletDetails,
    required this.walletType,
  });

  @override
  List<Object?> get props => [
        walletDetails,
        walletType,
      ];
}
