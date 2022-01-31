import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_presenter.dart';

class WalletCloudBackupPage extends StatefulWidget {
  const WalletCloudBackupPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final WalletCloudBackupInitialParams initialParams;
  final WalletCloudBackupPresenter? presenter;

  @override
  WalletCloudBackupPageState createState() => WalletCloudBackupPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletCloudBackupInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<WalletCloudBackupPresenter?>('presenter', presenter));
  }
}

class WalletCloudBackupPageState extends State<WalletCloudBackupPage> {
  late WalletCloudBackupPresenter presenter;

  WalletCloudBackupViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletCloudBackupPresentationModel(widget.initialParams),
          param2: getIt<WalletCloudBackupNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('WalletCloudBackup Page'),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletCloudBackupPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<WalletCloudBackupViewModel>('model', model));
  }
}
