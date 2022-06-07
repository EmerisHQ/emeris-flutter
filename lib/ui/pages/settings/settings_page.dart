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
    return Scaffold(
      appBar: CosmosAppBar(
        title: strings.settingsTitle,
        leading: const CosmosBackButton(
          text: '',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: theme.spacingXXL),
                SettingsItem(
                  text: strings.backUpYourAccountTitle,
                  infoIcon: Image.asset('assets/images/icon_warning.png', package: packageName),
                  textStyle: CosmosTextTheme.actionSheetItem,
                  onTap: presenter.onTapBackup,
                ),
                SizedBox(height: theme.spacingL),
                SettingsItem(
                  text: strings.securityAction,
                  textStyle: CosmosTextTheme.actionSheetItem,
                  onTap: () => notImplemented(context),
                ),
                SizedBox(height: theme.spacingXL),
                const CosmosDivider(),
                SizedBox(height: theme.spacingXL),
                SettingsItem(
                  text: strings.currencyAction,
                  textStyle: CosmosTextTheme.actionSheetItem,
                  infoIcon: const ChipText(title: '#USD'),
                  onTap: presenter.onTapCurrency,
                ),
                SizedBox(height: theme.spacingXL),
                const CosmosDivider(),
                SizedBox(height: theme.spacingXL),
                SettingsItem(
                  text: strings.communityAction,
                  textStyle: CosmosTextTheme.copyMinus1Normal,
                  onTap: presenter.onTapCommunity,
                ),
                SettingsItem(
                  text: strings.twitterAction,
                  textStyle: CosmosTextTheme.copyMinus1Normal,
                  onTap: presenter.onTapTwitter,
                ),
                SettingsItem(
                  text: strings.supportAction,
                  textStyle: CosmosTextTheme.copyMinus1Normal,
                  onTap: presenter.onTapSupport,
                ),
                SizedBox(height: theme.spacingXL),
              ],
            ),
          ),
          const CosmosDivider(),
          Padding(
            padding: EdgeInsets.only(bottom: theme.spacingXL),
            child: SettingsItem(
              text: strings.signOutAction,
              showArrow: false,
              textStyle: CosmosTextTheme.copyMinus1Normal.copyWith(color: theme.colors.error),
              onTap: presenter.onTapSignOut,
              infoIcon: AppVersionText(appInfoProvider: AppInfoProvider()),
            ),
          ),
          MinimalBottomSpacer(padding: theme.spacingXXXL)
        ],
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
