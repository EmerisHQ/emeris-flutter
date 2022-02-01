import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';

class WalletDetails extends Equatable {
  const WalletDetails({
    required this.walletIdentifier,
    required this.walletAlias,
    required this.walletAddress,
  });

  final WalletIdentifier walletIdentifier;
  final String walletAlias;
  final String walletAddress;

  @override
  List<Object?> get props => [
        walletAlias,
        walletAddress,
      ];
}

class EmerisWallet extends Equatable {
  const EmerisWallet({
    required this.walletDetails,
    required this.walletType,
  });

  final WalletDetails walletDetails;
  final WalletType walletType;

  @override
  List<Object?> get props => [
        walletDetails,
        walletType,
      ];
}
