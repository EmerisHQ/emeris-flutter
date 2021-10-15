import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/widgets/manual_backup_confirm_step.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/widgets/manual_backup_intro_step.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/widgets/manual_backup_success_step.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

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
  ReactionDisposer? _reactionDisposer;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletManualBackupPresentationModel(widget.initialParams),
          param2: getIt<WalletManualBackupNavigator>(),
        );
    presenter.navigator.context = context;
    _reactionDisposer = when((_) => model.step == ManualBackupStep.success, () async {
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        presenter.onTapSuccessContinue();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    return _reactionDisposer?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EmerisLogoAppBar(),
      body: AnimatedSwitcher(
        duration: const ShortDuration(),
        child: Observer(
          builder: (context) {
            switch (model.step) {
              case ManualBackupStep.intro:
                return ManualBackupIntroStep(model: model, presenter: presenter);
              case ManualBackupStep.confirm:
                return ManualBackupConfirmStep(model: model, presenter: presenter);
              case ManualBackupStep.success:
                return const ManualBackupSuccessStep();
            }
          },
        ),
      ),
    );
  }
}
