import 'package:cosmos_utils/amount_formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:mobx/mobx.dart';

enum PriceType {
  token,
  fiat,
}

class PriceConverter extends _PriceConverterBase with EquatableMixin {
  PriceConverter();

  Denom get denom => _denom.value;

  TokenPair get tokenPair => _tokenPair.value;

  String get primaryText => _primaryText.value;

  PriceType get primaryAmountType => _primaryAmountType.value;

  set primaryAmountType(PriceType value) => Action(() {
        if (value != primaryAmountType) {
          primaryText = secondaryAmount.displayText;
          _primaryAmountType.value = value;
        }
      })();

  PriceType get secondaryAmountType {
    switch (primaryAmountType) {
      case PriceType.token:
        return PriceType.fiat;
      case PriceType.fiat:
        return PriceType.token;
    }
  }

  Amount get primaryAmount => Amount.tryParse(primaryText) ?? Amount.zero;

  Amount get secondaryAmount {
    switch (primaryAmountType) {
      case PriceType.token:
        return tokenPair.totalPriceAmount(primaryAmount);
      case PriceType.fiat:
        return tokenPair.unitPrice.isZero ? Amount.zero : primaryAmount / tokenPair.unitPrice;
    }
  }

  String get secondaryPriceText => _formatPrice(secondaryAmountType, secondaryAmount);

  String get primaryPriceText => _formatPrice(primaryAmountType, primaryAmount);

  String _formatPrice(PriceType type, Amount amount) {
    switch (type) {
      case PriceType.token:
        return '${amount.displayText} $denom';
      case PriceType.fiat:
        return formatAmount(amount.value.toDouble(), symbol: tokenPair.symbol);
    }
  }

  @override
  List<Object?> get props => [
        tokenPair,
        denom,
        primaryText,
        primaryAmountType,
      ];

  void setTokenUsingChainAsset(ChainAsset asset, Prices prices) => Action(() {
        _denom.value = asset.balance.denom;
        _tokenPair.value = prices.priceForDenom(denom) ?? TokenPair.zero(denom);
      })();

  void setTokenUsingDenom(Denom denom, TokenPair tokenPair) => Action(() {
        _denom.value = denom;
        _tokenPair.value = tokenPair;
      })();
}

abstract class _PriceConverterBase {
  //////////////////////////////////////
  final Observable<String> _primaryText = Observable('');

  set primaryText(String value) => Action(() => _primaryText.value = value)();

  //////////////////////////////////////
  final Observable<PriceType> _primaryAmountType = Observable(PriceType.token);

  //////////////////////////////////////
  final Observable<Denom> _denom = Observable(const Denom.empty());

  //////////////////////////////////////
  final Observable<TokenPair> _tokenPair = Observable(TokenPair.zero());
}
