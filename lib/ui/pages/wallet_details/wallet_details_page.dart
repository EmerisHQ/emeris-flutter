import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_card.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_heading.dart';
import 'package:flutter_app/ui/widgets/content_state_switcher.dart';
import 'package:flutter_app/ui/widgets/emeris_app_bar.dart';
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
      appBar: EmerisAppBar(
        title: strings.walletDetailsTitle(widget.initialParams.wallet.walletDetails.walletAlias),
      ),
      body: Center(
        child: Observer(
          builder: (context) => ContentStateSwitcher(
            contentChild: Column(
              children: [
                ListTile(
                  title: Text(strings.walletAddress),
                  subtitle: Text(widget.initialParams.wallet.walletDetails.walletAddress),
                ),
                const Divider(),
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
