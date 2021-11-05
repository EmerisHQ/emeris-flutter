import 'package:cosmos_ui_components/components/cosmos_app_bar.dart';
import 'package:cosmos_ui_components/components/cosmos_elevated_button.dart';
import 'package:cosmos_ui_components/components/cosmos_outline_button.dart';
import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/presentation/send_money/recipient_address_input/recipient_address_input_presenter.dart';
import 'package:flutter_app/ui/pages/send_money/recipient_address_input/recipient_address_input_navigator.dart';

class RecipientAddressInputPage extends StatefulWidget {
  final RecipientAddressInputPresenter? presenter;

  const RecipientAddressInputPage({Key? key, this.presenter}) : super(key: key);

  @override
  _RecipientAddressInputPageState createState() => _RecipientAddressInputPageState();
}

class _RecipientAddressInputPageState extends State<RecipientAddressInputPage> {
  late RecipientAddressInputPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ?? getIt(param1: getIt<RecipientAddressInputNavigator>());
    presenter.navigator.context = context;
  }

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
            Expanded(
              child: CosmosElevatedButton(onTap: () => presenter.navigator.navigateToEnterAmount(), text: 'Continue'),
            ),
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
