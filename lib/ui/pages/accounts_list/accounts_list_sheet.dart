import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:cosmos_ui_components/models/account_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_initial_params.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AccountsListSheet extends StatefulWidget {
  const AccountsListSheet({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final AccountsListInitialParams initialParams;
  final AccountsListPresenter? presenter;

  @override
  AccountsListSheetState createState() => AccountsListSheetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountsListPresenter?>('presenter', presenter))
      ..add(DiagnosticsProperty<AccountsListInitialParams>('initialParams', initialParams));
  }
}

class AccountsListSheetState extends State<AccountsListSheet> {
  late AccountsListPresenter presenter;

  AccountsListViewModel get model => presenter.viewModel;

  List<AccountInfo> get accountInfos => model.accounts.map((it) => it.accountInfo).toList();

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AccountsListPresentationModel(getIt(), widget.initialParams),
          param2: getIt<AccountsListNavigator>(),
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
              message: strings.accountListEmptyText,
            ),
            isEmpty: model.isEmpty,
            contentChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CosmosBottomSheetHeader(
                  title: 'Accounts',
                  titleTextStyle: CosmosTextTheme.title2Bold,
                  leading: CosmosTextButton(
                    text: model.isEditingAccountList ? 'Done' : 'Edit',
                    onTap: presenter.editClicked,
                  ),
                  actions: [CosmosTextButton(text: 'Close', onTap: presenter.onTapClose)],
                ),
                SizedBox(height: theme.spacingXL),
                mainList(),
                const CosmosDivider(),
                SizedBox(height: theme.spacingL),
                CosmosCircleTextButton(
                  onTap: presenter.onTapCreateAccount,
                  text: strings.createAccountAction,
                  asset: 'assets/images/plus_circle.png',
                ),
                CosmosCircleTextButton(
                  onTap: presenter.onTapImportAccount,
                  text: strings.importAccountAction,
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
      child: CosmosAccountsListView(
        list: accountInfos,
        selectedAccount: model.selectedAccount.accountInfo,
        onClicked: (accountIndex) => presenter.accountClicked(model.accounts[accountIndex]),
        isEditing: model.isEditingAccountList,
        onEditIconPressed: presenter.onTapEditAccount,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountsListPresenter>('presenter', presenter))
      ..add(IterableProperty<AccountInfo>('accountInfos', accountInfos))
      ..add(DiagnosticsProperty<AccountsListViewModel>('model', model));
  }
}
