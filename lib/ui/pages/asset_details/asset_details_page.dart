import 'package:cosmos_ui_components/components/content_state_switcher.dart';
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
import 'package:flutter_app/ui/pages/asset_details/widgets/chain_card.dart';
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
      ..add(DiagnosticsProperty<AssetDetailsPresenter?>('presenter', presenter));
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
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CosmosAppBar(leading: CosmosBackButton()),
                BalanceCard(data: widget.initialParams.balance),
                Padding(
                  padding: EdgeInsets.only(left: theme.spacingL, top: theme.spacingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(strings.balanceTitle),
                      Text(
                        formatEmerisAmount(widget.initialParams.assetDetails.totalAmountInUSD),
                        style: TextStyle(
                          fontSize: theme.fontSizeXXL,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(theme.spacingL),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    /// TODO: Pick these up from the model after API integration
                    children: [
                      Column(
                        children: [
                          Text(strings.availableTitle),
                          const Text(r'#$110.23'),
                        ],
                      ),
                      ContentStateSwitcher(
                        isLoading: model.isStakedAmountLoading,
                        contentChild: Column(
                          children: [
                            Text(strings.stakedTitle),
                            Text(formatEmerisAmount(model.stakedAmount)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(strings.pooledTitle),
                          const Text(r'#$11.54'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(theme.spacingL),
                  child: Row(
                    children: [
                      Expanded(child: CosmosElevatedButton(text: strings.buyCryptoAction)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(theme.spacingL),
                  child: Text(
                    strings.chainsTitle,
                    style: TextStyle(
                      fontSize: theme.fontSizeXL,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Expanded(
                  child: ContentStateSwitcher(
                    isLoading: model.isChainListLoading,
                    contentChild: ListView(
                      children: model.chainAssets.map((e) => ChainCard(chainAsset: e)).toList(),
                    ),
                  ),
                ),
                const Spacer(),
                CosmosButtonBar(onTapReceive: presenter.onTapReceive, onTapSend: presenter.onTapSend),
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
      ..add(DiagnosticsProperty<AssetDetailsPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AssetDetailsViewModel>('model', model));
  }
}
