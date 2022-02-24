import 'package:cosmos_ui_components/components/cosmos_app_bar.dart';
import 'package:cosmos_ui_components/components/cosmos_back_button.dart';
import 'package:cosmos_ui_components/components/cosmos_elevated_button.dart';
import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presenter.dart';
import 'package:flutter_app/ui/pages/asset_details/widgets/asset_prices_summary_row.dart';
import 'package:flutter_app/ui/pages/asset_details/widgets/chains_list.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/balance_card.dart';
import 'package:flutter_app/ui/pages/wallet_details/widgets/button_bar.dart';
import 'package:flutter_app/utils/emeris_amount_formatter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AssetDetailsPage extends StatefulWidget {
  const AssetDetailsPage({
    required this.initialParams,
    Key? key,
    this.presenter,
  }) : super(key: key);

  final AssetDetailsInitialParams initialParams;
  final AssetDetailsPresenter? presenter;

  @override
  AssetDetailsPageState createState() => AssetDetailsPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AssetDetailsInitialParams>('initialParams', initialParams))
      ..add(
        DiagnosticsProperty<AssetDetailsPresenter?>('presenter', presenter),
      );
  }
}

class AssetDetailsPageState extends State<AssetDetailsPage> {
  late AssetDetailsPresenter presenter;

  AssetDetailsViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AssetDetailsPresentationModel(widget.initialParams),
          param2: getIt<AssetDetailsNavigator>(),
        );
    presenter.navigator.context = context;
    presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Observer(
      builder: (context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CosmosAppBar(
                  leading: CosmosBackButton(),
                ),
                BalanceCard(
                  data: model.balance,
                ),
                SizedBox(height: theme.spacingL),
                Text(strings.balanceTitle),
                Text(
                  formatEmerisAmount(model.totalAmountInUSD),
                  style: TextStyle(
                    fontSize: theme.fontSizeXXL,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: theme.spacingL),
                AssetPricesSummaryRow(
                  isLoading: model.isStakedAmountLoading,
                  stakedAmount: model.stakedAmount,
                ),
                SizedBox(height: theme.spacingXL),
                SizedBox(
                  width: double.infinity,
                  child: CosmosElevatedButton(text: strings.buyCryptoAction),
                ),
                SizedBox(height: theme.spacingL),
                Text(
                  strings.chainsTitle,
                  style: TextStyle(
                    fontSize: theme.fontSizeXL,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Expanded(
                  child: ChainsList(
                    chainAssets: model.chainAssets,
                    isChainListLoading: model.isChainListLoading,
                  ),
                ),
                const Spacer(),
                CosmosButtonBar(
                  onTapReceive: presenter.onTapReceive,
                  onTapSend: presenter.onTapSend,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AssetDetailsPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AssetDetailsViewModel>('model', model));
  }
}
