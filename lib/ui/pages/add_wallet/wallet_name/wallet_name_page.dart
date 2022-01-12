import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_presenter.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/strings.dart';

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
    final theme = CosmosTheme.of(context);
    return Scaffold(
      appBar: const EmerisLogoAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(theme.spacingL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    strings.nameYourWalletTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: theme.spacingL),
                  Text(strings.nameYourWalletMessage),
                  SizedBox(height: theme.spacingXL),
                  TextFormField(
                    autofocus: true,
                    onChanged: presenter.onChanged,
                    decoration: InputDecoration(
                      hintText: strings.walletNameHint,
                    ),
                  ),
                  const Spacer(),
                  CosmosElevatedButton(text: strings.continueAction, onTap: presenter.onTapSubmit),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
