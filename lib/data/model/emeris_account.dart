import 'package:cosmos_ui_components/models/account_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';

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

  @override
  List<Object?> get props => [
        accountDetails,
        accountType,
      ];
}

extension EmerisAccountInfo on EmerisAccount {
  AccountInfo get accountInfo => AccountInfo(
        name: accountDetails.accountAlias,
        address: accountDetails.accountAddress,
        accountId: accountDetails.accountIdentifier.accountId,
      );
}

extension EmerisPublicAccountInfo on EmerisAccount {
  AccountPublicInfo get publicAccountInfo => AccountPublicInfo(
        name: accountInfo.name,
        chainId: accountDetails.accountIdentifier.chainId,
        accountId: accountInfo.accountId,
        publicAddress: accountInfo.address,
        additionalData: '',
      );
}
