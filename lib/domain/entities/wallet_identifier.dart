import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/passcode.dart';

class WalletIdentifier extends Equatable {
  const WalletIdentifier({
    required this.walletId,
    required this.chainId,
    this.password,
  });

  const WalletIdentifier.empty()
      : walletId = '',
        chainId = '',
        password = '';

  final String walletId;
  final String chainId;
  final String? password;

  @override
  List<Object?> get props => [
        walletId,
        chainId,
      ];

  WalletIdentifier byUpdatingPasscode(Passcode? passcode) => WalletIdentifier(
        walletId: walletId,
        chainId: chainId,
        password: passcode?.value,
      );
}
