import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_card.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_heading.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/button_bar.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WalletDetailsPage extends StatefulWidget {
  final WalletDetailsInitialParams initialParams;
  final WalletDetailsPresenter? presenter;

  const WalletDetailsPage({
    Key? key,
    required this.initialParams,
    this.presenter,
  }) : super(key: key);

  @override
  _WalletDetailsPageState createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  late WalletDetailsPresenter presenter;

  WalletDetailsViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletDetailsPresentationModel(widget.initialParams),
          param2: getIt<WalletDetailsNavigator>(),
        );
    presenter.navigator.context = context;
    presenter.getWalletBalances(widget.initialParams.wallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(actions: [IconButton(icon: const Icon(Icons.qr_code_scanner_sharp), onPressed: () {})]),
      body: Center(
        child: Observer(
          builder: (context) => ContentStateSwitcher(
            contentChild: Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Text(strings.walletDetailsTitle(widget.initialParams.wallet.walletDetails.walletAlias)),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  subtitle: Text(
                    '\$766.43',
                    style:
                        TextStyle(fontSize: CosmosAppTheme.fontSizeXXL, color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                CosmosButtonBar(onReceivePressed: () {}, onSendPressed: () {}),
                const Padding(padding: EdgeInsets.only(top: 16)),
                BalanceHeading(
                  wallet: widget.initialParams.wallet,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: model.balanceList.list
                        .map(
                          (balance) => BalanceCard(
                            data: balance,
                            onTransferPressed: model.isSendMoneyLoading
                                ? null
                                : () {
                                    presenter.transferTapped(
                                      balance: balance,
                                    );
                                  },
                          ),
                        )
                        .toList(),
                  ),
                ),
                if (model.isSendMoneyLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text(
                        strings.sendingMoney,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            isLoading: model.isLoading,
          ),
        ),
      ),
    );
  }
}
