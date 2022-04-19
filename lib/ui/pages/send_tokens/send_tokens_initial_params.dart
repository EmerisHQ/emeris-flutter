import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/asset.dart';

class SendTokensInitialParams {
  const SendTokensInitialParams(
    this.asset, {
    this.recipientAddress = const AccountAddress.empty(),
  });

  final Asset asset;

  final AccountAddress recipientAddress;
}
