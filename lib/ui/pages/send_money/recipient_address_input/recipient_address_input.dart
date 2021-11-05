import 'package:cosmos_ui_components/components/cosmos_app_bar.dart';
import 'package:cosmos_ui_components/components/cosmos_elevated_button.dart';
import 'package:cosmos_ui_components/components/cosmos_outline_button.dart';
import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:flutter/material.dart';

class RecipientAddressInputPage extends StatefulWidget {
  const RecipientAddressInputPage({Key? key}) : super(key: key);

  @override
  _RecipientAddressInputPageState createState() => _RecipientAddressInputPageState();
}

class _RecipientAddressInputPageState extends State<RecipientAddressInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CosmosAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: CosmosAppTheme.spacingM),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Send', style: TextStyle(fontSize: CosmosAppTheme.fontSizeXL)),
                _buildMainBody(),
                _buildFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildFooter() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: CosmosAppTheme.spacingM),
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              Checkbox(onChanged: (value) {}, value: false),
              const Expanded(
                child: Text(
                  'I have reviewed the address and I understand that if it incorrect, my funds may be lost',
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: CosmosElevatedButton(onTap: () {}, text: 'Continue')),
          ],
        ),
      ],
    );
  }

  Column _buildMainBody() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text('To'), Icon(Icons.qr_code_scanner_sharp)],
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: 'Recipient address',
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: CosmosOutlineButton(onTap: () {}, text: 'Paste'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text('Reference (memo)'), Icon(Icons.info)],
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: 'Add reference (optional)',
          ),
          maxLines: null,
        ),
      ],
    );
  }
}
