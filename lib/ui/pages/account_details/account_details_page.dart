import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated_assets/assets.gen.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presenter.dart';
import 'package:flutter_app/ui/pages/account_details/widgets/asset_portfolio_heading.dart';
import 'package:flutter_app/ui/pages/account_details/widgets/assets_list.dart';
import 'package:flutter_app/ui/pages/account_details/widgets/balance_heading.dart';
import 'package:flutter_app/ui/pages/account_details/widgets/button_bar.dart';
import 'package:flutter_app/ui/widgets/emeris_gradient_avatar.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);
  final AccountDetailsPresenter presenter;

  @override
  AccountDetailsPageState createState() => AccountDetailsPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AccountDetailsPresenter?>('presenter', presenter));
  }
}

class AccountDetailsPageState extends State<AccountDetailsPage> {
  AccountDetailsPresenter get presenter => widget.presenter;

  AccountDetailsViewModel get model => presenter.viewModel;

  /// TODO: move it to somewhere as a global constant
  static const double appBarHeight = 67;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: CosmosAppBar(
            leading: EmerisGradientAvatar(
              onTap: presenter.onTapAvatar,
              address: model.accountAddress,
            ),
            preferredHeight: appBarHeight,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: theme.spacingL),
                child: InkWell(
                  onTap: presenter.onTapQr,
                  child: Image.asset(
                    Assets.imagesIconScanQr.path,
                    color: theme.colors.text,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: theme.spacingM),
                AssetPortfolioHeading(
                  title: strings.accountDetailsTitle(model.accountAlias),
                  onTap: presenter.onTapPortfolioHeading,
                ),
                Text(
                  model.totalAmountInUSD,
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
                  account: model.account,
                ),
                Expanded(
                  child: AssetsList(
                    assets: model.assets,
                    onTapBalance: model.isSendTokensLoading //
                        ? null
                        : presenter.onTapTransfer,
                    prices: model.prices,
                  ),
                ),
                if (model.isSendTokensLoading) ...[
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
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountDetailsPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AccountDetailsViewModel>('model', model));
  }
}
