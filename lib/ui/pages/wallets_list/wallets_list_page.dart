import 'package:flutter/material.dart';
import 'package:emeris_app/dependency_injection/app_component.dart';
import 'package:emeris_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:emeris_app/presentation/wallets_list/wallets_list_presentation_model.dart';
import 'package:emeris_app/presentation/wallets_list/wallets_list_presenter.dart';
import 'package:emeris_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:emeris_app/ui/pages/wallets_list/widgets/wallets_list_view.dart';
import 'package:emeris_app/ui/widgets/content_empty_loading_switcher.dart';
import 'package:emeris_app/ui/widgets/emeris_app_bar.dart';
import 'package:emeris_app/ui/widgets/empty_list_message.dart';
import 'package:emeris_app/utils/strings.dart';

class WalletsListPage extends StatefulWidget {
  final WalletsListInitialParams initialParams;
  final WalletsListPresenter? presenter;

  const WalletsListPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _WalletsListPageState createState() => _WalletsListPageState();
}

class _WalletsListPageState extends State<WalletsListPage> {
  late WalletsListPresenter presenter;

  WalletsListViewModel get model => presenter.viewModel;

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
    //ignore: deprecated_member_use_from_same_package
    return Scaffold(
      // Not translating this.
      appBar: const EmerisAppBar(
        title: 'Tendermint 1.0.2',
      ),
      body: ContentLoadingEmptyViewSwitcher(
          emptyChild: EmptyListMessage(
            message: strings.walletListEmptyText,
          ),
          isEmpty: model.isEmpty,
          contentChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WalletsListView(
              list: model.wallets,
              walletClicked: (wallet) => presenter.walletClicked(wallet),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => presenter.addWalletClicked(),
        label: Text(strings.importWallet),
      ),
    );
  }
}
