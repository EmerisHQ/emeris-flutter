import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class WelcomeSplash extends StatelessWidget {
  const WelcomeSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: theme.colors.divider,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: theme.spacingL),
        Text(
          strings.welcomeToEmerisTitle,
          style: Theme.of(context).textTheme.headline4,
        ),
        const Spacer(),
        Text(
          strings.splashLargeTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
