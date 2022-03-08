import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_presenter.dart';
import 'package:flutter_app/ui/widgets/bullet_point_message.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/strings.dart';

class AccountBackupIntroPage extends StatefulWidget {
  const AccountBackupIntroPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final AccountBackupIntroInitialParams initialParams;
  final AccountBackupIntroPresenter? presenter;

  @override
  AccountBackupIntroPageState createState() => AccountBackupIntroPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountBackupIntroInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<AccountBackupIntroPresenter?>('presenter', presenter));
  }
}

class AccountBackupIntroPageState extends State<AccountBackupIntroPage> {
  late AccountBackupIntroPresenter presenter;

  AccountBackupIntroViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AccountBackupIntroPresentationModel(widget.initialParams, getIt()),
          param2: getIt<AccountBackupIntroNavigator>(),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                strings.backUpYourAccountTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: theme.spacingM),
              Text(
                strings.backUpYourAccountMessage,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              BulletPointMessage(
                message: strings.backUpAccountInfoMessage1,
              ),
              SizedBox(height: theme.spacingL),
              BulletPointMessage(
                message: strings.backUpAccountInfoMessage2,
              ),
              SizedBox(height: theme.spacingL),
              BulletPointMessage(
                message: strings.backUpAccountInfoMessage3,
              ),
              SizedBox(height: theme.spacingM),
              const Spacer(),
              CosmosElevatedButton(
                text: model.isIcloudAvailable ? strings.backUpIcloudAction : strings.backUpGoogleDriveAction,
                onTap: presenter.onTapCloudBackup,
              ),
              SizedBox(
                height: CosmosTheme.of(context).spacingM,
              ),
              CosmosElevatedButton(
                text: strings.backUpManuallyAction,
                onTap: presenter.onTapManualBackup,
              ),
              SizedBox(
                height: CosmosTheme.of(context).spacingM,
              ),
              CosmosTextButton(
                text: strings.backUpLaterAction,
                onTap: presenter.onTapBackupLater,
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
      ..add(DiagnosticsProperty<AccountBackupIntroPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AccountBackupIntroViewModel>('model', model));
  }
}
