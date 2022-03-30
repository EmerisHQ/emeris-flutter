import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

class ReviewAmountWithDenom extends StatelessWidget {
  const ReviewAmountWithDenom({
    required this.amount,
    required this.verifiedDenom,
    required this.chain,
    Key? key,
  }) : super(key: key);

  final Amount amount;
  final VerifiedDenom verifiedDenom;
  final Chain chain;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          verifiedDenom.amountWithDenomText(amount),
          style: CosmosTextTheme.title0Bold,
        ),
        Text(
          chain.displayName,
          style: CosmosTextTheme.copyMinus1Normal,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Amount>('amount', amount))
      ..add(DiagnosticsProperty<Chain>('chain', chain))
      ..add(DiagnosticsProperty<VerifiedDenom>('verifiedDenom', verifiedDenom));
  }
}
