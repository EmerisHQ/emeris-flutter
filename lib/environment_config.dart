import 'package:alan/alan.dart';

//TODO refactor this to an interface
class EnvironmentConfig {
  factory EnvironmentConfig({
    String? lcdUrl,
    String? grpcUrl,
    String? lcdPort,
    String? grpcPort,
    String? ethUrl,
    String? emerisUrl,
  }) {
    // ignore: do_not_use_environment
    const envLcdPort = String.fromEnvironment('LCD_PORT', defaultValue: '1317');
    // ignore: do_not_use_environment
    const envGrpcPort = String.fromEnvironment('GRPC_PORT', defaultValue: '9091');
    // ignore: do_not_use_environment
    const envLcdUrl = String.fromEnvironment('LCD_URL', defaultValue: 'http://localhost');
    // ignore: do_not_use_environment
    const envGrpcUrl = String.fromEnvironment('GRPC_URL', defaultValue: 'http://localhost');
    // ignore: do_not_use_environment
    const envEthUrl = String.fromEnvironment('ETH_URL', defaultValue: 'HTTP://127.0.0.1:7545');
    // ignore: do_not_use_environment
    const envEmerisUrl = String.fromEnvironment('EMERIS_URL', defaultValue: 'https://dev.demeris.io');
    final grpcInfo = GRPCInfo(
      host: grpcUrl ?? envGrpcUrl,
      port: int.parse(grpcPort ?? envGrpcPort),
    );
    final lcdInfo = LCDInfo(
      host: lcdUrl ?? envLcdUrl,
      port: int.parse(lcdPort ?? envLcdPort),
    );
    return EnvironmentConfig._(
      NetworkInfo(
        bech32Hrp: 'cosmos',
        lcdInfo: lcdInfo,
        grpcInfo: grpcInfo,
      ),
      lcdInfo.fullUrl,
      ethUrl ?? envEthUrl,
      emerisUrl ?? envEmerisUrl,
    );
  }

  EnvironmentConfig._(
    this._networkInfo,
    this._baseApiUrl,
    this._baseEthUrl,
    this._emerisBackendApiUrl,
  );

  late NetworkInfo _networkInfo;
  late String _baseApiUrl;

  late String _baseEthUrl;

  late String _emerisBackendApiUrl;

  NetworkInfo get networkInfo => _networkInfo;

  String get baseApiUrl => _baseApiUrl;

  String get baseEthUrl => _baseEthUrl;

  String get emerisBackendApiUrl => _emerisBackendApiUrl;
}

abstract class SharedPreferencesKeys {
  static const isWalletCreated = 'IS_APP_INSTALLED';

  static const encryptedMnemonic = 'ENCRYPTED_MNEMONIC';
}
