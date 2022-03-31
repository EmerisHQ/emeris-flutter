import 'package:cosmos_utils/amount_formatter.dart';
import 'package:cosmos_utils/extensions.dart';
import 'package:cosmos_utils/group_by_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/utils/prices_formatter.dart';

class Balance extends Equatable {
  const Balance({
    required this.denom,
    required this.amount,
    this.onChain = '',
  });

  Balance.empty()
      : denom = const Denom.empty(),
        amount = Amount.zero,
        onChain = '';

  final Denom denom;
  final Amount amount;
  final String onChain;

  Amount totalPrice(Prices prices) => prices.priceForDenom(denom)?.totalPriceAmount(amount) ?? Amount.zero;

  @override
  String toString() {
    return '$amount $denom';
  }

  @override
  List<Object> get props => [
        denom,
        amount,
      ];

  String totalPriceText(TokenPair tokenPair) => formatTokenPrice(
        amount,
        tokenPair,
      );

  String unitPriceText(Prices prices) => formatTokenPrice(
        Amount.one,
        prices.priceForDenom(denom) ?? TokenPair.zero(denom),
      );

  /// TODO use 'precision' for determining the format
  String get amountWithDenomText => denom.amountWithDenomText(amount);

  ChainAsset toChainAsset(BlockchainMetadataStore store, {VerifiedDenom? verifiedDenom}) => ChainAsset(
        chain: store.chainForName(onChain) ?? const Chain.empty(),
        verifiedDenom: verifiedDenom ?? store.verifiedDenom(denom) ?? const VerifiedDenom.empty(),
        balance: this,
      );

  Balance copyWith({
    Denom? denom,
    Amount? amount,
    String? onChain,
  }) {
    return Balance(
      denom: denom ?? this.denom,
      amount: amount ?? this.amount,
      onChain: onChain ?? this.onChain,
    );
  }
}

extension BalancesListExtensions on Iterable<Balance> {
  Amount get totalAmount => Amount(
        map((it) => it.amount.value).reduce((a, b) => a + b),
      );

  Amount totalAmountInUSD(Prices prices) => isEmpty //
      ? Amount.zero
      : map((it) => it.totalPrice(prices)).reduce((a, b) => a + b);

  String totalAmountInUSDText(Prices prices) {
    final balance = firstOrNull();
    if (balance == null) {
      return '';
    }
    final pair = prices.priceForDenom(balance.denom);
    if (pair == null) {
      return '';
    }
    return formatAmount(
      totalAmountInUSD(prices).value.toDouble(),
    );
  }

  List<Asset> groupIntoAssets(
    BlockchainMetadataStore store,
  ) {
    final map = groupBy((obj) => obj.denom);
    return map.entries.map(
      (entry) {
        final verifiedDenom = store.verifiedDenom(entry.key) ?? const VerifiedDenom.empty();
        return Asset(
          verifiedDenom: verifiedDenom,
          chainAssets: entry.value.map((balance) => balance.toChainAsset(store, verifiedDenom: verifiedDenom)).toList(),
        );
      },
    ).toList();
  }
}
