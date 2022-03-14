import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_presenter.dart';

class AccountCloudBackupPage extends StatefulWidget {
  const AccountCloudBackupPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final AccountCloudBackupInitialParams initialParams;
  final AccountCloudBackupPresenter? presenter;

  @override
  AccountCloudBackupPageState createState() => AccountCloudBackupPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountCloudBackupInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<AccountCloudBackupPresenter?>('presenter', presenter));
  }
}

class AccountCloudBackupPageState extends State<AccountCloudBackupPage> {
  late AccountCloudBackupPresenter presenter;

  AccountCloudBackupViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AccountCloudBackupPresentationModel(widget.initialParams),
          param2: getIt<AccountCloudBackupNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('AccountCloudBackup Page'),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountCloudBackupPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AccountCloudBackupViewModel>('model', model));
  }
}
