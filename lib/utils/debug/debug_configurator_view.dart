import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/utils/app_restarter.dart';
import 'package:flutter_app/utils/debug/blockchain_environment.dart';
import 'package:flutter_app/utils/debug/debug_configurator.dart';
import 'package:flutter_app/utils/debug/emeris_api_environment.dart';

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
