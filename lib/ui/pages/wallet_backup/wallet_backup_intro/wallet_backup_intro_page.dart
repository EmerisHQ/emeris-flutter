import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_presenter.dart';
import 'package:flutter_app/ui/widgets/bullet_point_message.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/strings.dart';

class WalletBackupIntroPage extends StatefulWidget {
  const WalletBackupIntroPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final WalletBackupIntroInitialParams initialParams;
  final WalletBackupIntroPresenter? presenter;

  @override
  WalletBackupIntroPageState createState() => WalletBackupIntroPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletBackupIntroInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<WalletBackupIntroPresenter?>('presenter', presenter));
  }
}

class WalletBackupIntroPageState extends State<WalletBackupIntroPage> {
  late WalletBackupIntroPresenter presenter;

  WalletBackupIntroViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: WalletBackupIntroPresentationModel(widget.initialParams, getIt()),
          param2: getIt<WalletBackupIntroNavigator>(),
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
                strings.backUpYourWalletTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: theme.spacingM),
              Text(
                strings.backUpYourWalletMessage,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              BulletPointMessage(
                message: strings.backUpWalletInfoMessage1,
              ),
              SizedBox(height: theme.spacingL),
              BulletPointMessage(
                message: strings.backUpWalletInfoMessage2,
              ),
              SizedBox(height: theme.spacingL),
              BulletPointMessage(
                message: strings.backUpWalletInfoMessage3,
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
      ..add(DiagnosticsProperty<WalletBackupIntroPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<WalletBackupIntroViewModel>('model', model));
  }
}
