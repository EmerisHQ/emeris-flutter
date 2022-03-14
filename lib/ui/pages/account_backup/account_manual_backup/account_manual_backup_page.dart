import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presenter.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/widgets/manual_backup_confirm_step.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/widgets/manual_backup_intro_step.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/widgets/manual_backup_success_step.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class AccountManualBackupPage extends StatefulWidget {
  const AccountManualBackupPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final AccountManualBackupInitialParams initialParams;
  final AccountManualBackupPresenter? presenter;

  @override
  AccountManualBackupPageState createState() => AccountManualBackupPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountManualBackupInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<AccountManualBackupPresenter?>('presenter', presenter));
  }
}

class AccountManualBackupPageState extends State<AccountManualBackupPage> {
  late AccountManualBackupPresenter presenter;

  AccountManualBackupViewModel get model => presenter.viewModel;
  ReactionDisposer? _reactionDisposer;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AccountManualBackupPresentationModel(widget.initialParams),
          param2: getIt<AccountManualBackupNavigator>(),
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
