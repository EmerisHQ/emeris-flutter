import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';

class AssetPortfolioHeading extends StatelessWidget {
  const AssetPortfolioHeading({
    required this.title,
    required this.onTap,
    this.isCentered = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: CosmosTheme.of(context).spacingL, top: CosmosTheme.of(context).spacingM),
      child: Row(
        mainAxisAlignment: isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: CosmosTheme.of(context).fontSizeXL, fontWeight: FontWeight.w700)),
          IconButton(
            icon: Icon(Icons.arrow_downward_sharp, size: CosmosTheme.of(context).fontSizeXL),
            onPressed: onTap,
          )
        ],
      ),
    );
  }
}
