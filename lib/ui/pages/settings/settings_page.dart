import 'package:cosmos_ui_components/components/template/settings_item.dart';
import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/settings/settings_presentation_model.dart';
import 'package:flutter_app/ui/pages/settings/settings_presenter.dart';
import 'package:flutter_app/utils/strings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);
  final SettingsPresenter presenter;

  @override
  State<SettingsPage> createState() => _SettingsPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SettingsPresenter>('presenter', presenter));
  }
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsPresenter get presenter => widget.presenter;

  SettingsViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    final textStyle = CosmosTextTheme.copy0Normal.copyWith(color: theme.colors.link);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CosmosBottomSheetHeader(
              title: strings.settingsTitle,
              titleTextStyle: CosmosTextTheme.title2Bold,
              leading: const Icon(Icons.ten_k, color: Colors.transparent),
              actions: [
                CosmosTextButton(
                  text: strings.closeAction,
                  onTap: presenter.onTapClose,
                ),
              ],
            ),
            SizedBox(height: theme.spacingXXL),
            SettingsItem(
              text: strings.backUpYourAccountTitle,
              infoIcon: Image.asset('assets/images/icon_warning.png', package: packageName),
              textStyle: CosmosTextTheme.copy0Normal,
              onTap: presenter.onTapBackup,
            ),
            SettingsItem(
              text: strings.securityAction,
              textStyle: CosmosTextTheme.copy0Normal,
              onTap: () => notImplemented(context),
            ),
            SettingsItem(
              text: strings.currencyAction,
              textStyle: CosmosTextTheme.copy0Normal,
              infoIcon: const ChipText(title: '#USD'),
              onTap: presenter.onTapCurrency,
            ),
            SizedBox(height: theme.spacingXL),
            SettingsItem(
              text: strings.communityAction,
              textStyle: textStyle,
              onTap: presenter.onTapCommunity,
            ),
            SettingsItem(
              text: strings.twitterAction,
              textStyle: textStyle,
              onTap: presenter.onTapTwitter,
            ),
            SettingsItem(
              text: strings.supportAction,
              textStyle: textStyle,
              onTap: presenter.onTapSupport,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: theme.spacingXL),
              child: SettingsItem(
                text: strings.signOutAction,
                showArrow: false,
                textStyle: textStyle.copyWith(color: theme.colors.error),
                onTap: presenter.onTapSignOut,
                infoIcon: AppVersionText(appInfoProvider: AppInfoProvider()),
              ),
            ),
            MinimalBottomSpacer(padding: theme.spacingXXXL)
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<SettingsPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<SettingsViewModel>('model', model));
  }
}

// TODO: Remove these widgets

class AppVersionText extends StatelessWidget {
  const AppVersionText({required this.appInfoProvider, Key? key}) : super(key: key);
  final AppInfoProvider appInfoProvider;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AppInfoProvider>('appInfoProvider', appInfoProvider));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: appInfoProvider.getAppVersion(),
        builder: (context, snapshot) => Text(snapshot.data ?? ''),
      );
}

class ChipText extends StatelessWidget {
  const ChipText({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Container(
      padding: EdgeInsets.all(theme.spacingM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colors.chipBackground,
      ),
      child: Text(title),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
  }
}
