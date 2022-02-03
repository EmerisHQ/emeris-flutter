import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';

class WalletDetails extends Equatable {
  const WalletDetails({
    required this.walletIdentifier,
    required this.walletAlias,
    required this.walletAddress,
  });

  const WalletDetails.empty()
      : walletIdentifier = const WalletIdentifier.empty(),
        walletAddress = '',
        walletAlias = '';

  final WalletIdentifier walletIdentifier;
  final String walletAlias;
  final String walletAddress;

  @override
  List<Object?> get props => [
        walletIdentifier,
        walletAlias,
        walletAddress,
      ];
}
