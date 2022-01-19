import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presenter.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/utils/strings.dart';

class WalletsListSheet extends StatefulWidget {
  final WalletsListInitialParams initialParams;
  final WalletsListPresenter? presenter;

  const WalletsListSheet({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _WalletsListSheetState createState() => _WalletsListSheetState();
}

class _WalletsListSheetState extends State<WalletsListSheet> {
  late WalletsListPresenter presenter;

  WalletsListViewModel get model => presenter.viewModel;

  bool isEditingAccountList = false;

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
      child: ContentStateSwitcher(
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
                text: isEditingAccountList ? 'Done' : 'Edit',
                onTap: () => setState(() {
                  isEditingAccountList = !isEditingAccountList;
                }),
              ),
              actions: [CosmosTextButton(text: 'Close', onTap: () => Navigator.of(context).pop())],
            ),
            SizedBox(height: theme.spacingXL),
            _buildMainList(),
            const CosmosDivider(),
            SizedBox(height: theme.spacingL),
            CosmosCircleTextButton(
              onTap: () {},
              text: 'Create account',
              asset: 'assets/images/plus_circle.png',
            ),
            CosmosCircleTextButton(
              onTap: () {},
              text: 'Import account',
              asset: 'assets/images/arrow_down_circle.png',
            ),
            SizedBox(height: theme.spacingL),
          ],
        ),
      ),
    );
  }

  Expanded _buildMainList() {
    return Expanded(
      child: CosmosWalletsListView(
        list: walletInfos,
        selectedWallet: walletInfos.first,
        onClicked: (walletIndex) => presenter.walletClicked(model.wallets[walletIndex]),
        isEditing: isEditingAccountList,
        onEditIconPressed: (wallet) {},
      ),
    );
  }
}
