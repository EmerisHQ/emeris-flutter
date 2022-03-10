import 'package:cosmos_ui_components/components/content_state_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/ui/pages/asset_details/widgets/chain_card.dart';

class ChainsList extends StatelessWidget {
  const ChainsList({
    required this.isChainListLoading,
    required this.chainAssets,
    required this.prices,
    Key? key,
  }) : super(key: key);

  final bool isChainListLoading;
  final List<ChainAsset> chainAssets;
  final Prices prices;

  @override
  Widget build(BuildContext context) {
    return ContentStateSwitcher(
      isLoading: isChainListLoading,
      contentChild: ListView(
        children: chainAssets //
            .map(
              (it) => ChainCard(
                chainAsset: it,
                totalPriceText: prices.totalPriceText(it.balance),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isChainListLoading', isChainListLoading))
      ..add(IterableProperty<ChainAsset>('chainAssets', chainAssets))
      ..add(DiagnosticsProperty<Prices>('prices', prices));
  }
}
