import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_presenter.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/strings.dart';

class AccountNamePage extends StatefulWidget {
  const AccountNamePage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final AccountNameInitialParams initialParams;
  final AccountNamePresenter? presenter;

  @override
  AccountNamePageState createState() => AccountNamePageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountNameInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<AccountNamePresenter?>('presenter', presenter));
  }
}

class AccountNamePageState extends State<AccountNamePage> {
  late AccountNamePresenter presenter;

  AccountNameViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AccountNamePresentationModel(widget.initialParams),
          param2: getIt<AccountNameNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Scaffold(
      appBar: const EmerisLogoAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: theme.spacingL),
              Text(
                strings.nameYourAccountTitle,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: theme.spacingL),
              Text(strings.nameYourAccountMessage),
              SizedBox(height: theme.spacingXL),
              CosmosTextField(
                onChanged: presenter.onChanged,
                hint: strings.accountNameHint,
              ),
              const Spacer(),
              CosmosElevatedButton(
                text: strings.continueAction,
                onTap: presenter.onTapSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountNamePresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AccountNameViewModel>('model', model));
  }
}
