import 'package:cosmos_ui_components/models/account_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';

class EmerisAccount extends Equatable {
  const EmerisAccount({
    required this.accountDetails,
    required this.accountType,
  });

  const EmerisAccount.empty()
      : accountDetails = const AccountDetails.empty(),
        accountType = AccountType.Cosmos;

  final AccountDetails accountDetails;
  final AccountType accountType;

  AccountIdentifier get id => accountDetails.accountIdentifier;

  @override
  List<Object?> get props => [
        accountDetails,
        accountType,
      ];

  EmerisAccount copyWith({
    AccountDetails? accountDetails,
    AccountType? accountType,
  }) {
    return EmerisAccount(
      accountDetails: accountDetails ?? this.accountDetails,
      accountType: accountType ?? this.accountType,
    );
  }
}

extension EmerisAccountInfo on EmerisAccount {
  AccountInfo get accountInfo => AccountInfo(
        name: accountDetails.accountAlias,
        address: accountDetails.accountAddress.value,
        accountId: id.accountId,
      );
}

extension EmerisAccountFindById on Iterable<EmerisAccount> {
  EmerisAccount withId(String accountId) =>
      firstWhere((element) => element.accountDetails.accountIdentifier.accountId == accountId);
}
