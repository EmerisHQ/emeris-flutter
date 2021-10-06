import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presenter.dart';

class WalletManualBackupPage extends StatefulWidget {
  final WalletManualBackupInitialParams initialParams;
  final WalletManualBackupPresenter? presenter;

  const WalletManualBackupPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _WalletManualBackupPageState createState() => _WalletManualBackupPageState();
}

class _WalletManualBackupPageState extends State<WalletManualBackupPage> {
  late WalletManualBackupPresenter presenter;

  WalletManualBackupViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletManualBackupPresentationModel(widget.initialParams),
          param2: getIt<WalletManualBackupNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("WalletManualBackup Page"),
      ),
    );
  }
}
