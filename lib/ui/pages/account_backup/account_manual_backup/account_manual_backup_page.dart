import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presenter.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/widgets/manual_backup_confirm_step.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/widgets/manual_backup_intro_step.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/widgets/manual_backup_success_step.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/task_scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class AccountManualBackupPage extends StatefulWidget {
  const AccountManualBackupPage({
    required this.presenter,
    required this.taskScheduler,
    Key? key,
  }) : super(key: key);

  final AccountManualBackupPresenter presenter;
  final TaskScheduler taskScheduler;

  @override
  AccountManualBackupPageState createState() => AccountManualBackupPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountManualBackupPresenter?>('presenter', presenter))
      ..add(DiagnosticsProperty<TaskScheduler>('taskScheduler', taskScheduler));
  }
}

class AccountManualBackupPageState extends State<AccountManualBackupPage> {
  AccountManualBackupPresenter get presenter => widget.presenter;

  AccountManualBackupViewModel get model => presenter.viewModel;
  ReactionDisposer? _reactionDisposer;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    _reactionDisposer = when(
      (_) => model.step == ManualBackupStep.success,
      () async {
        return widget.taskScheduler.schedule(const Duration(seconds: 3), () {
          if (mounted) {
            presenter.onTapSuccessContinue();
          }
        });
      },
    );
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
      body: SafeArea(
        child: AnimatedSwitcher(
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
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountManualBackupPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AccountManualBackupViewModel>('model', model));
  }
}
