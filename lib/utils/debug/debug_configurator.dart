import 'package:cosmos_ui_components/components/cosmos_elevated_button.dart';
import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/utils/app_restarter.dart';
import 'package:flutter_app/utils/debug/blockchain_environment.dart';
import 'package:flutter_app/utils/debug/emeris_api_environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class DebugConfigurator {
  static bool get shouldShow => kDebugMode || kProfileMode;

  static Future<String?> _getString(String key) async => (await SharedPreferences.getInstance()).getString(key);

  static Future<bool> _setString(String key, String value) async =>
      (await SharedPreferences.getInstance()).setString(key, value);

  static const keyPrefix = 'debug_config#';

  static const lcdUrlKey = '${keyPrefix}lcd_url';
  static const lcdPortKey = '${keyPrefix}lcd_port';
  static const grpcUrlKey = '${keyPrefix}grpc_url';
  static const grpcPortKey = '${keyPrefix}grpc_port';
  static const ethUrlKey = '${keyPrefix}eth_url';
  static const emerisUrlKey = '${keyPrefix}emeris_url';

  static Future<EnvironmentConfig> loadConfiguration() async {
    return EnvironmentConfig(
      lcdUrl: await _getString(lcdUrlKey),
      lcdPort: await _getString(lcdPortKey),
      grpcUrl: await _getString(grpcUrlKey),
      grpcPort: await _getString(grpcPortKey),
      ethUrl: await _getString(ethUrlKey),
      emerisUrl: await _getString(emerisUrlKey),
    );
  }

  static Future<void> saveConfig(EnvironmentConfig environmentConfig) async {
    await _setString(lcdUrlKey, environmentConfig.networkInfo.lcdInfo.host);
    await _setString(lcdPortKey, environmentConfig.networkInfo.lcdInfo.port.toString());
    await _setString(grpcUrlKey, environmentConfig.networkInfo.grpcInfo.host);
    await _setString(grpcPortKey, environmentConfig.networkInfo.grpcInfo.port.toString());
    await _setString(ethUrlKey, environmentConfig.baseEthUrl);
    await _setString(emerisUrlKey, environmentConfig.emerisBackendApiUrl);
  }
}

class DebugConfiguratorView extends StatefulWidget {
  const DebugConfiguratorView({Key? key}) : super(key: key);

  static void show() {
    showDialog(
      context: AppNavigator.navigatorKey.currentContext!,
      builder: (context) => const DebugConfiguratorView(),
    );
  }

  @override
  State<DebugConfiguratorView> createState() => _DebugConfiguratorViewState();
}

class _DebugConfiguratorViewState extends State<DebugConfiguratorView> {
  late EnvironmentConfig _currentConfig;
  late EmerisApiEnvironment _emerisEnv;
  late BlockchainEnvironment _blockchainEnv;

  @override
  void initState() {
    super.initState();
    _currentConfig = getIt<EnvironmentConfig>();
    _emerisEnv = EmerisApiEnvironment.urlToEmerisApiEnvironment(_currentConfig.emerisBackendApiUrl);
    _blockchainEnv = BlockchainEnvironment.lcdUrlToBlockchainEnvironment(_currentConfig.networkInfo.lcdInfo.host);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(CosmosTheme.of(context).spacingL),
      child: Material(
        child: Padding(
          padding: EdgeInsets.all(CosmosTheme.of(context).spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Debug configuration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _dropdownButton<EmerisApiEnvironment>(
                title: 'Emeris Api',
                items: const [
                  DevEmerisApiEnvironment(),
                  StagingEmerisApiEnvironment(),
                  ProductionEmerisApiEnvironment(),
                ],
                value: _emerisEnv,
                onChanged: onEmerisEnvChanged,
              ),
              _dropdownButton<BlockchainEnvironment>(
                title: 'Blockchain',
                items: const [
                  LocalhostBlockchainEnvironment(),
                  TestnetBlockchainEnvironment(),
                  CosmosHubBlockchainEnvironment(),
                ],
                value: _blockchainEnv,
                onChanged: onBlockchainEnvChanged,
              ),
              const Spacer(),
              CosmosElevatedButton(
                text: 'Apply',
                onTap: onTapApply,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownButton<T extends WithTitle>({
    required String title,
    required List<T> items,
    required T value,
    required void Function(T?) onChanged,
  }) =>
      Row(
        children: [
          Text(title),
          const Spacer(),
          DropdownButton<T>(
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.title),
                  ),
                )
                .toList(),
            value: value,
            onChanged: onChanged,
          ),
        ],
      );

  void onTapApply() {
    AppRestarter.restartApp();
    DebugConfigurator.saveConfig(
      EnvironmentConfig(
        emerisUrl: _emerisEnv.url,
        lcdUrl: _blockchainEnv.lcdUrl,
        lcdPort: _blockchainEnv.lcdPort,
        grpcUrl: _blockchainEnv.grpcUrl,
        grpcPort: _blockchainEnv.grpcPort,
      ),
    );
  }

  void onEmerisEnvChanged(EmerisApiEnvironment? item) =>
      setState(() => _emerisEnv = item ?? EmerisApiEnvironment.defaultEnv);

  void onBlockchainEnvChanged(BlockchainEnvironment? item) =>
      setState(() => _blockchainEnv = item ?? BlockchainEnvironment.defaultEnv);
}

abstract class WithTitle {
  String get title;
}
