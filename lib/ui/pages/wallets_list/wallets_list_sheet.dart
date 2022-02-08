import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WalletsListSheet extends StatefulWidget {
  const WalletsListSheet({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final WalletsListInitialParams initialParams;
  final WalletsListPresenter? presenter;

  @override
  WalletsListSheetState createState() => WalletsListSheetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletsListPresenter?>('presenter', presenter))
      ..add(DiagnosticsProperty<WalletsListInitialParams>('initialParams', initialParams));
  }
}

class WalletsListSheetState extends State<WalletsListSheet> {
  late WalletsListPresenter presenter;

  WalletsListViewModel get model => presenter.viewModel;

  WalletInfo get selectedWallet => WalletInfo(
        name: model.selectedWallet.walletDetails.walletAlias,
        address: model.selectedWallet.walletDetails.walletAddress,
        walletId: model.selectedWallet.walletDetails.walletIdentifier.walletId,
      );

  List<WalletInfo> get walletInfos => model.wallets
      .map(
        (e) => WalletInfo(
          name: e.walletDetails.walletAlias,
          address: e.walletDetails.walletAddress,
          walletId: e.walletDetails.walletIdentifier.walletId,
        ),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletsListPresentationModel(getIt(), widget.initialParams),
          param2: getIt<WalletsListNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return SafeArea(
      top: false,
      child: Observer(
        builder: (context) {
          return ContentStateSwitcher(
            emptyChild: EmptyListMessage(
              message: strings.walletListEmptyText,
            ),
            isEmpty: model.isEmpty,
            contentChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CosmosBottomSheetHeader(
                  title: 'Wallets',
                  titleTextStyle: CosmosTextTheme.title2Bold,
                  leading: CosmosTextButton(
                    text: model.isEditingAccountList ? 'Done' : 'Edit',
                    onTap: presenter.editClicked,
                  ),
                  actions: [CosmosTextButton(text: 'Close', onTap: () => Navigator.of(context).pop())],
                ),
                SizedBox(height: theme.spacingXL),
                mainList(),
                const CosmosDivider(),
                SizedBox(height: theme.spacingL),
                CosmosCircleTextButton(
                  onTap: presenter.onTapCreateWallet,
                  text: strings.createWalletAction,
                  asset: 'assets/images/plus_circle.png',
                ),
                CosmosCircleTextButton(
                  onTap: presenter.onTapImportWallet,
                  text: strings.importWalletAction,
                  asset: 'assets/images/arrow_down_circle.png',
                ),
                SizedBox(height: theme.spacingL),
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded mainList() {
    return Expanded(
      child: CosmosWalletsListView(
        list: walletInfos,
        selectedWallet: selectedWallet,
        onClicked: (walletIndex) => presenter.walletClicked(model.wallets[walletIndex]),
        isEditing: model.isEditingAccountList,
        onEditIconPressed: (wallet) => showNotImplemented(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletsListPresenter>('presenter', presenter))
      ..add(IterableProperty<WalletInfo>('walletInfos', walletInfos))
      ..add(DiagnosticsProperty<WalletsListViewModel>('model', model))
      ..add(DiagnosticsProperty<WalletInfo>('selectedWallet', selectedWallet));
  }
}
