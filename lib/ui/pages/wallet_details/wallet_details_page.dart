import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/asset_portfolio_heading.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_heading.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balances_list.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/button_bar.dart';
import 'package:flutter_app/ui/widgets/emeris_gradient_avatar.dart';
import 'package:flutter_app/utils/emeris_amount_formatter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WalletDetailsPage extends StatefulWidget {
  const WalletDetailsPage({
    required this.initialParams,
    Key? key,
    this.presenter,
  }) : super(key: key);

  final WalletDetailsInitialParams initialParams;
  final WalletDetailsPresenter? presenter;

  @override
  WalletDetailsPageState createState() => WalletDetailsPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletDetailsInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<WalletDetailsPresenter?>('presenter', presenter));
  }
}

class WalletDetailsPageState extends State<WalletDetailsPage> {
  late WalletDetailsPresenter presenter;

  WalletDetailsViewModel get model => presenter.viewModel;

  /// TODO: move it to somewhere as a global constant
  static const double appBarHeight = 67;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletDetailsPresentationModel(widget.initialParams, getIt()),
          param2: getIt<WalletDetailsNavigator>(),
        );
    presenter.navigator.context = context;
    WidgetsBinding.instance?.addPostFrameCallback((_) => presenter.init());
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: CosmosAppBar(
            leading: EmerisGradientAvatar(
              onTap: showNotImplemented,
              address: model.walletAddress,
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
          body: ContentStateSwitcher(
            isLoading: model.isLoading,
            contentChild: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: theme.spacingM),
                  AssetPortfolioHeading(
                    title: strings.walletDetailsTitle(model.walletAlias),
                    onTap: presenter.onTapPortfolioHeading,
                  ),
                  Text(
                    formatEmerisAmount(model.totalAmountInUSD),
                    style: TextStyle(
                      fontSize: theme.fontSizeXXL,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: theme.spacingL),
                  CosmosButtonBar(
                    onTapReceive: presenter.onTapReceive,
                    onTapSend: presenter.onTapSend,
                  ),
                  SizedBox(height: theme.spacingL),
                  BalanceHeading(
                    wallet: model.wallet,
                  ),
                  BalancesList(
                    balances: model.balances,
                    onTapBalance: model.isSendMoneyLoading //
                        ? null
                        : (balance) => presenter.onTapTransfer(balance: balance),
                  ),
                  if (model.isSendMoneyLoading) ...[
                    SizedBox(height: theme.spacingS),
                    Center(
                      child: Text(
                        strings.sendingMoney,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletDetailsPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<WalletDetailsViewModel>('model', model));
  }
}
