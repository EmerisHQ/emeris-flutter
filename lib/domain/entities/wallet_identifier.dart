import 'package:equatable/equatable.dart';

class WalletIdentifier extends Equatable {
  final String walletId;
  final String chainId;
  final String? password;

  const WalletIdentifier({
    required this.walletId,
    required this.chainId,
    this.password,
  });

  @override
  List<Object?> get props => [
        walletId,
        chainId,
      ];

  WalletIdentifier byUpdatingPassword(String? password) => WalletIdentifier(
        walletId: walletId,
        chainId: chainId,
        password: password,
      );
}
