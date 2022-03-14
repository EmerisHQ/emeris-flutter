// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_utils/extensions.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/balance_with_price_info.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_form_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/utils/price_converter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:mobx/mobx.dart';

abstract class SendTokensViewModel {
  SendTokensFormStep get step;

  String get title;

  bool get recipientConfirmed;

  String get recipientAddress;

  String get memo;

  bool get continueButtonEnabled;

  String get amountText;

  String get secondaryPriceText;

  PriceType get priceType;

  String get switchPriceTypeText;

  String get primaryAmountSymbol;

  BalanceWithPriceInfo get balanceWithPriceInfo;

  Chain get chain;
}

class SendTokensPresentationModel with SendTokensPresentationModelBase implements SendTokensViewModel {
  SendTokensPresentationModel(
    this._initialParams,
    this._blockchainMetadataStore,
    this.priceConverter,
  ) {
    selectedAsset = _initialParams.asset.chainAssets.firstOrNull() ?? ChainAsset.empty();
    priceConverter.setTokenUsingChainAsset(
      selectedAsset,
      _blockchainMetadataStore.prices,
    );
  }

  final PriceConverter priceConverter;

  final BlockchainMetadataStore _blockchainMetadataStore;

  // ignore: unused_field
  final SendTokensInitialParams _initialParams;

  @override
  SendTokensFormStep get step => _step.value;

  @override
  String get title {
    switch (step) {
      case SendTokensFormStep.recipient:
        return strings.recipientStepTitle;
      case SendTokensFormStep.amount:
        return strings.amountStepTitle;
      case SendTokensFormStep.review:
        return strings.reviewStepTitle;
    }
  }

  @override
  bool get recipientConfirmed => _recipientConfirmed.value;

  @override
  String get recipientAddress => _recipientAddress.value;

  @override
  String get memo => _memo.value;

  @override
  bool get continueButtonEnabled {
    switch (step) {
      case SendTokensFormStep.recipient:
        return recipientConfirmed && recipientAddress.isNotEmpty;
      case SendTokensFormStep.amount:
        return tokenAmount != Amount.zero;
      case SendTokensFormStep.review:
        // TODO: Handle this case.
        return false;
    }
  }

  @override
  String get amountText => priceConverter.primaryText;

  Denom get denom => priceConverter.denom;

  Amount get tokenAmount => priceConverter.primaryAmountType == PriceType.token
      ? priceConverter.primaryAmount
      : priceConverter.secondaryAmount;

  /// Balance to be sent based on the form input
  Balance get sendBalance => Balance(
        denom: denom,
        amount: tokenAmount,
      );

  /// Balance currently available in the account
  Balance get walletBalance => selectedAsset.balance;

  @override
  String get secondaryPriceText => priceConverter.secondaryPriceText;

  @override
  PriceType get priceType => priceConverter.primaryAmountType;

  @override
  String get switchPriceTypeText {
    switch (priceConverter.primaryAmountType) {
      case PriceType.token:
        return priceConverter.tokenPair.symbol;
      case PriceType.fiat:
        return denom.displayName;
    }
  }

  set amountText(String amount) => priceConverter.primaryText = amount;

  void switchCurrency() {
    priceConverter..primaryAmountType = priceConverter.secondaryAmountType;
  }

  void setMaxAmount() {
    final type = priceConverter.primaryAmountType;
    priceConverter
      ..primaryAmountType = PriceType.token
      ..primaryText = walletBalance.amount.displayText
      ..primaryAmountType = type;
  }

  @override
  String get primaryAmountSymbol {
    switch (priceType) {
      case PriceType.token:
        return denom.displayName;
      case PriceType.fiat:
        return priceConverter.tokenPair.symbol;
    }
  }

  TokenPair get tokenPair => _blockchainMetadataStore.prices.priceForDenom(denom) ?? TokenPair.zero(denom);

  @override
  BalanceWithPriceInfo get balanceWithPriceInfo => BalanceWithPriceInfo(
        balance: walletBalance,
        tokenPair: tokenPair,
      );

  @override
  Chain get chain => selectedAsset.chain;

  ChainAsset get selectedAsset => _selectedAsset.value;

  set selectedAsset(ChainAsset value) => Action(() {
        priceConverter.setTokenUsingChainAsset(value, _blockchainMetadataStore.prices);
        _selectedAsset.value = value;
      })();
}

//////////////////BOILERPLATE
abstract class SendTokensPresentationModelBase {
  //////////////////////////////////////
  final Observable<SendTokensFormStep> _step = Observable(SendTokensFormStep.recipient);

  set step(SendTokensFormStep value) => Action(() => _step.value = value)();

  //////////////////////////////////////
  final Observable<bool> _recipientConfirmed = Observable(false);

  set recipientConfirmed(bool value) => Action(() => _recipientConfirmed.value = value)();

  //////////////////////////////////////
  final Observable<String> _recipientAddress = Observable('');

  set recipientAddress(String value) => Action(() => _recipientAddress.value = value)();

  //////////////////////////////////////
  final Observable<String> _memo = Observable('');

  set memo(String value) => Action(() => _memo.value = value)();

  //////////////////////////////////////
  final Observable<ChainAsset> _selectedAsset = Observable(ChainAsset.empty());
}
