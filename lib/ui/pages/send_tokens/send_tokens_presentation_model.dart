// ignore_for_file: avoid_setters_without_getters
import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/broadcast_transaction.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/send_tokens_failure.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/send_tokens_form_data.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_form_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/utils/price_converter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class SendTokensViewModel {
  SendTokensFormStep get step;

  String get title;

  bool get recipientConfirmed;

  AccountAddress get recipientAddress;

  String get memo;

  bool get continueButtonEnabled;

  String get amountText;

  String get secondaryPriceText;

  PriceType get priceType;

  String get switchPriceTypeText;

  String get primaryAmountSymbol;

  Chain get chain;

  ChainAsset get selectedAsset;

  Prices get prices;

  VerifiedDenom get feeVerifiedDenom;

  GasPriceLevel get appliedFee;

  SendTokensFormData get formData;

  bool get isLoading;
}

class SendTokensPresentationModel with SendTokensPresentationModelBase implements SendTokensViewModel {
  SendTokensPresentationModel(
    this._initialParams,
    this._blockchainMetadataStore,
    this.priceConverter,
    this._accountsStore,
  ) {
    selectedAsset = _initialParams.asset.chainAssets.firstOrNull() ?? ChainAsset.empty();
    priceConverter.setTokenUsingChainAsset(
      selectedAsset,
      prices,
    );
    appliedFee = feeVerifiedDenom.gasPriceLevels.defaultLevel;
  }

  final AccountsStore _accountsStore;
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
  AccountAddress get recipientAddress => _recipientAddress.value;

  AccountAddressValidationError? get recipientAddressValidationError =>
      recipientAddress.validate(_blockchainMetadataStore);

  @override
  String get memo => _memo.value;

  @override
  bool get continueButtonEnabled {
    switch (step) {
      case SendTokensFormStep.recipient:
        return recipientConfirmed && recipientAddressValidationError == null;
      case SendTokensFormStep.amount:
        return tokenAmount != Amount.zero;
      case SendTokensFormStep.review:
        return true;
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

  bool get isInterChainTransfer => formData.senderChain != formData.recipientChain;

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
  Chain get chain => selectedAsset.chain;

  @override
  ChainAsset get selectedAsset => _selectedAsset.value;

  set selectedAsset(ChainAsset value) => Action(() {
        priceConverter.setTokenUsingChainAsset(value, _blockchainMetadataStore.prices);
        _selectedAsset.value = value;
      })();

  @override
  Prices get prices => _blockchainMetadataStore.prices;

  @override
  GasPriceLevel get appliedFee => _appliedFee.value;

  @override
  VerifiedDenom get feeVerifiedDenom => selectedAsset.verifiedDenom;

  EmerisAccount get account => _accountsStore.currentAccount;

  @override
  SendTokensFormData get formData => SendTokensFormData(
        sendAmount: tokenAmount,
        fee: appliedFee.toTransactionFee(),
        recipient: recipientAddress,
        recipientChain: _blockchainMetadataStore.chainForAddress(recipientAddress) ?? const Chain.empty(),
        sender: account.accountDetails.accountAddress,
        verifiedDenom: selectedAsset.verifiedDenom,
        senderChain:
            _blockchainMetadataStore.chainForAddress(account.accountDetails.accountAddress) ?? const Chain.empty(),
      );

  ObservableFuture<Either<SendTokensFailure, BroadcastTransaction>>? get sendTokensFuture => _sendTokensFuture.value;

  @override
  bool get isLoading => isFutureInProgress(sendTokensFuture);
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
  final Observable<AccountAddress> _recipientAddress = Observable(const AccountAddress.empty());

  set recipientAddress(AccountAddress value) => Action(() => _recipientAddress.value = value)();

  //////////////////////////////////////
  final Observable<String> _memo = Observable('');

  set memo(String value) => Action(() => _memo.value = value)();

  //////////////////////////////////////
  final Observable<ChainAsset> _selectedAsset = Observable(ChainAsset.empty());

  //////////////////////////////////////
  final Observable<GasPriceLevel> _appliedFee = Observable(GasPriceLevel.empty());

  set appliedFee(GasPriceLevel value) => Action(() => _appliedFee.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<SendTokensFailure, BroadcastTransaction>>?> _sendTokensFuture =
      Observable(null);

  set sendTokensFuture(ObservableFuture<Either<SendTokensFailure, BroadcastTransaction>>? value) =>
      Action(() => _sendTokensFuture.value = value)();
}
