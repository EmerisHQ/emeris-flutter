import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/passcode.dart';

class AccountIdentifier extends Equatable {
  const AccountIdentifier({
    required this.accountId,
    required this.chainId,
    this.password,
  });

  const AccountIdentifier.empty()
      : accountId = '',
        chainId = '',
        password = '';

  final String accountId;
  final String chainId;
  final String? password;

  @override
  List<Object?> get props => [
        accountId,
        chainId,
      ];

  AccountIdentifier byUpdatingPasscode(Passcode? passcode) => AccountIdentifier(
        accountId: accountId,
        chainId: chainId,
        password: passcode?.value,
      );
}
