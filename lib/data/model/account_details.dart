import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';

class AccountDetails extends Equatable {
  const AccountDetails({
    required this.accountIdentifier,
    required this.accountAlias,
    required this.accountAddress,
  });

  const AccountDetails.empty()
      : accountIdentifier = const AccountIdentifier.empty(),
        accountAddress = '',
        accountAlias = '';

  final AccountIdentifier accountIdentifier;
  final String accountAlias;
  final String accountAddress;

  @override
  List<Object?> get props => [
        accountIdentifier,
        accountAlias,
        accountAddress,
      ];
}
