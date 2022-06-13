import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:cosmos_ui_components/models/account_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/generated_assets/assets.gen.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AccountsListSheet extends StatefulWidget {
  const AccountsListSheet({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final AccountsListPresenter presenter;

  @override
  AccountsListSheetState createState() => AccountsListSheetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AccountsListPresenter?>('presenter', presenter));
  }
}

class AccountsListSheetState extends State<AccountsListSheet> {
  AccountsListPresenter get presenter => widget.presenter;

  AccountsListViewModel get model => presenter.viewModel;

  List<AccountInfo> get accountInfos => model.accounts.map((it) => it.accountInfo).toList();

  @override
  void initState() {
    super.initState();
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
                  title: strings.accountsTitle,
                  titleTextStyle: CosmosTextTheme.title2Bold,
                  leading: CosmosTextButton(
                    text: model.isEditingAccountList ? strings.doneAction : strings.editAction,
                    onTap: presenter.editClicked,
                  ),
                  actions: [CosmosTextButton(text: strings.closeAction, onTap: presenter.onTapClose)],
                ),
                SizedBox(height: theme.spacingXL),
                mainList(),
                const CosmosDivider(),
                SizedBox(height: theme.spacingL),
                CosmosCircleTextButton(
                  onTap: presenter.onTapCreateAccount,
                  text: strings.createAccountAction,
                  asset: Assets.imagesPlusCircle.path,
                ),
                CosmosCircleTextButton(
                  onTap: presenter.onTapImportAccount,
                  text: strings.importAccountAction,
                  asset: Assets.imagesArrowDownCircle.path,
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
        onEditIconPressed: (accountInfo) => presenter.onTapEditAccount(
          model.accounts.withId(accountInfo.accountId),
        ),
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
