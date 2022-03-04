import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceWithPriceInfo extends Equatable {
  const BalanceWithPriceInfo({
    required this.balance,
    required this.tokenPair,
  });

  final Balance balance;
  final TokenPair tokenPair;

  Denom get denom => balance.denom;

  String get denomText => denom.text;

  @override
  List<Object> get props => [
        balance,
        tokenPair,
      ];

  String get totalBalanceFiatPriceText => balance.totalPriceText(tokenPair);

  String get totalTokensAvailableText => strings.tokenAvailableFormat(balance.amountWithDenomText);
}
