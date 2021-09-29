import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_presenter.dart';

class WalletNamePage extends StatefulWidget {
  final WalletNameInitialParams initialParams;
  final WalletNamePresenter? presenter;

  const WalletNamePage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _WalletNamePageState createState() => _WalletNamePageState();
}

class _WalletNamePageState extends State<WalletNamePage> {
  late WalletNamePresenter presenter;

  WalletNameViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletNamePresentationModel(widget.initialParams),
          param2: getIt<WalletNameNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("WalletName Page"),
            CosmosElevatedButton(text: "name", onTap: presenter.onTapSubmit),
          ],
        ),
      ),
    );
  }
}
