import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceHeading extends StatelessWidget {
  const BalanceHeading({
    required this.account,
    Key? key,
  }) : super(key: key);
  final EmerisAccount account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: CosmosTheme.of(context).spacingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(strings.assetTitle, textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline6),
          Text(strings.balanceTitle),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EmerisAccount>('account', account));
  }
}
