import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_presenter.dart';

class WalletCloudBackupPage extends StatefulWidget {
  final WalletCloudBackupInitialParams initialParams;
  final WalletCloudBackupPresenter? presenter;

  const WalletCloudBackupPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _WalletCloudBackupPageState createState() => _WalletCloudBackupPageState();
}

class _WalletCloudBackupPageState extends State<WalletCloudBackupPage> {
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
        child: Text("WalletCloudBackup Page"),
      ),
    );
  }
}
