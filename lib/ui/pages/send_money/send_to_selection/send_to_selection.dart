import 'package:cosmos_ui_components/components/cosmos_app_bar.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/presentation/send_money/send_to_selection/send_to_selection_presenter.dart';
import 'package:flutter_app/ui/pages/send_money/send_to_selection/send_to_selection_navigator.dart';

class SendToSelectionPage extends StatefulWidget {
  final SendToSelectionPresenter? presenter;

  const SendToSelectionPage({Key? key, this.presenter}) : super(key: key);

  @override
  State<SendToSelectionPage> createState() => _SendToSelectionPageState();
}

class _SendToSelectionPageState extends State<SendToSelectionPage> {
  late SendToSelectionPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ?? getIt(param1: getIt<SendToSelectionNavigator>());
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: CosmosAppTheme.spacingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Who are you sending to?', style: TextStyle(fontSize: CosmosAppTheme.fontSizeXL)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CosmosOutlineButton(
                            onTap: () => presenter.navigator.navigateToRecipientAddressInput(),
                            text: 'Send To Address',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: CosmosOutlineButton(onTap: () {}, text: 'Move Assets')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
