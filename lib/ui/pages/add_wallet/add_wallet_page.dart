import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_presenter.dart';

class AddWalletPage extends StatefulWidget {
  final AddWalletInitialParams initialParams;
  final AddWalletPresenter? presenter;

  const AddWalletPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  late AddWalletPresenter presenter;
  AddWalletViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AddWalletPresentationModel(widget.initialParams),
          param2: getIt<AddWalletNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("AddWallet Page"),
      ),
    );
  }
}
