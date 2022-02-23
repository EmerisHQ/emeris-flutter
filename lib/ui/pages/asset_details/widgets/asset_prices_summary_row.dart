import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/utils/prices_formatter.dart';
import 'package:flutter_app/utils/strings.dart';

class AssetPricesSummaryRow extends StatelessWidget {
  const AssetPricesSummaryRow({
    required this.stakedAmount,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  final Amount stakedAmount;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      /// TODO: Pick these up from the model after API integration
      children: [
        Column(
          children: [
            Text(strings.availableTitle),
            const Text(r'#$110.23'),
          ],
        ),
        ContentStateSwitcher(
          isLoading: isLoading,
          contentChild: Column(
            children: [
              Text(strings.stakedTitle),
              Text(formatEmerisAmount(stakedAmount)),
            ],
          ),
        ),
        Column(
          children: [
            Text(strings.pooledTitle),
            const Text(r'#$11.54'),
          ],
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Amount>('stakedAmount', stakedAmount))
      ..add(DiagnosticsProperty<bool>('isStakedAmountLoading', isLoading));
  }
}
