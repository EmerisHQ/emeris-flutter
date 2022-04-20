import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';

class AccountDetails extends Equatable {
  const AccountDetails({
    required this.accountIdentifier,
    required this.accountAlias,
    required this.accountAddress,
  });

  const AccountDetails.empty()
      : accountIdentifier = const AccountIdentifier.empty(),
        accountAddress = const AccountAddress.empty(),
        accountAlias = '';

  final AccountIdentifier accountIdentifier;
  final String accountAlias;
  final AccountAddress accountAddress;

  @override
  List<Object?> get props => [
        accountIdentifier,
        accountAlias,
        accountAddress,
      ];

  AccountDetails copyWith({
    AccountIdentifier? accountIdentifier,
    String? accountAlias,
    AccountAddress? accountAddress,
  }) {
    return AccountDetails(
      accountIdentifier: accountIdentifier ?? this.accountIdentifier,
      accountAlias: accountAlias ?? this.accountAlias,
      accountAddress: accountAddress ?? this.accountAddress,
    );
  }
}
