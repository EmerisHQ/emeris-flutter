import 'package:equatable/equatable.dart';

class WalletIdentifier extends Equatable {
  const WalletIdentifier({
    required this.walletId,
    required this.chainId,
    this.password,
  });

  final String walletId;
  final String chainId;
  final String? password;

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
