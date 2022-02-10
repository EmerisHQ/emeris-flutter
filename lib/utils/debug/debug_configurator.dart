import 'package:flutter/foundation.dart';
import 'package:flutter_app/environment_config.dart';
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

abstract class WithTitle {
  String get title;
}
