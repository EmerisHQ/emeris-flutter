import 'package:cosmos_ui_components/components/cosmos_elevated_button.dart';
import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
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
  final WalletBackupIntroInitialParams initialParams;
  final WalletBackupIntroPresenter? presenter;

  const WalletBackupIntroPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _WalletBackupIntroPageState createState() => _WalletBackupIntroPageState();
}

class _WalletBackupIntroPageState extends State<WalletBackupIntroPage> {
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
    return Scaffold(
      appBar: const EmerisLogoAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(CosmosAppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.backUpYourWalletTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: CosmosAppTheme.spacingM),
            Text(
              strings.backUpYourWalletMessage,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            BulletPointMessage(
              message: strings.backUpWalletInfoMessage1,
            ),
            const SizedBox(height: CosmosAppTheme.spacingL),
            BulletPointMessage(
              message: strings.backUpWalletInfoMessage2,
            ),
            const SizedBox(height: CosmosAppTheme.spacingL),
            BulletPointMessage(
              message: strings.backUpWalletInfoMessage3,
            ),
            const SizedBox(height: CosmosAppTheme.spacingM),
            const Spacer(),
            CosmosElevatedButton(
              text: model.isIcloudAvailable ? strings.backUpIcloudAction : strings.backUpGoogleDriveAction,
              onTap: presenter.onTapCloudBackup,
            ),
            CosmosElevatedButton(
              text: strings.backUpManuallyAction,
              onTap: presenter.onTapManualBackup,
            ),
            CosmosTextButton(
              text: strings.backUpLaterAction,
              onTap: presenter.onTapBackupLater,
            ),
          ],
        ),
      ),
    );
  }
}
