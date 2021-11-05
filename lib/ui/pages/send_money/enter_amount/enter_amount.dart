import 'package:cosmos_ui_components/components/cosmos_app_bar.dart';
import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:flutter/material.dart';

class EnterAmountPage extends StatefulWidget {
  const EnterAmountPage({Key? key}) : super(key: key);

  @override
  _EnterAmountPageState createState() => _EnterAmountPageState();
}

class _EnterAmountPageState extends State<EnterAmountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CosmosAppBar(),
      body: Center(
        child: Column(
          children: const [
            Text(
              'Enter Amount',
              style: TextStyle(fontSize: CosmosAppTheme.fontSizeXL),
            ),
          ],
        ),
      ),
    );
  }
}
