import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/asset_portfolio_heading.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_card.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_heading.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/button_bar.dart';
import 'package:flutter_app/ui/widgets/emeris_gradient_avatar.dart';
import 'package:flutter_app/utils/emeris_amount_formatter.dart';
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

  /// TODO: move it to somewhere as a global constant
  static const double appBarHeight = 67;

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
        leading: EmerisGradientAvatar(
          onTap: showNotImplemented,
          address: widget.initialParams.wallet.walletDetails.walletAddress,
        ),
        preferredHeight: appBarHeight,
        actions: const [
          IconButton(
            /// TODO: Pick this up from the design after Figma is finalised
            icon: Icon(Icons.qr_code_scanner_sharp),
            onPressed: showNotImplemented,
          ),
        ],
      ),
      body: Observer(
        builder: (context) => ContentStateSwitcher(
          contentChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetPortfolioHeading(
                title: strings.walletDetailsTitle(widget.initialParams.wallet.walletDetails.walletAlias),
                onTap: presenter.onTapPortfolioHeading,
              ),
              Padding(
                padding: EdgeInsets.only(left: theme.spacingL),
                child: Text(
                  formatEmerisAmount(model.assetDetails.totalAmountInUSD),
                  style: TextStyle(
                    fontSize: theme.fontSizeXXL,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              CosmosButtonBar(onReceivePressed: presenter.onReceivePressed, onSendPressed: presenter.onSendPressed),
              Padding(padding: EdgeInsets.only(top: theme.spacingM)),
              BalanceHeading(wallet: widget.initialParams.wallet),
              Column(
                children: model.assetDetails.balances
                    .map(
                      (balance) => BalanceCard(
                        data: balance,
                        onTap: model.isSendMoneyLoading
                            ? null
                            : () => presenter.transferTapped(
                                  balance: balance,
                                  assetDetails: model.assetDetails,
                                ),
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
}
