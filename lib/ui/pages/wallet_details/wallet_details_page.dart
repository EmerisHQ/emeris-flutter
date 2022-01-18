import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:cosmos_utils/amount_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/asset_portfolio_heading.dart';
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
    final theme = CosmosTheme.of(context);
    return Scaffold(
      appBar: CosmosAppBar(
        leading: _gradientAvatar(context),
        preferredHeight: 70,
        actions: [
          IconButton(icon: const Icon(Icons.qr_code_scanner_sharp), onPressed: () {}),
        ],
      ),
      body: Observer(
        builder: (context) => ContentStateSwitcher(
          contentChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetPortfolioHeading(
                title: strings.walletDetailsTitle(widget.initialParams.wallet.walletDetails.walletAlias),
                onTap: () {
                  presenter.navigator.openWalletsList(const WalletsListInitialParams());
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: theme.spacingL),
                child: Text(
                  formatAmount(model.assetDetails.totalAmountInUSD.value.toDouble()),
                  style: TextStyle(
                    fontSize: theme.fontSizeXXL,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              CosmosButtonBar(onReceivePressed: () {}, onSendPressed: () {}),
              Padding(padding: EdgeInsets.only(top: theme.spacingM)),
              BalanceHeading(
                wallet: widget.initialParams.wallet,
              ),
              Column(
                children: model.assetDetails.balances
                    .map(
                      (balance) => BalanceCard(
                        data: balance,
                        onTransferPressed:
                            model.isSendMoneyLoading ? null : () => presenter.transferTapped(balance: balance),
                      ),
                    )
                    .toList(),
              ),
              if (model.isSendMoneyLoading)
                Padding(
                  padding: EdgeInsets.only(top: theme.spacingS),
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
    );
  }

  Widget _gradientAvatar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(CosmosTheme.of(context).spacingL),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 35,
          child: InkWell(
            onTap: () {},
            child: GradientAvatar(stringKey: widget.initialParams.wallet.walletDetails.walletAddress),
          ),
        ),
      ),
    );
  }
}
