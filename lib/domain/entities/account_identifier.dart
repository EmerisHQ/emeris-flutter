import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

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

  bool isSameAs(AccountPublicInfo it) => accountId == it.accountId && chainId == it.chainId;
}
